//
//  ProfileRequestData.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 25.11.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ProfileRequestData.h"
#import "Helpers.h"

@implementation ProfileRequestData

- (NSArray<NSString *> *)validateCheckNewUserEmail {
    NSMutableArray* errors = [NSMutableArray array];
    
    if (!self.email.length) {
        [errors addObject:localizeString(@"validation_enter_email")];
    } else if (!NSStringIsValidEmail(self.email)) {
        [errors addObject:localizeString(@"validation_invalid_email")];
    }
    
    return errors.count ? errors : [super validateCheckNewUserEmail];
}

@end
