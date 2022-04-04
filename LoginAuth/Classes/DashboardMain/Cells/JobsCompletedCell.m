//
//  JobsCompletedCell.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 06.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "JobsCompletedCell.h"
#import "Font.h"
#import "Helpers.h"

@interface JobsCompletedCell ()

@end

@implementation JobsCompletedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (IS_IPHONE_5 || IS_IPHONE_4)
        self.jobCompletedNameLbl.font = [Font medium12];
}

@end
