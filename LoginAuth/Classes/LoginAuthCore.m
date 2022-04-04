//
//  LoginAuthCore.m
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LoginAuthCore.h"
#import "LoginAuthApiRequest.h"
#import "LARegPhoneRequestData.h"
#import "LARootResponse.h"
#import "LARegResponse.h"
#import "LARefreshTokenRequestData.h"
#import "LARefreshTokenResponse.h"
#import "LALoginPhoneRequestData.h"
#import "LAProfileResponse.h"
#import "LAProfileRequestData.h"
#import "LANSUserDefaults-helper.h"
#import "DashMainViewController.h"
#import "MagicalRecord.h"
//#import "ZenAppModel.h"

static NSString * const kRecipesStoreName = @"Model.sqlite";

@implementation LoginAuthCore

+ (id)sharedManager {
    static LoginAuthCore *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
//        [MagicalRecord setupCoreDataStackWithStoreNamed:kRecipesStoreName];
//        NSLog(@"XXXXXXXXXXX");
//        if (![defaults_object(@"ZenRoadShouldMigrate100") boolValue]) {
//            NSLog(@"MMMMMMMMMMM");
//            //[ZenAppModel MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"current_user == 1"]];
//            NSLog(@"SSSSSSSS");
//
//            [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:kRecipesStoreName];
//            //[MagicalRecord setupAutoMigratingCoreDataStack];
//            defaults_set_object(@"ZenRoadShouldMigrate100", @(YES));
//        }
    });
    return sharedMyManager;
}

- (void)setCredentials:(NSString *)deviceToken
           accessToken:(NSString *)accessToken {
    
    //[MagicalRecord setupCoreDataStackWithStoreNamed:kRecipesStoreName];
    
    
    
    //NSBundle *bundle = [NSBundle bundleForClass:[DashMainViewController class]];
    //DashMainViewController *dashVC = [[UIStoryboard storyboardWithName:@"DashboardDelivery" bundle:bundle] instantiateInitialViewController];
    ///[self presentViewController:dashVC animated:YES completion:nil];
    ///
    ///
    ///
    
    //UIViewController *currentTopVC = [self currentTopViewController];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DashboardDelivery" bundle:[NSBundle bundleForClass:DashMainViewController.class]];

    DashMainViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"DashMainViewController"];
    
    UIViewController *currentTopVC = [self currentTopViewController];
    [currentTopVC presentViewController:controller animated:NO completion:nil];
}

- (void)setHereMapApiKey:(NSString *)apiKey {
    
}
    
- (void)createDeviceTokenForUserWithInstanceId:(NSString *)instanceId
                                   instanceKey:(NSString *)instanceKey
                                        result:(void (^)(NSString *, NSString *, NSString *))completion {
    
    defaults_set_object(@"InstanceIdHeader", instanceId);
    defaults_set_object(@"InstanceKeyHeader", instanceKey);
    defaults_set_object(@"OldJWTokenHeader", nil);
    
    LARegPhoneRequestData* regData = [[LARegPhoneRequestData alloc] init];
    
    [[LoginAuthApiRequest requestWithCompletion:^(id response, NSError *error) {
        if ([response isSuccesful]) {
            
            NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<SUCCESS CREATED: RESPONSE %d", ((LARootResponse*)response).Status.intValue);
            
            self.successCreateCompletionBlock = completion;
            
            if (self.successCreateCompletionBlock) {
                NSLog(@"Success created user with\ndeviceToken: %@\nJWToken: %@\nrefreshToken: %@", ((LARegResponse*)response).Result.DeviceToken, ((LARegResponse*)response).Result.AccessToken.Token, ((LARegResponse*)response).Result.RefreshToken);
                
                self.successCreateCompletionBlock(((LARegResponse*)response).Result.DeviceToken, ((LARegResponse*)response).Result.AccessToken.Token, ((LARegResponse*)response).Result.RefreshToken);
            }
            
        } else {
            NSLog(@"ERROR - Failed create User\n%@", error);
        }
    }] registerUserWithParameters:regData];
}


