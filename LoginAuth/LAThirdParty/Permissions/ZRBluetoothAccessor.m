//
//  ZRBluetoothAccessor.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRBluetoothAccessor.h"
#import <CoreBluetooth/CoreBluetooth.h>
@implementation ZRBluetoothAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    
    return ZRAuthorizationStatusNotDetermined;
}

- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    
}
@end
