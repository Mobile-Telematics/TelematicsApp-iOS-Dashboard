//
//  ZRPhotoLibraryAccessor.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRPhotoLibraryAccessor.h"
#import <Photos/Photos.h>
@implementation ZRPhotoLibraryAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusNotDetermined:
            return ZRAuthorizationStatusNotDetermined;
        case PHAuthorizationStatusRestricted:
            return ZRAuthorizationStatusRestricted;
        case PHAuthorizationStatusDenied:
            return ZRAuthorizationStatusDenied;
        case PHAuthorizationStatusAuthorized:
            return ZRAuthorizationStatusAuthorized;
        case PHAuthorizationStatusLimited:
            return ZRAuthorizationStatusNotDetermined;
            break;
    }
}

- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler([ZRPhotoLibraryAccessor authorizationStatus]);
        });
    }];
}
@end
