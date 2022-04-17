//
//  GeneralWizardPopup.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 02.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "GeneralButton.h"

@interface GeneralWizardPopup: UIView

@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet GeneralButton *gpsButton;
@property (strong, nonatomic) IBOutlet GeneralButton *motionButton;

@end
