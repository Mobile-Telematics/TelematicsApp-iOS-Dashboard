//
//  GeneralWizardPopupDelegate.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 02.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "GeneralWizardPopupDelegate.h"
#import "GeneralWizardPopup.h"
#import "GeneralButton.h"
#import "Helpers.h"

#define DefaultTitle localizeString(@"Turn On Telematics Data")
#define DefaultGPSTitle localizeString(@"Set Location Always")
#define DefaultMotionTitle localizeString(@"Enable Motions")
#define DefaultIcon @"icon"
#define DefaultImage @"image"
#define DefaultTopMargin 140
#define DefaultBottomMargin 140
#define DefaultLeftMargin 25
#define DefaultRightMargin 25
#define DefaultDimmedLevel 0.85
#define DefaultCornerRadius 20
#define DefaultButtonRadius 23

@interface GeneralWizardPopupDelegate()

@property (strong, nonatomic) GeneralWizardPopup *customView;
@property (strong, nonatomic) UIView *view;
@property (strong, nonatomic) UIView *dimBG;
@property (strong, nonatomic) UIVisualEffectView *blurBG;

@end

@implementation GeneralWizardPopupDelegate


#pragma mark - Initialization Methods

- (instancetype)initOnView:(UIView*)view {
    self.view = view;
    return self;
}

- (void)initialize {
    if (!self.inAnimation) {
        self.inAnimation = DELAY_IMMEDIATELY_1_SEC;
    }
    if (!self.outAnimation) {
        self.outAnimation = DELAY_IMMEDIATELY_2_SEC;
    }
    if (!self.topMargin) {
        if (IS_IPHONE_5 || IS_IPHONE_4) {
            if ([defaults_object(@"updatePopupLayoutForWizard") boolValue]) {
                self.topMargin = self.view.frame.size.height/10;
            } else {
                self.topMargin = self.view.frame.size.height/6;
            }
        } else if (IS_IPHONE_8 || IS_IPHONE_8P) {
            if ([defaults_object(@"updatePopupLayoutForWizard") boolValue]) {
                self.topMargin = self.view.frame.size.height/10;
            } else {
                self.topMargin = self.view.frame.size.height/5;
            }
        } else if (IS_IPHONE_XS_MAX || IS_IPHONE_13_PROMAX) {
            if ([defaults_object(@"updatePopupLayoutForWizard") boolValue]) {
                self.topMargin = self.view.frame.size.height/5;
            } else {
                self.topMargin = self.view.frame.size.height/4;
            }
        } else {
            if ([defaults_object(@"updatePopupLayoutForWizard") boolValue]) {
                self.topMargin = self.view.frame.size.height/6;
            } else {
                self.topMargin = self.view.frame.size.height/4;
            }
        }
    }
    if (!self.bottomMargin) {
        if (IS_IPHONE_5 || IS_IPHONE_4) {
            if ([defaults_object(@"updatePopupLayoutForWizard") boolValue]) {
                self.bottomMargin = self.view.frame.size.height/10;
            } else {
                self.bottomMargin = self.view.frame.size.height/7;
            }
        } else if (IS_IPHONE_8 || IS_IPHONE_8P) {
            if ([defaults_object(@"updatePopupLayoutForWizard") boolValue]) {
                self.bottomMargin = self.view.frame.size.height/10;
            } else {
                self.bottomMargin = self.view.frame.size.height/5;
            }
        } else if (IS_IPHONE_XS_MAX || IS_IPHONE_13_PROMAX) {
            if ([defaults_object(@"updatePopupLayoutForWizard") boolValue]) {
                self.bottomMargin = self.view.frame.size.height/5;
            } else {
                self.bottomMargin = self.view.frame.size.height/3;
            }
        } else {
            if ([defaults_object(@"updatePopupLayoutForWizard") boolValue]) {
                self.bottomMargin = self.view.frame.size.height/6;
            } else {
                self.bottomMargin = self.view.frame.size.height/4;
            }
        }
    }
    if (!self.leftMargin) {
        self.leftMargin = DefaultLeftMargin;
    }
    if (!self.rightMargin) {
        self.rightMargin = DefaultRightMargin;
    }
    if (!self.cornerRadius) {
        self.cornerRadius = DefaultCornerRadius;
    }
    if (!self.buttonRadius) {
        self.buttonRadius = DefaultButtonRadius;
    }
    if (!self.animationDuration) {
        self.animationDuration = DELAY_IMMEDIATELY_03_SEC;
    }
    if (!self.dimBackgroundLevel) {
        self.dimBackgroundLevel = DefaultDimmedLevel;
    }
    if (!self.title) {
        self.title = DefaultTitle;
    }
    if (!self.message) {
        self.message = localizeString(@"To determine your location automatically, you need to resolve access to the following functions.\n\nBut in order to fully use the App, you must issue all permissions, including GPS only ALWAYS mode.\n\nDo it now and get all the benefits.");
    }
    if (!self.gpsButtonTitle) {
        self.gpsButtonTitle = DefaultGPSTitle;
    }
    if (!self.motionButtonTitle) {
        self.motionButtonTitle = DefaultMotionTitle;
    }
    if (!self.iconName) {
        self.iconName = DefaultIcon;
    }
    if (!self.imgName) {
        self.imgName = DefaultImage;
    }
}


