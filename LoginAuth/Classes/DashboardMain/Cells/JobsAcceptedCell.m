//
//  JobsAcceptedCell.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 06.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "JobsAcceptedCell.h"
#import "Color.h"
#import "Font.h"
#import "Helpers.h"

@interface JobsAcceptedCell ()

@end

@implementation JobsAcceptedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.jobDeclineBtn.layer.borderWidth = 0.8;
    self.jobDeclineBtn.layer.borderColor = [Color officialRedColor].CGColor;
    self.jobDeclineBtn.backgroundColor = [Color officialWhiteColor];
    [self.jobDeclineBtn setTitleColor:[Color officialRedColor] forState:UIControlStateNormal];
    
    self.jobPauseBtn.layer.borderWidth = 0.8;
    self.jobPauseBtn.layer.borderColor = [Color officialOrangeColor].CGColor;
    self.jobPauseBtn.backgroundColor = [Color officialWhiteColor];
    [self.jobPauseBtn setTitleColor:[Color officialOrangeColor] forState:UIControlStateNormal];
    
    if (IS_IPHONE_5 || IS_IPHONE_4)
        self.jobNameLbl.font = [Font medium12];
}
@end
