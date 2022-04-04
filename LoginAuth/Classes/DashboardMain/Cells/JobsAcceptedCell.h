//
//  JobsAcceptedCell.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 06.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;

@interface JobsAcceptedCell: UITableViewCell

@property (nonatomic, assign, readwrite) IBOutlet UILabel *jobNameLbl;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *jobDeclineBtn;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *jobStartBtn;
@property (nonatomic, assign, readwrite) IBOutlet UIButton *jobPauseBtn;
@property (nonatomic, assign) BOOL isPause;

@end
