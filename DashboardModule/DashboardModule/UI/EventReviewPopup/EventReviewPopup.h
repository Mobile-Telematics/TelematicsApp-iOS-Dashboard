//
//  EventReviewPopup.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 01.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "GeneralButton.h"

@interface EventReviewPopup: UIView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageLabel;

@property (strong, nonatomic) IBOutlet UILabel *noEventTextLbl;
@property (strong, nonatomic) IBOutlet UILabel *event1TextLbl;
@property (strong, nonatomic) IBOutlet UILabel *event2TextLbl;
@property (strong, nonatomic) IBOutlet UILabel *event3TextLbl;

@property (strong, nonatomic) IBOutlet UIButton *noEventBtn;
@property (strong, nonatomic) IBOutlet UIButton *event1Btn;
@property (strong, nonatomic) IBOutlet UIButton *event2Btn;
@property (strong, nonatomic) IBOutlet UIButton *event3Btn;

@property (strong, nonatomic) IBOutlet GeneralButton *cancelBtn;

@end
