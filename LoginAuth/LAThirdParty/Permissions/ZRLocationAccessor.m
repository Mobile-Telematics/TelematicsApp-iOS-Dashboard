//
//  ZRLocationAccessor.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRLocationAccessor.h"
#import <CoreLocation/CoreLocation.h>

@interface ZRLocationAccessor() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) ZRRequestAuthorizationHandler handler;

@end

@implementation ZRLocationAccessor
#pragma mark getter
- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    static ZRLocationAccessor *shareInstance = nil;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ZRLocationAccessor alloc] init];
    });
    return shareInstance;
}

+ (ZRAuthorizationStatus)authorizationStatus {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            return ZRAuthorizationStatusNotDetermined;
        case kCLAuthorizationStatusRestricted:
            return ZRAuthorizationStatusRestricted;
        case kCLAuthorizationStatusDenied:
            return ZRAuthorizationStatusDenied;
        case kCLAuthorizationStatusAuthorizedAlways:
            return ZRAuthorizationStatusAuthorizedAlways;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            return ZRAuthorizationStatusAuthorizedWhenInUse;
    }
}

- (void)requestAlwaysAuthorization:(ZRRequestAuthorizationHandler)handler {
    ZRAuthorizationStatus status = [ZRLocationAccessor authorizationStatus];
    if (status != ZRAuthorizationStatusNotDetermined) {
        if (handler) {
            handler(status);
        }
    } else {
        self.handler = handler;
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}


- (void)requestWhenInUseAuthorization:(ZRRequestAuthorizationHandler)handler {
    ZRAuthorizationStatus status = [ZRLocationAccessor authorizationStatus];
    if (status != ZRAuthorizationStatusNotDetermined) {
        if (handler) {
            handler(status);
        }
    } else {
        self.handler = handler;
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark CLLocation Manager Delegate
- (void)locationManager:(CLLocationManager *)manager
       didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self.locationManager stopUpdatingLocation];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.handler) {
            self.handler(ZRAuthorizationStatusNotSupportForCurrentDevice);
            self.handler = nil;
        }
    });
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusNotDetermined) return;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.handler) {
            self.handler([ZRLocationAccessor authorizationStatus]);
            self.handler = nil;
        }
    });
}
@end


@implementation ZRLocationAlwaysAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    return [ZRLocationAccessor authorizationStatus];
}

- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    [[ZRLocationAccessor shareInstance] requestAlwaysAuthorization:handler];
}
@end


@implementation ZRLocationWhenInUseAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    return [ZRLocationAccessor authorizationStatus];
}

- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    [[ZRLocationAccessor shareInstance] requestWhenInUseAuthorization:handler];
}
@end
