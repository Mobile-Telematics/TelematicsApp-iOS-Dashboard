//
//  ZRPrivacyRequestManager.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import Foundation;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 100000
#import <UserNotifications/UserNotifications.h>
#endif

typedef NS_ENUM(NSInteger, ZRAuthorizationStatus) {
    ZRAuthorizationStatusNotDetermined = 0,
    ZRAuthorizationStatusRestricted = 1,
    ZRAuthorizationStatusDenied = 2,
    ZRAuthorizationStatusAuthorized = 3,
    ZRAuthorizationStatusAuthorizedWhenInUse = 4,
    ZRAuthorizationStatusAuthorizedAlways = ZRAuthorizationStatusAuthorized,
    ZRAuthorizationStatusNotSupportForCurrentDevice = 5,
    ZRAuthorizationStatusNotSupportForLowerOSVersion = 6,
    ZRAuthorizationStatusUnavailable = 7,
    ZRAuthorizationStatusUnknown = 8,
};

typedef NS_ENUM(NSInteger, ZRPrivacyType) {
    ZRPrivacyTypePhotoLibrary = 0,
    ZRPrivacyTypeCamera,
    ZRPrivacyTypeMicrophone,
//    ZRPrivacyTypeBluetooth,
    ZRPrivacyTypeLocationAlways,
    ZRPrivacyTypeLocationWhenInUse,
    ZRPrivacyTypeUserNotification,
    ZRPrivacyTypeUNNotification,
    ZRPrivacyTypeMotion,
    ZRPrivacyTypeAddressBook,
    ZRPrivacyTypeContacts,
    ZRPrivacyTypeEvent,
    ZRPrivacyTypeReminder,
    ZRPrivacyTypeHomeKit,
    ZRPrivacyTypeHealth,
    ZRPrivacyTypeSpeech,
    ZRPrivacyTypeSiri,
    ZRPrivacyTypeNFC,
    ZRPrivacyTypeFaceID,
};
typedef NS_OPTIONS(NSInteger, ZRPushNotificationType) {
    ZRPushNotificationTypeNone    = 0,
    ZRPushNotificationTypeBadge   = (1 << 0),
    ZRPushNotificationTypeSound   = (1 << 1),
    ZRPushNotificationTypeAlert   = (1 << 2),
    ZRPushNotificationTypeCarPlay = (1 << 3),
};

typedef void(^ZRRequestAuthorizationHandler)(ZRAuthorizationStatus status);


FOUNDATION_EXTERN NSString * const ZRCoreMotionAuthorizationStatusKey;
FOUNDATION_EXTERN NSString * const ZRNotificationAuthorizationStatusKey;
FOUNDATION_EXTERN NSString * const ZRHomeKitAuthorizationStatusKey;



@protocol ZRPrivacyAccessor <NSObject>
@required
+ (ZRAuthorizationStatus)authorizationStatus;
//+ (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler;
- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler;
@optional
@end

@interface ZRPrivacyRequestManager : NSObject
+ (ZRAuthorizationStatus)authorizationStatusForPrivacyType:(ZRPrivacyType)privacyType;
+ (void)requestAuthorization:(ZRPrivacyType)privacyType
                     handler:(ZRRequestAuthorizationHandler)handler;

//for notification
+ (void)requestUserNotificationAuthorization:(NSSet<UIUserNotificationCategory *> *)categories
                                     handler:(ZRRequestAuthorizationHandler)handler;
+ (void)requestUNNotificationAuthorization:(NSSet<UNNotificationCategory *> *)categories
                                   handler:(ZRRequestAuthorizationHandler)handler API_AVAILABLE(ios(10.0));
+ (void)gotoApplicationSetting;
@end
