//
//  UIViewController+Preloader.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 09.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;

static const float kShiftAnimationDuration = 0.25;

@interface UIViewController (Preloader)
@property(nonatomic, strong) UIView* preloader;
@property(nonatomic, strong) UIActivityIndicatorView* activity;

@property(nonatomic, assign) BOOL kbIsShown;
@property(nonatomic, assign) BOOL dontHideKb;

@property(nonatomic, assign) int shiftHeight;

- (void)showPreloader;
- (void)hidePreloader;

- (void)registerForKeyboardNotifications;

- (void)updatePosition;

@end
