//
//  AppDelegate.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 09.06.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "AppDelegate.h"
#import "JSONModel.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Configurator.h"
#import "Helpers.h"
#import "WiFiGPSChecker.h"
#import "ProfileRequestData.h"
#import <NMAKit/NMAKit.h>
#import <AdSupport/AdSupport.h>
#import <LoginAuth/LoginAuth.h>

static NSString * const kRecipesStoreName = @"Model.sqlite";


@interface AppDelegate () <RPTrackingStateListenerDelegate, RPAccuracyAuthorizationDelegate, RPLowPowerModeDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [Configurator setAppearance];
    
    [MagicalRecord setupCoreDataStackWithStoreNamed:kRecipesStoreName];
    if (![defaults_object(@"CoreDataStack100") boolValue]) {
        [ZenAppModel MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:@"current_user == 1"]];
        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:kRecipesStoreName];
        defaults_set_object(@"CoreDataStack100", @(YES));
    }
    
    [RPEntry initializeWithRequestingPermissions:NO];
    [RPEntry instance].trackingStateDelegate = self;
    [RPEntry instance].lowPowerModeDelegate = self;
    [RPEntry instance].accuracyAuthorizationDelegate = self;
    
    if ([defaults_object(@"needTrackingOn") boolValue]) {
        
        NSLog(@"%@", [UserService sharedService].virtualDeviceToken);
        [RPEntry instance].virtualDeviceToken = [UserService sharedService].virtualDeviceToken;
        
        [RPEntry enableHF:YES];

        if ([RPEntry instance].virtualDeviceToken.length > 0) {
            [RPEntry initializeWithRequestingPermissions:YES];
        }
        
        [RPEntry application:application didFinishLaunchingWithOptions:launchOptions];
        [RPEntry instance].apiLanguage = RPApiLanguageEnglish;
        
        if ([ASIdentifierManager sharedManager].isAdvertisingTrackingEnabled) {
            [RPEntry instance].advertisingIdentifier = [ASIdentifierManager sharedManager].advertisingIdentifier;
        }
    } else {
        [RPEntry instance].virtualDeviceToken = [UserService sharedService].virtualDeviceToken;
        
        [RPEntry enableHF:YES];

        if ([RPEntry instance].virtualDeviceToken.length > 0) {
            NSLog(@"%@", [UserService sharedService].virtualDeviceToken);
            [RPEntry initializeWithRequestingPermissions:YES];
        }
    }
    
#warning TODO: Production
    [self createNewUser];
    //[self logInExistUser];
    
    [NMAApplicationContext setAppId:[[Configurator sharedInstance] hereMapsAppID]
                            appCode:[[Configurator sharedInstance] hereMapsAppCode]
                         licenseKey:[[Configurator sharedInstance] hereMapsLicenseKey]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    [self updateDashboardController];
    
    return YES;
}

- (void)createNewUser {
    BOOL loggedIn = [UserService sharedService].isLoggedOn;
    
    if (loggedIn) {
        NSLog(@"USER LOGGED IN");
    } else {
        //CREATE NEW USER
        [[LoginAuthCore sharedManager] createDeviceTokenForUserWithInstanceId:@"INSERT YOUR INSTANCE ID"
                                                                  instanceKey:@"INSERT YOUR INSTANCE KEY"
                                                                       result:^(NSString *deviceToken, NSString *jwToken, NSString *refreshToken) {
            
            NSLog(@"LoginAuthResponce deviceToken %@", deviceToken);
            NSLog(@"LoginAuthResponce jwToken %@", jwToken);
            NSLog(@"LoginAuthResponce refreshToken %@", refreshToken);
            
            [[UserService sharedService] loginWithSecretKeys:deviceToken jwToken:jwToken refreshToken:refreshToken];
        }];
    }
}