#pragma mark - Popup Build

- (void)setPopup {
    [self initialize];
    self.customView = [[[NSBundle mainBundle] loadNibNamed:@"GeneralWizardPopup" owner:nil options:nil] firstObject];
    self.customView.frame = CGRectMake(0, 0, self.view.bounds.size.width - (self.leftMargin + self.rightMargin), self.view.bounds.size.height - (self.topMargin + self.bottomMargin));
    self.customView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.customView.center = self.view.center;
    
    self.customView.layer.cornerRadius = self.cornerRadius;
    [self setBlurredBackground];
    [self setupLabels];
    [self setupButtons];
    [self setupImages];
}


#pragma mark - Blur Background

- (void)setBlurredBackground {
    if (!UIAccessibilityIsReduceTransparencyEnabled() && self.blurBackground) {
        UIBlurEffect *burrEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        self.blurBG = [[UIVisualEffectView alloc] initWithEffect:burrEffect];
        self.blurBG.frame = self.view.bounds;
        self.blurBG.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if (self.dismissOnBackgroundTap) {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePopup)];
            tapGesture.numberOfTapsRequired = 1;
            [self.blurBG addGestureRecognizer:tapGesture];
        }
        [self.view addSubview:self.blurBG];
    } else {
        [self setDimBackground];
    }
}


#pragma mark - Background

- (void)setDimBackground {
    self.dimBG = [[UIView alloc]initWithFrame:self.view.bounds];
    self.dimBG.alpha = self.dimBackgroundLevel;
    self.dimBG.backgroundColor = [UIColor blackColor];
    self.dimBG.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (self.dismissOnBackgroundTap) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidePopup)];
        tapGesture.numberOfTapsRequired = 1;
        [self.dimBG addGestureRecognizer:tapGesture];
    }
    [self.view addSubview:self.dimBG];
}


#pragma mark - Setup Labels

- (void)setupLabels {
    self.customView.titleLabel.text = self.title;
    self.customView.messageLabel.text = self.message;
}


#pragma mark - Setup Buttons

- (void)setupButtons {
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.gpsButtonTitle];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[Color darkGrayColor43] range:(NSRange){0, [attributeString length]}];
    
    [self.customView.gpsButton setAttributedTitle:attributeString forState:UIControlStateNormal];
    
    [self.customView.motionButton setTitle:self.motionButtonTitle forState:UIControlStateNormal];
    
    [self setupButtonGPS];
    [self setupButtonMotion];
    
    self.customView.gpsButton.layer.cornerRadius = self.buttonRadius;
    self.customView.motionButton.layer.cornerRadius = self.buttonRadius;
    
    [self.customView.gpsButton addTarget:self action:@selector(gpsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.customView.motionButton addTarget:self action:@selector(motionButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupButtonGPS {
    self.customView.gpsButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.customView.gpsButton.imagePosition = GeneralButtonImagePositionRight;
    self.customView.gpsButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (IS_IPHONE_5 || IS_IPHONE_4) {
        self.customView.gpsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        self.customView.gpsButton.imageEdgeInsets = UIEdgeInsetsMake(0, 51, 0, 0);
    } else if (IS_IPHONE_XS_MAX || IS_IPHONE_13_PROMAX || IS_IPHONE_8P) {
        self.customView.gpsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        self.customView.gpsButton.imageEdgeInsets = UIEdgeInsetsMake(0, 121, 0, 0);
    } else {
        self.customView.gpsButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        self.customView.gpsButton.imageEdgeInsets = UIEdgeInsetsMake(0, 82, 0, 0);
    }
    
    if (self.disabledGPS) {
        UIImage *gps_re = [GeneralButton imageWithImage:[UIImage imageNamed:@"popup_gps"] scaledToHeight:25];
        [self.customView.gpsButton setImage:gps_re forState:UIControlStateNormal];
    } else {
        UIImage *gps_re = [GeneralButton imageWithImage:[UIImage imageNamed:@"popup_ok"] scaledToHeight:25];
        [self.customView.gpsButton setImage:gps_re forState:UIControlStateNormal];
    }
    [self layoutIfNeeded];
}

- (void)setupButtonMotion {
    self.customView.motionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.customView.motionButton.imagePosition = GeneralButtonImagePositionRight;
    self.customView.motionButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (IS_IPHONE_5 || IS_IPHONE_4) {
        self.customView.motionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 0);
        self.customView.motionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 74.5, 0, 0);
    } else if (IS_IPHONE_XS_MAX || IS_IPHONE_13_PROMAX || IS_IPHONE_8P) {
        self.customView.motionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        self.customView.motionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 145, 0, 0);
    } else {
        self.customView.motionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        self.customView.motionButton.imageEdgeInsets = UIEdgeInsetsMake(0, 106, 0, 0);
    }
    
    if (self.disabledMotion) {
        UIImage *motion_re = [GeneralButton imageWithImage:[UIImage imageNamed:@"popup_motion"] scaledToHeight:25];
        [self.customView.motionButton setImage:motion_re forState:UIControlStateNormal];
    } else {
        UIImage *motion_re = [GeneralButton imageWithImage:[UIImage imageNamed:@"popup_ok"] scaledToHeight:25];
        [self.customView.motionButton setImage:motion_re forState:UIControlStateNormal];
    }
    [self layoutIfNeeded];
}