- (void)refreshJWTokenForUserWith:(NSString *)jwToken
                     refreshToken:(NSString *)refreshToken
                           result:(void (^)(NSString *, NSString *))completion {
    
    defaults_set_object(@"OldJWTokenHeader", jwToken);
    
    LARefreshTokenRequestData* refreshData = [[LARefreshTokenRequestData alloc] init];
    refreshData.accessToken =  jwToken;
    refreshData.refreshToken = refreshToken;
    
    [[LoginAuthApiRequest requestWithCompletion:^(id response, NSError *error) {
        if ([response isSuccesful] && ((LARootResponse*)response).Status.intValue != 400) {
            
            NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<SUCCESS REFRESH TOKEN ONCE: RESPONSE %d", ((LARootResponse*)response).Status.intValue);
            
            self.successRefreshCompletionBlock = completion;
            
            if (self.successRefreshCompletionBlock) {
                NSLog(@"Success refresh new JWToken: %@\nrefreshToken: %@", ((LARefreshTokenResponse*)response).Result.AccessToken.Token, ((LARefreshTokenResponse*)response).Result.RefreshToken);
                
                self.successRefreshCompletionBlock(((LARefreshTokenResponse*)response).Result.AccessToken.Token, ((LARefreshTokenResponse*)response).Result.RefreshToken);
            }
            
        } else {
            NSLog(@"ERROR - Failed refresh JWToken\n%@", error);
        }

    }] refreshJWToken:refreshData];
}


- (void)getJWTokenForUserWithDeviceToken:(NSString *)deviceToken
                              instanceId:(NSString *)instanceId
                             instanceKey:(NSString *)instanceKey
                                  result:(void (^)(NSString *, NSString *))completion {
    
    defaults_set_object(@"InstanceIdHeader", instanceId);
    defaults_set_object(@"InstanceKeyHeader", instanceKey);
    defaults_set_object(@"OldJWTokenHeader", nil);
    
    LALoginPhoneRequestData* loginData = [[LALoginPhoneRequestData alloc] init];
    loginData.loginFields = @{@"DeviceToken": deviceToken};
    loginData.password = instanceKey;
    
    [[LoginAuthApiRequest requestWithCompletion:^(id response, NSError *error) {
        
        if ([response isSuccesful]) {
            
            NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<SUCCESS GET NEW JWT: RESPONSE %d", ((LARootResponse*)response).Status.intValue);
            
            self.successGetNewJwtByDeviceTokenCompletionBlock = completion;
            
            if (self.successGetNewJwtByDeviceTokenCompletionBlock) {
                NSLog(@"Success get new JWToken: %@\nrefreshToken: %@", ((LARefreshTokenResponse*)response).Result.AccessToken.Token, ((LARefreshTokenResponse*)response).Result.RefreshToken);
                
                self.successGetNewJwtByDeviceTokenCompletionBlock(((LARefreshTokenResponse*)response).Result.AccessToken.Token, ((LARefreshTokenResponse*)response).Result.RefreshToken);
            }
        } else {
            NSLog(@"ERROR - Failed get JWToken by DeviceToken\n%@", error);
        }
    }] getJWTokenByDeviceToken:loginData];
    
}


