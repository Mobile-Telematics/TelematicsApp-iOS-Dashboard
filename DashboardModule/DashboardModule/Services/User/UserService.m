//
//  UserService.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "UserService.h"
#import "AppDelegate.h"
#import "ProfileResponse.h"
#import "ProfileRequestData.h"

@interface UserService ()

@property (strong, nonatomic) ZenAppModel                       *appModel;

@property (nonatomic, assign) BOOL                              isLoggedOn;
@property (nonatomic, copy) NSString*                           token;
@property (nonatomic, copy) NSString*                           refreshToken;
@property (nonatomic, copy) NSString*                           virtualDeviceToken;
@property (nonatomic, strong) ProfileResponse                   *profile;

@end

@implementation UserService

+ (instancetype)sharedService {
    static UserService *_sharedService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedService = [[UserService alloc] init];
        [_sharedService loadCredentials];
    });
    return _sharedService;
}

- (void)saveCredentials {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *fileTokenKey = [NSString stringWithFormat:@"%@/authBearerTokenKey.txt", documentsDirectory];
    NSString *contentTK = self.token;
    [contentTK writeToFile:fileTokenKey atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];

    NSString *fileRefreshKey = [NSString stringWithFormat:@"%@/authBearerRefreshTokenKey.txt", documentsDirectory];
    NSString *contentRT = self.refreshToken;
    [contentRT writeToFile:fileRefreshKey atomically:NO encoding:NSStringEncodingConversionAllowLossy error:nil];

    defaults_set_object(@"authVirtualDeviceTokenKey", self.virtualDeviceToken);
}

- (void)loadCredentials {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];

    NSString *fileTokenKey = [NSString stringWithFormat:@"%@/authBearerTokenKey.txt", documentsDirectory];
    NSString *contentTK = [[NSString alloc] initWithContentsOfFile:fileTokenKey usedEncoding:nil error:nil];
    self.token = contentTK;

    NSString *fileRefreshKey = [NSString stringWithFormat:@"%@/authBearerRefreshTokenKey.txt", documentsDirectory];
    NSString *contentRT = [[NSString alloc] initWithContentsOfFile:fileRefreshKey usedEncoding:nil error:nil];
    self.refreshToken = contentRT;

    self.virtualDeviceToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"authVirtualDeviceTokenKey"];
    
    if (self.token) {
        self.isLoggedOn = YES;
    }
}

- (void)loadProfile {
    [[MainApiRequest requestWithCompletion:^(id response, NSError *error) {
        if (!error && [response isSuccesful]) {
            self.profile = response;
            
            self.appModel = [ZenAppModel MR_findFirstByAttribute:@"current_user" withValue:@1];
            
            self.appModel.userFirstName = self.profile.Result.UserProfile.FirstName ? self.profile.Result.UserProfile.FirstName : @"";
            self.appModel.userFamilyName = self.profile.Result.UserProfile.LastName ? self.profile.Result.UserProfile.LastName : @"";
            self.appModel.userFullName = [NSString stringWithFormat:@"%@ %@", self.appModel.userFirstName, self.appModel.userFamilyName];
            
            self.appModel.userPhone = self.profile.Result.UserProfile.Phone;
            self.appModel.userEmail = self.profile.Result.UserProfile.Email;
            self.appModel.userBirthday = self.profile.Result.UserProfile.Birthday;
            self.appModel.userMarital = self.profile.Result.UserProfile.MaritalStatus;
            self.appModel.userChildren = self.profile.Result.UserProfile.ChildrenCount.stringValue;
            self.appModel.userAddress = self.profile.Result.UserProfile.Address;
            self.appModel.userGender = self.profile.Result.UserProfile.Gender;
            self.appModel.userNickname = self.profile.Result.UserProfile.Nickname;
            self.appModel.userAvatarLink = self.profile.Result.UserProfile.ImageUrl;
            
//            NSDictionary *userFields = [self.profile.Result.UserFields objectAtIndex:1];
//            if (![[userFields valueForKey:@"ClientId"] isEqual:[NSNull null]]) {
//                self.appModel.userInsurerId = [userFields valueForKey:@"ClientId"];
//            }
            
            dispatch_async(dispatch_get_global_queue(0,0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:self.profile.Result.UserProfile.ImageUrl]];
                if (data != nil) {
                    self.appModel.userPhotoData = data;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:self];
                
                #if !TARGET_IPHONE_SIMULATOR
                    if ([Configurator sharedInstance].sNeedIntercom) {
                        [self autoRegisterIntercomUser];
                    }
                #endif
            });
        }
    }] getUserProfile];
}


#pragma mark Events Preload

- (void)loadMainUserRequests {
    NSDate *date = [NSDate new];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSObject *savedLastMomentObject = defaults_object(@"lastAppFetchUserProfile");
    
    if (savedLastMomentObject != nil) {
        NSDate *savedLastMomentReloading = defaults_object(@"lastAppFetchUserProfile");
        int differenceInMilliSec = (int)([calendar ordinalityOfUnit:NSCalendarUnitSecond inUnit:NSCalendarUnitEra forDate:date] - [calendar ordinalityOfUnit:NSCalendarUnitSecond inUnit:NSCalendarUnitEra forDate:savedLastMomentReloading]);
        
        if (differenceInMilliSec < 0)
            differenceInMilliSec = 501;
        NSLog(@"!!!LAST USERPROFILE FETCH %d!!!", differenceInMilliSec);
        
        if (differenceInMilliSec >= 500) {
            defaults_set_object(@"lastAppFetchUserProfile", date);
            [self loadProfile];
        }
    } else {
        defaults_set_object(@"lastAppFetchUserProfile", date);
        [self loadProfile];
    }
}


