//
//  NSString+Date.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 19.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

- (NSDate*)date {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = kDateFormatWithTimezone;
    return [df dateFromString:self];
}

- (NSDate*)dateWithTimezone {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = kDateFormatWithTimezone;
    return [df dateFromString:self];
}

+ (NSString*)stringFromDateWithTimezone:(NSDate*)date {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = kDateFormatWithTimezone;
    return [df stringFromDate:date];
}

+ (NSString*)stringFromDate:(NSDate*)date {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = kDateFormat;
    return [df stringFromDate:date];
}

+ (NSString*)currentDateString {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = kDateFormatWithTimezone;
    return [df stringFromDate:[NSDate date]];
}

@end
