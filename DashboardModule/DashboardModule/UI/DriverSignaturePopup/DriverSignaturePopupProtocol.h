//
//  DriverSignaturePopupProtocol.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 11.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import Foundation;
#import "DriverSignaturePopup.h"

@protocol DriverSignaturePopupProtocol <NSObject>

@required

- (void)event1_Driver_ButtonAction:(DriverSignaturePopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event2_Passenger_ButtonAction:(DriverSignaturePopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event3_Bus_ButtonAction:(DriverSignaturePopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event4_Motorcycle_ButtonAction:(DriverSignaturePopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event5_Train_ButtonAction:(DriverSignaturePopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event6_Taxi_ButtonAction:(DriverSignaturePopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event7_Bicycle_ButtonAction:(DriverSignaturePopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)event8_Other_ButtonAction:(DriverSignaturePopup *)popupView newType:(NSString *)newType button:(UIButton *)button;
- (void)cancelSignatureButtonAction:(DriverSignaturePopup*)popupView button:(UIButton*)button;
- (void)submitSignatureButtonAction:(DriverSignaturePopup *)popupView button:(UIButton *)button;

@end
