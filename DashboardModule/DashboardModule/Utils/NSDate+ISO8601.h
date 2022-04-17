//
//  NSDate+ISO8601.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 07.03.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#if __has_feature(modules)
	@import Foundation;
#else
	#import <Foundation/Foundation.h>
#endif

@interface NSDate (ISO8601)


#pragma mark - Simple
+ (NSString * __nullable)dateFromISO8601:(NSDate *_Nonnull)date;
+ (NSDate * __nullable)dateWithISO8601String:(NSString * __nonnull)string;
- (NSString * __nullable)ISO8601String;


#pragma mark - Advanced
+ (NSDate * __nullable)dateWithISO8601String:(NSString * __nonnull)string timeZone:(inout NSTimeZone * __nonnull * __nullable)timeZone usingCalendar:(NSCalendar * __nullable)calendar;

- (NSString * __nullable)ISO8601StringWithTimeZone:(NSTimeZone * __nullable)timeZone usingCalendar:(NSCalendar * __nullable)calendar;

@end