#pragma mark - Setup Images

- (void)setupImages {
    self.customView.iconView.image = [UIImage imageNamed:self.iconName];
    self.customView.imgView.image = [UIImage imageNamed:self.imgName];
}


#pragma mark - Actions

- (void)gpsButtonAction {
    [_delegate gpsButtonAction:self.customView button:self.customView.gpsButton];
}

- (void)motionButtonAction {
    [_delegate motionButtonAction:self.customView button:self.customView.motionButton];
}


#pragma mark - Hide/Show Methods

- (void)showPopup {
    [self setPopup];
    [self animateIn];
}

- (void)hidePopup {
    [self animateOut];
}


#pragma mark - Animations

- (void)animateIn {
    switch (self.inAnimation) {
        case 1:
        {
            self.customView.frame = CGRectOffset(self.customView.frame, 0, -self.view.center.y);
            [self.view addSubview:self.customView];
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.frame = CGRectOffset(self.customView.frame, 0, self.view.center.y);
            }];
        }
            break;
        case 2:
        {
            self.customView.frame = CGRectOffset(self.customView.frame, 0, SCREEN_HEIGHT+self.view.center.y);
            [self.view addSubview:self.customView];
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.frame = CGRectOffset(self.customView.frame, 0, -SCREEN_HEIGHT-self.view.center.y);
            }];
        }
            break;
        case 3:
        {
            self.customView.frame = CGRectOffset(self.customView.frame, -self.view.center.x, 0);
            [self.view addSubview:self.customView];
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.frame = CGRectOffset(self.customView.frame, self.view.center.x, 0);
            }];
        }
            break;
        case 4:
        {
            self.customView.frame = CGRectOffset(self.customView.frame, SCREEN_WIDTH+self.view.center.x, 0);
            [self.view addSubview:self.customView];
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.frame = CGRectOffset(self.customView.frame, -SCREEN_WIDTH-self.view.center.x, 0);
            }];
        }
            break;
        default:
        {
            self.customView.transform = CGAffineTransformMakeScale(0.5, 0.5);
            [self.view addSubview:self.customView];
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
    }
}

- (void)animateOut {
    switch (self.outAnimation) {
        case 1:
        {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.frame = CGRectOffset(self.customView.frame, 0, -self.view.center.y);
                [self.view layoutIfNeeded];
                self.customView.alpha = 0;
                self.dimBG.alpha = 0;
                self.blurBG.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromView];
            }];
        }
            break;
        case 2:
        {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.frame = CGRectOffset(self.customView.frame, 0, SCREEN_HEIGHT+self.view.center.y);
                [self.view layoutIfNeeded];
                self.customView.alpha = 0;
                self.dimBG.alpha = 0;
                self.blurBG.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromView];
            }];
        }
            break;
        case 3:
        {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.frame = CGRectOffset(self.customView.frame, -SCREEN_WIDTH-self.view.center.x, 0);
                [self.view layoutIfNeeded];
                self.customView.alpha = 0;
                self.dimBG.alpha = 0;
                self.blurBG.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromView];
            }];
        }
            break;
        case 4:
        {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.frame = CGRectOffset(self.customView.frame, SCREEN_WIDTH+self.view.center.x, 0);
                [self.view layoutIfNeeded];
                self.customView.alpha = 0;
                self.dimBG.alpha = 0;
                self.blurBG.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromView];
            }];
        }
            break;
        default:
        {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.customView.transform = CGAffineTransformMakeScale(1.5, 1.5);
                [self.view layoutIfNeeded];
                self.customView.alpha = 0;
                self.dimBG.alpha = 0;
                self.blurBG.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromView];
            }];
        }
            break;
    }
}

- (void)removeFromView {
    [self.customView removeFromSuperview];
    [self.dimBG removeFromSuperview];
    [self.blurBG removeFromSuperview];
    
    [self cleanCode];
}


#pragma mark - Cleaning

- (void)cleanCode {
    self.customView = nil;
    self.dimBG = nil;
    self.blurBG = nil;
}

@end