- (void)logInExistUser {
    NSString *deviceToken = @"INSERT EXIST USER DEVICE TOKEN"
    
    //LOGIN EXIST USER WITH DEVICETOKEN
    [[LoginAuthCore sharedManager] getJWTokenForUserWithDeviceToken:deviceToken
                                                         instanceId:@"INSERT YOUR INSTANCE ID"
                                                        instanceKey:@"INSERT YOUR INSTANCE KEY"
                                                             result:^(NSString *jwToken, NSString *refreshToken) {
        
        NSLog(@"NEW JWT by DEVICETOKEN %@", jwToken);
        NSLog(@"NEW REFRESHTOKEN by DEVICETOKEN %@", refreshToken);
        
        [[UserService sharedService] loginWithSecretKeys:deviceToken jwToken:jwToken refreshToken:refreshToken];
    }];
}

- (void)updateDashboardController {
    UIViewController* rootVc = [[UIStoryboard storyboardWithName:@"DashboardMain" bundle:nil] instantiateInitialViewController];
    [UIView transitionWithView:self.window duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.window.rootViewController = rootVc;
    } completion:nil];
}

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    if ([defaults_object(@"needTrackingOn") boolValue]) {
        [RPEntry application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
    }
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    if ([defaults_object(@"needTrackingOn") boolValue]) {
        [RPEntry applicationDidReceiveMemoryWarning:application];
    }
}
    
- (void)applicationDidBecomeActive:(UIApplication *)application {
    if ([defaults_object(@"needTrackingOn") boolValue]) {
        [RPEntry applicationDidBecomeActive:application];
    }
    [WiFiGPSChecker sharedChecker].checkAccess = YES;
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    BOOL loggedIn = [UserService sharedService].isLoggedOn;
    if (loggedIn && [defaults_object(@"userDoneWizard") boolValue]) {
        [[UserService sharedService] loadMainUserRequests];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([defaults_object(@"needTrackingOn") boolValue]) {
         [RPEntry applicationDidEnterBackground:application];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    if ([defaults_object(@"needTrackingOn") boolValue]) {
        [RPEntry applicationWillTerminate:application];
    }
}

- (void)logoutOn401 {
    if ([UserService sharedService].isLoggedOn) {
        [[UserService sharedService] logout419];
    }
}

- (void)logoutOn419 {
    if ([UserService sharedService].isLoggedOn) {
        [[UserService sharedService] logout419];
    }
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return NO;
}


#pragma mark - Push

- (void)registerForPushNotifications {
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert
                                            | UNAuthorizationOptionSound
                                            | UNAuthorizationOptionBadge;
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:authOptions
                                                                        completionHandler:^(BOOL granted, NSError * _Nullable error) {
    }];

    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification {
    NSLog(@"Open notification settings screen in app");
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary *userInfo = notification.request.content.userInfo;
    NSLog(@"%@", userInfo);
    completionHandler(UNNotificationPresentationOptionNone);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler {
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    completionHandler();
}


- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> *restorableObjects))restorationHandler {
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation {
    return YES;
}


#pragma mark - Basic

+ (void)initialize {
    if ([self class] == [AppDelegate class]) {
    }
}

+ (AppDelegate*)appDelegate {
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - Start tracking callback

- (void)trackingStateChanged:(Boolean)state {
    NSLog(@"Start tracking state - Location changed to %hhu", state);
}


#pragma mark - Accuracy and Low power SDK delegate

- (void)wrongAccuracyAuthorization {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = localizeString(@"Precise Location is off");
    content.body = [NSString stringWithFormat:@"%@", localizeString(@"Your trips may be not recorded. Please, follow to App Settings=>Location=>Precise Location")];
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"wrongAccuracy" content:content trigger:trigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
    defaults_set_object(@"needOpenAppSettingsImmediately", @(YES));
}

- (void)lowPowerMode:(Boolean)state {
    if (state) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = localizeString(@"Low Power Mode");
        content.body = [NSString stringWithFormat:@"%@", localizeString(@"Your trips may be not recorded. Please, follow to Settings=>Battery=>Low Power")];
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"wrongLowPower" content:content trigger:trigger];

        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
        defaults_set_object(@"needOpenAppSettingsImmediately", @(YES));
    }
}



@end
