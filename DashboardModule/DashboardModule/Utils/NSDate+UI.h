//
//  NSDate+UI.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 19.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import Foundation;

@interface NSDate (UI)

- (NSString*)dateString;
- (NSString*)timeString;
- (NSString*)yearString;
- (NSString*)dateStringShortYear;
- (NSString*)dateStringShortYearInverse;
- (NSString*)dateTimeStringShort;
- (NSString*)dateTimeStringSpecial;
- (NSString*)dateTimeStringShortDdMm24;
- (NSString*)dateTimeStringShortMmDd24;
- (NSString*)dateTimeStringShortDdMmAmPm;
- (NSString*)dateTimeStringShortMmDdAmPm;
- (NSString*)dateTimeStringShortSimple;
- (NSString*)dateStringFullMonth;
- (NSString*)tripDateTimeString;
- (NSString*)postDateTimeString;
- (NSString*)dateTimePosix;
- (NSString*)dateTimePosixFull;
- (NSString*)postPassedTimeString;
- (NSString*)chatPassedTimeString;
- (NSString*)dayDate;
- (NSString*)dayDateShort;
+ (NSString*)remainingTimeStringForTimeInterval:(NSTimeInterval)seconds;

- (NSString*)dateTimeStringShort_OnDemand;
- (NSString*)dateTimeStringShortMmDd24_OnDemand;
- (NSString*)dateTimeStringShortDdMmAmPm_OnDemand;
- (NSString*)dateTimeStringShortMmDdAmPm_OnDemand;

@end