- (void)createDeviceTokenForUserWithParametersAndInstanceId:(NSString *)instanceId
                                                instanceKey:(NSString *)instanceKey
                                                      email:(NSString *)email
                                                      phone:(NSString *)phone
                                                  firstName:(NSString *)firstName
                                                   lastName:(NSString *)lastName
                                                    address:(NSString *)address
                                                   birthday:(NSString *)birthday
                                                     gender:(NSString *)gender
                                              maritalStatus:(NSString *)maritalStatus
                                              childrenCount:(NSNumber *)childrenCount
                                                   clientId:(NSString *)clientId
                                                     result:(void (^)(NSString *, NSString *, NSString *))completion {
    
    defaults_set_object(@"InstanceIdHeader", instanceId);
    defaults_set_object(@"InstanceKeyHeader", instanceKey);
    defaults_set_object(@"OldJWTokenHeader", nil);
    
    LARegPhoneRequestData* regData = [[LARegPhoneRequestData alloc] init];
    regData.email = email;
    regData.phone = phone;
    regData.firstName = firstName;
    regData.lastName = lastName;
    regData.address = address;
    regData.birthday = birthday;
    regData.gender = gender;
    regData.maritalStatus = maritalStatus;
    regData.childrenCount = childrenCount;
    regData.userFields = @{@"ClientId": clientId};
    
    [[LoginAuthApiRequest requestWithCompletion:^(id response, NSError *error) {
        if ([response isSuccesful]) {
            
            NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<SUCCESS CREATED WITH PARAMETERS: RESPONSE %d", ((LARootResponse*)response).Status.intValue);
            
            NSLog(@"Success created user with parameters\ndeviceToken: %@\nJWToken: %@\nrefreshToken: %@", ((LARegResponse*)response).Result.DeviceToken, ((LARegResponse*)response).Result.AccessToken.Token, ((LARegResponse*)response).Result.RefreshToken);
            
            self.successCreateCompletionBlock = completion;
            
            self.successCreateCompletionBlock(((LARegResponse*)response).Result.DeviceToken, ((LARegResponse*)response).Result.AccessToken.Token, ((LARegResponse*)response).Result.RefreshToken);
            
        } else {
            NSLog(@"ERROR - Failed create User with parameters\n%@", error);
        }
    }] registerUserWithParameters:regData];
}


- (void)getUserProfileWithInstanceId:(NSString *)instanceId
                         instanceKey:(NSString *)instanceKey
                             jwToken:(NSString *)jwToken
                              result:(void (^)(NSString* email,
                                               NSString* phone,
                                               NSString* firstName,
                                               NSString* lastName,
                                               NSString* address,
                                               NSString* birthday,
                                               NSString* gender,
                                               NSString* maritalStatus,
                                               NSNumber* childrenCount,
                                               NSString* clientId))completion {
    
    defaults_set_object(@"InstanceIdHeader", instanceId);
    defaults_set_object(@"InstanceKeyHeader", instanceKey);
    defaults_set_object(@"OldJWTokenHeader", jwToken);
    
    [[LoginAuthApiRequest requestWithCompletion:^(id response, NSError *error) {
        if (!error && [response isSuccesful]) {
            
            self.userProfileGetCompletionBlock = completion;
            
            if (self.userProfileGetCompletionBlock) {
                NSLog(@"Success fetch User Profile");
                
                NSString *clId = @"";
                NSDictionary *userFields = [((LAProfileResponse*)response).Result.UserFields objectAtIndex:0];
                if (![[userFields valueForKey:@"ClientId"] isEqual:[NSNull null]]) {
                    clId = [userFields valueForKey:@"ClientId"];
                }
                
                self.userProfileGetCompletionBlock(((LAProfileResponse*)response).Result.UserProfile.Email, ((LAProfileResponse*)response).Result.UserProfile.Phone, ((LAProfileResponse*)response).Result.UserProfile.FirstName, ((LAProfileResponse*)response).Result.UserProfile.LastName, ((LAProfileResponse*)response).Result.UserProfile.Address, ((LAProfileResponse*)response).Result.UserProfile.Birthday, ((LAProfileResponse*)response).Result.UserProfile.Gender, ((LAProfileResponse*)response).Result.UserProfile.MaritalStatus, ((LAProfileResponse*)response).Result.UserProfile.ChildrenCount, clId);
            }
            
        } else {
            NSLog(@"ERROR - Failed fetch User Profile \n%@", error);
        }
    }] getUserProfile];
}


