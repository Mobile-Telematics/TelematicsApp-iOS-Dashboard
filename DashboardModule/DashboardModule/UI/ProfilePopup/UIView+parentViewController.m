//
//  UIView+parentViewController.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 12.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "UIView+parentViewController.h"

@implementation UIView (parentViewController)

- (UIViewController *)parentViewController
{
    UIResponder *parentResponder = self;
    while (parentResponder) {
        parentResponder = [parentResponder nextResponder];
        if ([parentResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)parentResponder;
        }
    }
    return nil;
}

@end
