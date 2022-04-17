//
//  EventReviewPopupDelegate.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 01.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "EventReviewPopupProtocol.h"

@interface EventReviewPopupDelegate: UIView

@property (nonatomic, strong) id <EventReviewPopupProtocol> delegate;

typedef enum {
    WizardFlyInAnimationDefault,
    WizardFlyInAnimationDirectionTop,
    WizardFlyInAnimationDirectionBottom,
    WizardFlyInAnimationDirectionLeft,
    WizardFlyInAnimationDirectionRight
} WizardFlyInAnimationDirection;


typedef enum {
    WizardFlyOutAnimationDefault,
    WizardFlyOutAnimationDirectionTop,
    WizardFlyOutAnimationDirectionBottom,
    WizardFlyOutAnimationDirectionLeft,
    WizardFlyOutAnimationDirectionRight
} WizardFlyOutAnimationDirection;


- (instancetype)initOnView:(UIView*)view;
- (void)showEventReviewPopup:(NSString *)eventType;
- (void)hideEventReviewPopup;

@property (assign, nonatomic) float animationDuration;
@property (assign, nonatomic) WizardFlyInAnimationDirection inAnimation;
@property (assign, nonatomic) WizardFlyOutAnimationDirection outAnimation;
@property (assign, nonatomic) BOOL blurBackground;
@property (assign, nonatomic) BOOL dismissOnBackgroundTap;
@property (assign, nonatomic) float dimBackgroundLevel;
@property (assign, nonatomic) float topMargin;
@property (assign, nonatomic) float bottomMargin;
@property (assign, nonatomic) float leftMargin;
@property (assign, nonatomic) float rightMargin;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *fixButtonTitle;
@property (strong, nonatomic) NSString *continueButtonTitle;
@property (strong, nonatomic) NSString *pushButtonTitle;
@property (assign, nonatomic) float buttonRadius;
@property (assign, nonatomic) float cornerRadius;
@property (strong, nonatomic) NSString *iconName;
@property (strong, nonatomic) NSString *imgName;

@property (strong, nonatomic) NSString *claim_selectedEventTypeMarker;

@end
