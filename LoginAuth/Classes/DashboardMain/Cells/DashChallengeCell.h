//
//  DashChallengeCell.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 06.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;

@interface DashChallengeCell: UITableViewCell

@property (nonatomic, assign, readwrite) IBOutlet UILabel       *positionLbl;
@property (nonatomic, assign, readwrite) IBOutlet UIImageView   *useravatar;
@property (nonatomic, assign, readwrite) IBOutlet UILabel       *usernameLbl;
@property (nonatomic, assign, readwrite) IBOutlet UILabel       *scoreLbl;


@end
