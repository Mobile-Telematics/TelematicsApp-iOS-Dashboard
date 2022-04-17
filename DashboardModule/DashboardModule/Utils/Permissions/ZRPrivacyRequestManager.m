//
//  ZRPrivacyRequestManager.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "ZRPrivacyRequestManager.h"
#import "ZRPhotoLibraryAccessor.h"
#import "ZRCameraAccessor.h"
#import "ZRMicrophoneAccessor.h"
#import "ZRLocationAccessor.h"
#import "ZRPushNotificationAccessor.h"
#import "ZRMotionAccessor.h"
#import "ZRAddressBookAccessor.h"
#import "ZRContactsAccessor.h"
#import "ZRFaceIDAccessor.h"

NSString * const ZRNotificationAuthorizationStatusKey = @"com.privacyPermission.notification";
NSString * const ZRHomeKitAuthorizationStatusKey = @"com.privacyPermission.homeKit";
NSString * const ZRCoreMotionAuthorizationStatusKey = @"com.privacyPermission.coreMotion";
@implementation ZRPrivacyRequestManager

+ (ZRAuthorizationStatus)authorizationStatusForPrivacyType:(ZRPrivacyType)privacyType {
    Class<ZRPrivacyAccessor> privacyAccessor = [self privacyAccessorClass:privacyType];
    return [privacyAccessor authorizationStatus];
}

+ (void)requestUserNotificationAuthorization:(NSSet<UIUserNotificationCategory *> *)categories
                                     handler:(ZRRequestAuthorizationHandler)handler {
    return [ZRPushNotificationAccessor requestUserNotificationAuthorization:categories handler:handler];
}

+ (void)requestUNNotificationAuthorization:(NSSet<UNNotificationCategory *> *)categories
                                   handler:(ZRRequestAuthorizationHandler)handler {
    return [ZRPushNotificationAccessor requestUNNotificationAuthorization:categories handler:handler];
}

+ (void)requestAuthorization:(ZRPrivacyType)privacyType
                     handler:(ZRRequestAuthorizationHandler)handler {
    Class cls = [self privacyAccessorClass:privacyType];
    ZRAuthorizationStatus status = [cls authorizationStatus];
    id<ZRPrivacyAccessor> privacyAccessor = [[cls alloc] init];
    if (status != ZRAuthorizationStatusNotDetermined) {
        handler(status);
    } else {
        [privacyAccessor requestAuthorization:handler];
    }
}

+ (void)gotoApplicationSetting {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:settingURL]) {
        if (@available(iOS 10.0, *)) {
            [application openURL:settingURL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:nil];
        }
    }
}
#pragma mark private method
+ (Class<ZRPrivacyAccessor>)privacyAccessorClass:(ZRPrivacyType)privacyType {
    switch (privacyType) {
        case ZRPrivacyTypePhotoLibrary:
            return [ZRPhotoLibraryAccessor class];
        case ZRPrivacyTypeCamera:
            return [ZRCameraAccessor class];
        case ZRPrivacyTypeMicrophone:
            return [ZRMicrophoneAccessor class];
        case ZRPrivacyTypeLocationAlways:
            return [ZRLocationAlwaysAccessor class];
        case ZRPrivacyTypeLocationWhenInUse:
            return [ZRLocationWhenInUseAccessor class];
        case ZRPrivacyTypeUserNotification:
        case ZRPrivacyTypeUNNotification:
            return [ZRPushNotificationAccessor class];
        case ZRPrivacyTypeMotion:
            return [ZRMotionAccessor class];
        case ZRPrivacyTypeAddressBook:
            return [ZRAddressBookAccessor class];
        case ZRPrivacyTypeContacts:
            return [ZRContactsAccessor class];
        case ZRPrivacyTypeFaceID:
            return [ZRFaceIDAccessor class];
        default:
            return nil;
    }
}

+(id<ZRPrivacyAccessor>)privacyAccessor:(ZRPrivacyType)privacyType {
    Class cls = [self privacyAccessorClass:privacyType];
    return [[cls alloc] init];
}
@end