#pragma mark Login/Logout

- (void)loginWithSecretKeys:(NSString*)deviceToken jwToken:(NSString *)jwToken refreshToken:(NSString *)refreshToken {
    self.isLoggedOn = YES;
    self.token = jwToken;
    self.refreshToken = refreshToken;
    self.virtualDeviceToken = deviceToken;
    [self saveCredentials];
    
    //[[AppDelegate appDelegate] updateDashboardController];
    [self loadProfile];
}

- (void)refreshJWToken:(NSString *)jwToken refreshToken:(NSString *)refreshToken {
    self.token = jwToken;
    self.refreshToken = refreshToken;
    self.virtualDeviceToken = defaults_object(@"authVirtualDeviceTokenKey");
    [self saveCredentials];
}

- (void)logout {
    
    NSString *restoreToken = defaults_object(@"confirmed_device_token");
    
    [ZenAppModel MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"current_user == 1"]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileTokenKey = [NSString stringWithFormat:@"%@/authBearerTokenKey.txt", documentsDirectory];
    [[NSFileManager defaultManager] removeItemAtPath:fileTokenKey error:nil];

    NSString *fileRefreshKey = [NSString stringWithFormat:@"%@/authBearerRefreshTokenKey.txt", documentsDirectory];
    [[NSFileManager defaultManager] removeItemAtPath:fileRefreshKey error:nil];
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    [defs setBool:YES forKey:@"needOnboard"];
    [defs removeObjectForKey:@"fcmToken"];
    [defs removeObjectForKey:@"authBearerTokenKey"];
    [defs removeObjectForKey:@"authBearerRefreshTokenKey"];
    [defs removeObjectForKey:@"authVirtualDeviceTokenKey"];
    [defs removeObjectForKey:@"counterRefreshKey"];
    [defs removeObjectForKey:@"counterMainReset"];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [defs removePersistentDomainForName:appDomain];
    [defs synchronize];
    
    [[RPEntry instance] removeVirtualDeviceToken];
    
    self.isLoggedOn = NO;
    self.token = nil;
    self.refreshToken = nil;
    self.virtualDeviceToken = nil;
    self.profile = nil;
    
    defaults_set_object(@"userLogOuted", @(YES));
    defaults_set_object(@"userLogOutedManually", @(YES));
    defaults_set_object(@"userNeedUpdatesForOnboarding", @(YES));
    defaults_set_object(@"confirmed_device_token", restoreToken);
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    
    [[AppDelegate appDelegate] updateDashboardController];
}

- (void)logout419 {
    
    NSString *restoreToken = defaults_object(@"confirmed_device_token");
    
    [ZenAppModel MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"current_user == 1"]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileTokenKey = [NSString stringWithFormat:@"%@/authBearerTokenKey.txt", documentsDirectory];
    [[NSFileManager defaultManager] removeItemAtPath:fileTokenKey error:nil];

    NSString *fileRefreshKey = [NSString stringWithFormat:@"%@/authBearerRefreshTokenKey.txt", documentsDirectory];
    [[NSFileManager defaultManager] removeItemAtPath:fileRefreshKey error:nil];
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    [defs setBool:YES forKey:@"needOnboard"];
    [defs removeObjectForKey:@"fcmToken"];
    [defs removeObjectForKey:@"authBearerTokenKey"];
    [defs removeObjectForKey:@"authBearerRefreshTokenKey"];
    [defs removeObjectForKey:@"authVirtualDeviceTokenKey"];
    [defs removeObjectForKey:@"counterRefreshKey"];
    [defs removeObjectForKey:@"counterMainReset"];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [defs removePersistentDomainForName:appDomain];
    [defs synchronize];
    
    [[RPEntry instance] removeVirtualDeviceToken];
    
    self.isLoggedOn = NO;
    self.token = nil;
    self.refreshToken = nil;
    self.virtualDeviceToken = nil;
    self.profile = nil;
    
    defaults_set_object(@"userLogOuted", @(YES));
    defaults_set_object(@"userLogOutedManually", @(NO));
    defaults_set_object(@"userNeedUpdatesForOnboarding", @(YES));
    defaults_set_object(@"confirmed_device_token", restoreToken);
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    
    [[AppDelegate appDelegate] updateDashboardController];
}

- (void)updateInfoProfileUser:(NSString *)email name:(NSString *)name {
    ProfileRequestData* postEmailName = [[ProfileRequestData alloc] init];
    postEmailName.email = email;
    postEmailName.firstName = name;
    
    [[MainApiRequest requestWithCompletion:^(id response, NSError *error) {
        if (!error && [response isSuccesful]) {
            [[UserService sharedService] loadProfile];
        }
    }] updateProfile:postEmailName];
}

@end
