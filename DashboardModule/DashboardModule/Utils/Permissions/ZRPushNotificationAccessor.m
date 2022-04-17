//
//  ZRPushNotificationAccessor.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRPushNotificationAccessor.h"
@import UIKit;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif


@interface ZRPushNotificationAccessor()
+ (instancetype)shareInstance;
@end


@implementation ZRPushNotificationAccessor
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static ZRPushNotificationAccessor *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ZRPushNotificationAccessor alloc] init];
    });
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark ZRPrivacyAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    if (@available(iOS 10.0, *)) {
        __block ZRAuthorizationStatus status = ZRAuthorizationStatusUnknown;
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings *settings) {
            UNAuthorizationStatus authorizationStatus = settings.authorizationStatus;
            switch (authorizationStatus) {
                case UNAuthorizationStatusNotDetermined:
                    status = ZRAuthorizationStatusNotDetermined;
                    break;
                case UNAuthorizationStatusDenied:
                    status = ZRAuthorizationStatusDenied;
                    break;
                case UNAuthorizationStatusAuthorized:
                    status = ZRAuthorizationStatusAuthorized;
                    break;
            }
        }];
        return status;
    } else {
        UIUserNotificationType type = [[[UIApplication sharedApplication] currentUserNotificationSettings] types];
        if (type != UIUserNotificationTypeNone) {
            return ZRAuthorizationStatusAuthorized;
        } else {
            //
        }
        return ZRAuthorizationStatusUnknown;
    }
}

+ (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    return [self requestUserNotificationAuthorization:[NSSet set] handler:handler];
}

+ (void)requestUNNotificationAuthorization:(NSSet<UNNotificationCategory *> *)categories handler:(ZRRequestAuthorizationHandler)handler {
    if (@available(iOS 10.0, *)) {
        ZRAuthorizationStatus status = [self authorizationStatus];
        if (status != ZRAuthorizationStatusNotDetermined) {
            if (handler) {
                handler(status);
            }
        } else {
            [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:(id)categories];
            [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:0 completionHandler:^(BOOL granted, NSError *error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    ZRAuthorizationStatus status = [self authorizationStatus];
                    if (handler) {
                        handler(status);
                    }
                });
            }];
        }
    } else {
        NSAssert(NO, @"method-requestUNNotificationAuthorization:handler: only support iOS system greater than iOS10");
    }
}

+ (void)requestUserNotificationAuthorization:(NSSet<UIUserNotificationCategory *> *)categories handler:(ZRRequestAuthorizationHandler)handler {
    ZRAuthorizationStatus status = [self authorizationStatus];
    if (status != ZRAuthorizationStatusNotDetermined) {
        if (handler) {
            handler(status);
        }
    } else {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:categories];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }


}
@end
