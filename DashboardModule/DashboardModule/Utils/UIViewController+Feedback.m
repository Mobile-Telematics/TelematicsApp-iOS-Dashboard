//
//  UIViewController+Feedback.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 14.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "UIViewController+Feedback.h"

@implementation UIViewController (Feedback)

- (void)makeCallToNumber:(NSString*)number {
    if (!number.length) {
        return;
    }
    if (![number hasPrefix:@"+"]) {
        number = [NSString stringWithFormat:@"+%@", number];
    }
    number = [number stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL* phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", number]]; //@"telprompt://%@"
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl options:@{} completionHandler:nil];
    }
}

- (void)sendEmailToAddress:(NSString*)address {
    NSString* urlString = [NSString stringWithFormat:@"mailto:%@", address];
    NSURL* url = [NSURL URLWithString:urlString];
    if (url) {
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        }
    }
}

@end
