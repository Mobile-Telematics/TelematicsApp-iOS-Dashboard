//
//  ZRFaceIDAccessor.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRFaceIDAccessor.h"

#import <LocalAuthentication/LocalAuthentication.h>
@implementation ZRFaceIDAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    return ZRAuthorizationStatusNotDetermined;
}

- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"  " reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                handler(ZRAuthorizationStatusAuthorized);
            }else if (error) {
                NSLog(@"error:%@", error);
                handler(ZRAuthorizationStatusNotSupportForCurrentDevice);
            }
        }];
    } else {
        
    }
}
@end
