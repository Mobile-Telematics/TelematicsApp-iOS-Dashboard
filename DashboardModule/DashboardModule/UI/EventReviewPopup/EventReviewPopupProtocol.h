//
//  EventReviewPopupProtocol.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 01.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import Foundation;
#import "EventReviewPopup.h"

@protocol EventReviewPopupProtocol <NSObject>

@required

- (void)cancelClaimButtonAction:(EventReviewPopup*)popupView button:(UIButton*)button;
- (void)noEventButtonAction:(EventReviewPopup *)popupView button:(UIButton *)button;
- (void)event1ButtonAction:(EventReviewPopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event2ButtonAction:(EventReviewPopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event3ButtonAction:(EventReviewPopup *)popupView newType:(NSString *)newType button:(UIButton *)button;

@end
