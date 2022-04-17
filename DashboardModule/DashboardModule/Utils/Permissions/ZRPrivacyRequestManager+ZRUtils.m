//
//  ZRPrivacyRequestManager+ZRUtils.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRPrivacyRequestManager+ZRUtils.h"

@implementation ZRPrivacyRequestManager (ZRUtils)
+ (void)ZR_storeAuthorizationStatus:(ZRAuthorizationStatus)status forType:(ZRPrivacyType)type {
    NSString *key = [self ZR_authorizationStatusKey:type];
    if (key == nil) return;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:status forKey:key];
    [userDefaults synchronize];
}



+ (ZRAuthorizationStatus)ZR_authorizationStatusFromUserDefault:(ZRPrivacyType)type{
    NSString *key = [self ZR_authorizationStatusKey:type];
    if (key == nil) return ZRAuthorizationStatusNotDetermined;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    ZRAuthorizationStatus status = [userDefaults integerForKey:key];
    return status;
}

+ (NSString *)ZR_authorizationStatusKey:(ZRPrivacyType)type {
    NSString *key = nil;
    switch (type) {
        case ZRPrivacyTypeMotion:
            key = ZRCoreMotionAuthorizationStatusKey;
        default:
            break;
    }
    return key;
}
@end

