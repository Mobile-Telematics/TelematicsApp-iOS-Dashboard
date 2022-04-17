//
//  UIViewController+Feedback.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 14.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;

@interface UIViewController (Feedback)

- (void)makeCallToNumber:(NSString*)number;
- (void)sendEmailToAddress:(NSString*)address;

@end