- (void)updateUserProfileWithParametersAndInstanceId:(NSString *)instanceId
                                         instanceKey:(NSString *)instanceKey
                                             jwToken:(NSString *)jwToken
                                               email:(NSString *)userEmail
                                               phone:(NSString *)userPhone
                                           firstName:(NSString *)firstName
                                            lastName:(NSString *)lastName
                                             address:(NSString *)address
                                            birthday:(NSString *)birthday
                                              gender:(NSString *)gender
                                       maritalStatus:(NSString *)maritalStatus
                                       childrenCount:(NSNumber *)childrenCount
                                            clientId:(NSString *)clientId
                                              result:(void (^)(NSString *))completion {
    
    defaults_set_object(@"InstanceIdHeader", instanceId);
    defaults_set_object(@"InstanceKeyHeader", instanceKey);
    defaults_set_object(@"OldJWTokenHeader", jwToken);
    
    LAProfileRequestData* userData = [[LAProfileRequestData alloc] init];
    userData.email = userEmail;
    userData.phone = userPhone;
    userData.firstName = firstName;
    userData.firstName = firstName;
    userData.lastName = lastName;
    userData.birthday = birthday;
    userData.maritalStatus = maritalStatus;
    userData.childrenCount = childrenCount;
    userData.gender = gender;
    userData.address = address;
    userData.MobileName = [UIDevice currentDevice].name;
    userData.MobileOsType = [UIDevice currentDevice].systemName;
    userData.OldPassword = @"";
    userData.NewPassword = @"";
    if (clientId != nil) {
        userData.UserFields = @{@"ClientId": clientId};
    }
    
    
    [[LoginAuthApiRequest requestWithCompletion:^(id response, NSError *error) {
        if (!error && [response isSuccesful]) { //if ([response isSuccesful]) {
            
            self.userProfileUpdateCompletionBlock = completion;
            
            if (self.userProfileUpdateCompletionBlock) {
                NSLog(@"Success update User Profile");
                self.userProfileUpdateCompletionBlock(@"Success");
            }
        } else {
            NSLog(@"ERROR - Failed update User Profile \n%@", error);
        }
    }] updateProfile:userData];
}


- (void)createDeviceTokenForUserWithInviteCodeAndInstanceId:(NSString *)instanceId
                                                instanceKey:(NSString *)instanceKey
                                                 inviteCode:(NSString *)inviteCode
                                                   clientId:(NSString *)clientId
                                                     result:(void (^)(NSString *, NSString *, NSString *))completion {
    
    defaults_set_object(@"InstanceIdHeader", instanceId);
    defaults_set_object(@"InstanceKeyHeader", instanceKey);
    defaults_set_object(@"OldJWTokenHeader", nil);
    
    LARegPhoneRequestData* regData = [[LARegPhoneRequestData alloc] init];
    regData.InstanceInviteCode = inviteCode;
    regData.userFields = @{@"ClientId": clientId};
    
    [[LoginAuthApiRequest requestWithCompletion:^(id response, NSError *error) {
        if ([response isSuccesful]) {
            
            NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<SUCCESS CREATED WITH PARAMETERS: RESPONSE %d", ((LARootResponse*)response).Status.intValue);
            
            NSLog(@"Success created user with parameters\ndeviceToken: %@\nJWToken: %@\nrefreshToken: %@", ((LARegResponse*)response).Result.DeviceToken, ((LARegResponse*)response).Result.AccessToken.Token, ((LARegResponse*)response).Result.RefreshToken);
            
            self.successCreateCompletionBlock = completion;
            
            self.successCreateCompletionBlock(((LARegResponse*)response).Result.DeviceToken, ((LARegResponse*)response).Result.AccessToken.Token, ((LARegResponse*)response).Result.RefreshToken);
            
        } else {
            NSLog(@"ERROR - Failed create User with parameters\n%@", error);
        }
    }] registerUserWithParameters:regData];
}


#pragma mark - View Detecting

- (UIViewController *)currentTopViewController {
    UIViewController *topVC = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

@end
