//
//  UIView+Snapshot.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 12.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)snapshot
{
    UIGraphicsBeginImageContext(self.bounds.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ref);
    UIRectClip(self.bounds);
    [self.layer renderInContext:ref];
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

@end
