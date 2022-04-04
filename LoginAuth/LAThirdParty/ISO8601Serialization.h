//
//  ISO8601Serialization.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 07.03.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#if __has_feature(modules)
	@import Foundation;
#else
	#import <Foundation/Foundation.h>
#endif

@interface ISO8601Serialization : NSObject

#pragma mark - Reading
+ (NSDateComponents * __nullable)dateComponentsForString:(NSString * __nonnull)string;


#pragma mark - Writing
+ (NSString * __nullable)stringForDateComponents:(NSDateComponents * __nonnull)components;

@end
