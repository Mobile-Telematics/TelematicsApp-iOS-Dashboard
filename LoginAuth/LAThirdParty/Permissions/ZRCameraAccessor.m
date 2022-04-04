//
//  ZRCameraAccessor.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRCameraAccessor.h"
#import <AVFoundation/AVFoundation.h>

@implementation ZRCameraAccessor

+ (ZRAuthorizationStatus)authorizationStatus {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:
            return ZRAuthorizationStatusNotDetermined;
        case AVAuthorizationStatusRestricted:
            return ZRAuthorizationStatusRestricted;
        case AVAuthorizationStatusDenied:
            return ZRAuthorizationStatusDenied;
        case AVAuthorizationStatusAuthorized:
            return ZRAuthorizationStatusAuthorized;
    }
}

- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler([ZRCameraAccessor authorizationStatus]);
        });
    }];
}
@end
