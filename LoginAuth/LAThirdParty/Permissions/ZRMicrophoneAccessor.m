//
//  ZRMicrophoneAccessor.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRMicrophoneAccessor.h"
#import <AVFoundation/AVFoundation.h>
@implementation ZRMicrophoneAccessor

+ (ZRAuthorizationStatus)authorizationStatus {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
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
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler([ZRMicrophoneAccessor authorizationStatus]);
        });
    }];
}
@end
