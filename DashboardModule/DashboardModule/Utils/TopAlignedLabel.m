//
//  TopAlignedLabel.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 09.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "TopAlignedLabel.h"

@implementation TopAlignedLabel

- (void)drawTextInRect:(CGRect)rect {
    
//    //bottom
//    CGFloat height = [self sizeThatFits:rect.size].height;
//    
//    rect.origin.y += rect.size.height - height;
//    rect.size.height = height;
//    
//    [super drawTextInRect:rect];
    
    //top
    if (self.text) {
        CGSize labelStringSize = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:@{NSFontAttributeName:self.font}
                                                         context:nil].size;
        [super drawTextInRect:CGRectMake(0, 0, ceilf(CGRectGetWidth(self.frame)),ceilf(labelStringSize.height))];
    } else {
        [super drawTextInRect:rect];
    }
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    
}
@end
