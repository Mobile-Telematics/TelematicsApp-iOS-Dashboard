//
//  UIView+Styling.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 19.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "UIView+Styling.h"

@implementation UIView (Styling)

- (void)makeRound {
    self.layer.cornerRadius = CGRectGetWidth(self.frame)/2.0;
}

@end
