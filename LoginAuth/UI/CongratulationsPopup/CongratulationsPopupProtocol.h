//
//  CongratulationsPopupProtocol.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 31.07.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import Foundation;
#import "CongratulationsPopup.h"

@protocol CongratulationsPopupProtocol <NSObject>

@required

- (void)okButtonAction:(CongratulationsPopup*)popupView button:(UIButton*)button;

@end
