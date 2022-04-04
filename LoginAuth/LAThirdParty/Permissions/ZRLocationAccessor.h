//
//  ZRLocationAccessor.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import Foundation;
#import "ZRPrivacyRequestManager.h"

@interface ZRLocationAccessor : NSObject
@end

@interface ZRLocationAlwaysAccessor : NSObject<ZRPrivacyAccessor>

@end

@interface ZRLocationWhenInUseAccessor : NSObject<ZRPrivacyAccessor>

@end
