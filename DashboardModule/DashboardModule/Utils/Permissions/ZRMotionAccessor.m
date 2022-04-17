//
//  ZRMotionAccessor.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRMotionAccessor.h"
#import <CoreMotion/CoreMotion.h>
#import "ZRPrivacyRequestManager+ZRUtils.h"

@implementation ZRMotionAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    if (![CMMotionActivityManager isActivityAvailable]) {
        return ZRAuthorizationStatusNotSupportForCurrentDevice;
    } else {
        CMAuthorizationStatus status = [CMMotionActivityManager authorizationStatus];
        switch (status) {
            case CMAuthorizationStatusNotDetermined:
                return ZRAuthorizationStatusNotDetermined;
            case CMAuthorizationStatusRestricted:
                return ZRAuthorizationStatusRestricted;
            case CMAuthorizationStatusDenied:
                return ZRAuthorizationStatusDenied;
            case CMAuthorizationStatusAuthorized:
                return ZRAuthorizationStatusAuthorized;
        }
    }
}
- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    if (![CMMotionActivityManager isActivityAvailable]) {
        NSAssert(NO, @"current device doesn't support CoreMotion");
        handler(ZRAuthorizationStatusNotSupportForCurrentDevice);
    } else {
        CMMotionActivityManager *manager = [[CMMotionActivityManager alloc] init];
        __weak typeof(manager) weakManager = manager;
        [manager startActivityUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMMotionActivity *activity) {
            NSLog(@"activity:%@", activity);
            __strong typeof(weakManager) strongManager = weakManager;
            [strongManager stopActivityUpdates];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ZRPrivacyRequestManager ZR_storeAuthorizationStatus:ZRAuthorizationStatusAuthorized forType:ZRPrivacyTypeMotion];
                handler(ZRAuthorizationStatusAuthorized);
            });
        }];
    }
}
@end
