//
//  GeneralWizardPopupDelegate.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 02.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "GeneralWizardPopupProtocol.h"

@interface GeneralWizardPopupDelegate: UIView

@property (nonatomic, strong) id <GeneralWizardPopupProtocol> delegate;

typedef enum {
    FlyInAnimationDefault,
    FlyInAnimationDirectionTop,
    FlyInAnimationDirectionBottom,
    FlyInAnimationDirectionLeft,
    FlyInAnimationDirectionRight
} FlyInAnimationDirection;


typedef enum {
    FlyOutAnimationDefault,
    FlyOutAnimationDirectionTop,
    FlyOutAnimationDirectionBottom,
    FlyOutAnimationDirectionLeft,
    FlyOutAnimationDirectionRight
} FlyOutAnimationDirection;


- (instancetype)initOnView:(UIView*)view;
- (void)showPopup;
- (void)hidePopup;

- (void)setupButtonGPS;
- (void)setupButtonMotion;

@property (assign, nonatomic) BOOL disabledGPS;
@property (assign, nonatomic) BOOL disabledMotion;

@property (assign, nonatomic) float animationDuration;
@property (assign, nonatomic) FlyInAnimationDirection inAnimation;
@property (assign, nonatomic) FlyOutAnimationDirection outAnimation;
@property (assign, nonatomic) BOOL blurBackground;
@property (assign, nonatomic) BOOL dismissOnBackgroundTap;
@property (assign, nonatomic) float dimBackgroundLevel;
@property (assign, nonatomic) float topMargin;
@property (assign, nonatomic) float bottomMargin;
@property (assign, nonatomic) float leftMargin;
@property (assign, nonatomic) float rightMargin;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *gpsButtonTitle;
@property (strong, nonatomic) NSString *motionButtonTitle;
@property (assign, nonatomic) float buttonRadius;
@property (assign, nonatomic) float cornerRadius;
@property (strong, nonatomic) NSString *iconName;
@property (strong, nonatomic) NSString *imgName;


@end
