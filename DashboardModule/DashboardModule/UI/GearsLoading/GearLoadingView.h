//
//  GearLoadingView.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 12.06.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GearLoadingView: UIView

+ (instancetype)showGearLoadingForView:(UIView *)view;
+ (BOOL)hideGearLoadingForView:(UIView *)view;

@end
