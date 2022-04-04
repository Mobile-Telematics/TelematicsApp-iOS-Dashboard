//
//  GeneralPermissionsPopup.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 01.12.21.
//  Copyright © 2020 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "GeneralButton.h"

@interface GeneralPermissionsPopup: UIView

@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet GeneralButton *gpsButton;
@property (strong, nonatomic) IBOutlet GeneralButton *motionButton;
@property (strong, nonatomic) IBOutlet GeneralButton *pushButton;
@property (strong, nonatomic) IBOutlet GeneralButton *closeButton;

@end
