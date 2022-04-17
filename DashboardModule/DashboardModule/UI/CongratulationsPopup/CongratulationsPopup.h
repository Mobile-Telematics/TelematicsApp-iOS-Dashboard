//
//  CongratulationsPopup.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 31.07.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "GeneralButton.h"

@interface CongratulationsPopup: UIView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;
@property (strong, nonatomic) IBOutlet UILabel *ad1Text;
@property (strong, nonatomic) IBOutlet UILabel *ad2Text;
@property (strong, nonatomic) IBOutlet UILabel *ad3Text;
@property (strong, nonatomic) IBOutlet GeneralButton *okBtn;

@end
