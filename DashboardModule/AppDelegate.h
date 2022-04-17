//
//  AppDelegate.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 09.06.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import UserNotifications;

@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate*)appDelegate;
- (void)updateDashboardController;
- (void)registerForPushNotifications;
- (void)logoutOn401;
- (void)logoutOn419;

@end

