//
//  NSDate+UI.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 19.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "NSDate+UI.h"
#import "TTTLocalizedPluralString.h"

@implementation NSDate (UI)

- (NSString*)dateString {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd.MM.yyyy";
    return [df stringFromDate:date];
}

- (NSString*)timeString {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"HH:mm";
    return [df stringFromDate:date];
}

- (NSString*)yearString {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy";
    return [df stringFromDate:date];
}

- (NSString*)dateStringShortYear {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd.MM.yy";
    return [df stringFromDate:date];
}

- (NSString*)dateStringShortYearInverse {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yy.MM.dd";
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShort {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd.MM, HH:mm";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringSpecial {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd";
    //df.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShortDdMm24 {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd.MM, HH:mm";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShortMmDd24 {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MM/dd, HH:mm";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShortDdMmAmPm {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd.MM, hh:mma";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShortMmDdAmPm {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MM/dd, hh:mma";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShortSimple {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    [df setDateStyle:NSDateFormatterShortStyle];
    df.dateFormat = @"dd'/'MM'/'yyyy";
    //NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    //[df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)tripDateTimeString {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"d.MM.yyyy / HH:mm";
    return [df stringFromDate:date];
}

- (NSString*)postDateTimeString {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"d/MM/yyyy, HH:mm";
    return [df stringFromDate:date];
}

- (NSString*)dateStringFullMonth {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd MMMM yyyy";
    return [df stringFromDate:date];
}

+ (NSString*)remainingTimeStringForTimeInterval:(NSTimeInterval)seconds {
    return [NSString stringWithFormat:@"%02d:%02d:%02d", (int)seconds / 3600, ((int)seconds % 3600) / 60, (int)seconds % 60];
}

- (NSString*)postPassedTimeString {
    NSDate* date = self;
    NSTimeInterval passed = -[date timeIntervalSinceNow];
    if (passed < 60) {
        return localizeString(@"time_just_now");
    } else if (passed < 60 * 60) { // minutes
        NSTimeInterval minutes = passed / 60.0;
        return [NSString stringWithFormat:localizeString(@"time_minutes_format"), (int)minutes];
    } else if (passed < 60 * 60 * 24) { // hours
        NSTimeInterval hours = passed / 3600.0;
        return TTTLocalizedPluralStringForLanguage((int)hours, @"time_hours", @"ru");
    } else {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"d MMM";
        return [df stringFromDate:date];
    }
}

- (NSString*)chatPassedTimeString {
    NSDate* date = self;
    NSTimeInterval passed = -[date timeIntervalSinceNow];
    if (passed < 60) { // just now
        return localizeString(@"time_just_now");
    } else if (passed < 60 * 60) { // minutes
        NSTimeInterval minutes = passed / 60.0;
        return [NSString stringWithFormat:localizeString(@"time_minutes_format"), (int)minutes];
    } else if (passed < 60 * 60 * 24) { // hours
        NSTimeInterval hours = passed / 3600.0;
        return TTTLocalizedPluralStringForLanguage((int)hours, @"time_hours", @"ru");
    } else {
        NSDateFormatter* df = [[NSDateFormatter alloc] init];
        df.dateFormat = @"d MMM";
        return [df stringFromDate:date];
    }
}

- (NSString*)dateTimePosix {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"d MMM, HH:mm";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimePosixFull {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"d MMM yyyy, HH:mm";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dayDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    if ([[self yearString] isEqualToString:[[NSDate date] yearString]]) {
        df.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MMMMd" options:0 locale:[NSLocale currentLocale]];
    } else {
        df.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"yMMMMd" options:0 locale:[NSLocale currentLocale]];
    }
    
    return [df stringFromDate:self];
}

- (NSString*)dayDateShort {
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"d";
    return [df stringFromDate:self];
}


#pragma mark - OnDemand Special

- (NSString*)dateTimeStringShort_OnDemand {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd MMMM, HH:mm:ss";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShortMmDd24_OnDemand {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MMMM dd, HH:mm:ss";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShortDdMmAmPm_OnDemand {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"dd MMMM, hh:mm:ssa";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}

- (NSString*)dateTimeStringShortMmDdAmPm_OnDemand {
    NSDate* date = self;
    NSDateFormatter* df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MMMM dd, hh:mm:ssa";
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [df setLocale:locale];
    return [df stringFromDate:date];
}


@end
