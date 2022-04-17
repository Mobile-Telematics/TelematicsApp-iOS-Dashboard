//
//  GeneralWizardPopupProtocol.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 02.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import Foundation;
#import "GeneralWizardPopup.h"

@protocol GeneralWizardPopupProtocol <NSObject>

@required
- (void)gpsButtonAction:(GeneralWizardPopup*)popupView button:(UIButton*)button;
- (void)motionButtonAction:(GeneralWizardPopup*)popupView button:(UIButton*)button;

@end
