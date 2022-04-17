//
//  ZRInputBoxView.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 31.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRInputBoxView.h"
#import "Color.h"

@interface ZRInputBoxView ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *submitButtonText;
@property (nonatomic, copy) NSString *cancelButtonText;
@property (nonatomic, assign) ZRInputBoxType boxType;
@property (nonatomic, assign) int numberOfDecimals;
@property (nonatomic, assign) UIBlurEffectStyle blurEffectStyle;
@property (nonatomic, strong) NSMutableArray *elements;
@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UITextField *textInput;
@property (nonatomic, strong) UITextField *secureInput;
@property (nonatomic, strong) UIView *actualBox;

@end


@implementation ZRInputBoxView


#pragma mark - Init

+ (instancetype)boxOfType:(ZRInputBoxType)boxType
{
    return [[self alloc]initWithBoxType:boxType];
}

- (instancetype)init
{
    return [self initWithBoxType:PlainTextInput];
}

- (instancetype)initWithBoxType:(ZRInputBoxType)boxType
{
    CGFloat actualBoxHeight = 155.0f;
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    CGRect allFrame = window.frame;

    CGRect boxFrame = CGRectMake(0, 0, MIN(325, window.frame.size.width - 50), actualBoxHeight);

    if ((self = [super initWithFrame:allFrame])) {
        self.boxType = boxType;
        self.backgroundColor = [UIColor colorWithRed:0.0/256.0 green:0.0/256.0 blue:0.0/256.0 alpha:0.8];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleHeight;
        self.actualBox = [[UIView alloc] initWithFrame:boxFrame];
        self.actualBox.center = CGPointMake(window.center.x, window.center.y);
        self.center = CGPointMake(window.center.x, window.center.y);
        [self addSubview:self.actualBox];
    }
    return self;
}


#pragma mark - Setters

- (void)setBlurEffectStyle:(UIBlurEffectStyle)blurEffectStyle
{
    _blurEffectStyle = blurEffectStyle;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
}

- (void)setMessage:(NSString *)message
{
    _message = message;
}

- (void)setNumberOfDecimals:(int)numberOfDecimals
{
    _numberOfDecimals = numberOfDecimals;
}

- (void)setSubmitButtonText:(NSString *)submitButtonText
{
    _submitButtonText = submitButtonText;
}

- (void)setCancelButtonText:(NSString *)cancelButtonText
{
    _cancelButtonText = cancelButtonText;
}


#pragma mark - Show & hide

- (void)show {
    
    self.alpha = 0.0f;
    [self setupView];

    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0f;
    }];

    UIWindow *window = [UIApplication sharedApplication].windows[0];
    [window addSubview:self];
    [window bringSubviewToFront:self];
    
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(deviceOrientationDidChange)
                   name:@"UIDeviceOrientationDidChangeNotification"
                 object:nil];
    
    [center addObserver:self
               selector:@selector(keyboardDidShow:)
                   name:@"UIKeyboardDidShowNotification" object:nil];

    [center addObserver:self
               selector:@selector(keyboardDidHide:)
                   name:@"UIKeyboardDidHideNotification" object:nil];
}
    
- (void)hide {
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];

        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

        [center removeObserver:self
                          name:@"UIDeviceOrientationDidChangeNotification"
                        object:nil];
        
        [center removeObserver:self
                          name:@"UIKeyboardDidShowNotification"
                        object:nil];
        [center removeObserver:self
                          name:@"UIKeyboardDidHideNotification"
                        object:nil];
    }];
}


#pragma mark - Setup the box

- (void)setupView
{
    self.elements = [NSMutableArray new];

    self.actualBox.layer.cornerRadius = 4.0;
    self.actualBox.layer.masksToBounds = true;
    self.disableBlurEffect = YES;
    
    if (!self.disableBlurEffect) {
        UIBlurEffectStyle style = UIBlurEffectStyleLight;
        if (self.blurEffectStyle) {
            style = self.blurEffectStyle;
        }
        
        switch (style) {
            case UIBlurEffectStyleDark:
                self.titleLabelTextColor = [Color officialWhiteColor];
                self.messageLabelTextColor = [Color officialWhiteColor];
                self.elementBackgroundColor = [UIColor colorWithWhite:1.0f alpha: 0.07f];
                self.buttonBackgroundColor = [UIColor colorWithWhite:1.0f alpha: 0.07f];
                self.buttonLabelTextColor = [Color officialWhiteColor];
                break;
            default:
                self.titleLabelTextColor = [UIColor blackColor];
                self.messageLabelTextColor = [UIColor blackColor];
                self.elementBackgroundColor = [UIColor colorWithWhite:1.0f alpha: 0.50f];
                self.buttonBackgroundColor = [UIColor colorWithWhite:1.0f alpha: 0.2f];
                self.buttonLabelTextColor = [UIColor blackColor];
                break;
        }
        
        UIVisualEffect *effect = [UIBlurEffect effectWithStyle:style];
        self.visualEffectView = [[UIVisualEffectView alloc]initWithEffect:effect];
    } else {
        self.titleLabelTextColor = [Color officialWhiteColor];
        self.messageLabelTextColor = [Color officialWhiteColor];
        self.elementBackgroundColor = [Color officialWhiteColor];
        self.buttonBackgroundColor = [Color officialMainAppColor];
        self.buttonLabelTextColor = [Color officialWhiteColor];
        self.contentBackgroundColor = [Color officialMainAppColor];
        self.buttonBorderColor = [Color officialWhiteColor];
    }

    CGFloat padding = 10.0f;
    CGFloat width = self.actualBox.frame.size.width - padding * 2;

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(padding, padding, width, 20)];
    titleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    titleLabel.text = self.title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = self.titleLabelTextColor;
    [self.contentView addSubview:titleLabel];

    UILabel *messageLabel = [[UILabel alloc]initWithFrame:
                               CGRectMake(padding, padding + titleLabel.frame.size.height + 5, width, 35.5)];
    messageLabel.numberOfLines = 2;
    messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
    messageLabel.font = [Font regular14];
    messageLabel.text = self.message;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = self.messageLabelTextColor;
    //[messageLabel sizeToFit];
    [self.contentView addSubview:messageLabel];

    switch (self.boxType) {

        case PlainTextInput:
            self.textInput = [[UITextField alloc]initWithFrame:
                              CGRectMake(padding, messageLabel.frame.origin.y + messageLabel.frame.size.height + padding / 1.5, width, 30)];
            self.textInput.textAlignment = NSTextAlignmentCenter;
            if (self.customise) {
                self.textInput = self.customise(self.textInput);
            }
            [self.elements addObject:self.textInput];
            self.textInput.autocorrectionType = UITextAutocorrectionTypeNo;
            break;


        case NumberInput:
            self.textInput = [[UITextField alloc] initWithFrame:
                              CGRectMake(padding, messageLabel.frame.origin.y + messageLabel.frame.size.height + padding / 1.5, width, 30)];
            self.textInput.textAlignment = NSTextAlignmentCenter;
            if (self.customise) {
                self.textInput = self.customise(self.textInput);
            }
            [self.elements addObject:self.textInput];
            self.textInput.keyboardType = UIKeyboardTypeNumberPad;
            [self.textInput addTarget:self action:@selector(textInputDidChange) forControlEvents:UIControlEventEditingChanged];
            break;


        case EmailInput:
            self.textInput = [[UITextField alloc] initWithFrame:
                              CGRectMake(padding, messageLabel.frame.origin.y + messageLabel.frame.size.height + padding / 1.5, width, 30)];
            self.textInput.textAlignment = NSTextAlignmentCenter;
            if (self.customise) {
                self.textInput = self.textInput = self.customise(self.textInput);
            }
            [self.elements addObject:self.textInput];
            self.textInput.keyboardType = UIKeyboardTypeEmailAddress;
            self.textInput.autocorrectionType = UITextAutocorrectionTypeNo;
            break;


        case SecureTextInput:
            self.textInput = [[UITextField alloc] initWithFrame:
                              CGRectMake(padding, messageLabel.frame.origin.y + messageLabel.frame.size.height + padding / 1.5, width, 30)];
            self.textInput.textAlignment = NSTextAlignmentCenter;
            if (self.customise) {
                self.textInput = self.customise(self.textInput);
            }
            [self.elements addObject:self.textInput];
            break;


        case PhoneNumberInput:
            self.textInput = [[UITextField alloc] initWithFrame:
                              CGRectMake(padding, messageLabel.frame.origin.y + messageLabel.frame.size.height + padding / 1.5, width, 30)];
            self.textInput.textAlignment = NSTextAlignmentCenter;
            if (self.customise) {
                self.textInput = self.customise(self.textInput);
            }
            [self.elements addObject:self.textInput];
            self.textInput.keyboardType = UIKeyboardTypePhonePad;
            break;


        case FirstNameLastNameInput:

            self.textInput = [[UITextField alloc] initWithFrame:
                              CGRectMake(padding, messageLabel.frame.origin.y + messageLabel.frame.size.height + padding, width, 30)];
            self.textInput.textAlignment = NSTextAlignmentCenter;

            if (self.customise) {
                self.textInput = self.customise(self.textInput);
            }
            self.textInput.autocorrectionType = UITextAutocorrectionTypeNo;
            [self.elements addObject:self.textInput];

            self.secureInput = [[UITextField alloc] initWithFrame:
                                CGRectMake(padding, self.textInput.frame.origin.y + self.textInput.frame.size.height + padding, width, 30)];
            self.secureInput.textAlignment = NSTextAlignmentCenter;
            self.secureInput.autocorrectionType = UITextAutocorrectionTypeNo;
            //self.secureInput.autocapitalizationType = UITextAutocapitalizationTypeNone;
            self.secureInput.tag = 1;

            if (self.customise) {
                self.secureInput = self.customise(self.secureInput);
            }

            [self.elements addObject:self.secureInput];
            
            CGRect extendedFrame = self.actualBox.frame;
            extendedFrame.size.height += 45;
            self.actualBox.frame = extendedFrame;
            break;

        default:
            NSAssert(NO, @"You should set a proper ZRInputStyle");
            break;
    }

    for (UITextField *element in self.elements) {
        element.layer.borderColor = [UIColor colorWithWhite:0.0f alpha:0.1f].CGColor;
        element.layer.borderWidth = 0.5;
        element.backgroundColor = self.elementBackgroundColor;
        [self.contentView addSubview:element];
    }

    CGFloat buttonHeight = 40.0f;
    CGFloat buttonWidth = self.actualBox.frame.size.width / 2;

    UIButton *cancelButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, self.actualBox.frame.size.height - buttonHeight, buttonWidth, buttonHeight)];
    [cancelButton setTitle:self.cancelButtonText != nil ? self.cancelButtonText : @"Cancel" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [Font regular16];
    [cancelButton setTitleColor:self.buttonLabelTextColor forState: UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor grayColor] forState: UIControlStateHighlighted];
    cancelButton.backgroundColor = self.buttonBackgroundColor;
    cancelButton.layer.borderColor = [UIColor colorWithWhite: 0.0f alpha: 0.1f].CGColor;
    cancelButton.layer.borderWidth = 0.5;
    [self.contentView addSubview:cancelButton];

    UIButton *submitButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, self.actualBox.frame.size.height - buttonHeight, buttonWidth, buttonHeight)];
    [submitButton setTitle:self.submitButtonText != nil ? self.submitButtonText:localizeString(@"Ok") forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonTapped) forControlEvents: UIControlEventTouchUpInside];
    submitButton.titleLabel.font = [Font regular16];
    [submitButton setTitleColor:self.buttonLabelTextColor forState: UIControlStateNormal];
    [submitButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    submitButton.backgroundColor = self.buttonBackgroundColor;
    submitButton.layer.borderColor = [UIColor colorWithWhite:0.0f alpha: 0.1f].CGColor;
    submitButton.layer.borderWidth = 0.5;
    [self.contentView addSubview:submitButton];
    
    if (self.buttonBorderColor) {
        CGFloat borderWidth = 1;
        UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0, cancelButton.frame.origin.y, cancelButton.frame.size.width + submitButton.frame.size.width, borderWidth)];
        topBorder.backgroundColor = self.buttonBorderColor;
        [self.contentView addSubview:topBorder];
        
        UIView *centerBorder = [[UIView alloc] initWithFrame:CGRectMake(cancelButton.frame.size.width - borderWidth, 0, borderWidth, cancelButton.frame.size.height)];
        centerBorder.backgroundColor = self.buttonBorderColor;
        [cancelButton addSubview:centerBorder];
    }

    if (!self.disableBlurEffect) {
        self.visualEffectView.frame = CGRectMake(0, 0, self.actualBox.frame.size.width, self.actualBox.frame.size.height + 45);
        [self.actualBox addSubview:self.visualEffectView];
    }
    
    if (self.contentBackgroundColor) {
        self.contentView.backgroundColor = self.contentBackgroundColor;
    }
    
    self.actualBox.center = self.center;
}

- (UIView *)contentView {
    return !self.disableBlurEffect ? self.visualEffectView.contentView : self.actualBox;
}


#pragma mark - Handle device rotation

- (void)deviceOrientationDidChange
{
    [self resetFrame:YES];
}


#pragma mark - Button handlers

- (void)cancelButtonTapped
{
    if (self.onCancel != nil) {
        self.onCancel();
    }
    [self hide];
}

- (void)submitButtonTapped {
    if (self.onSubmit != nil) {
        NSString *textValue = self.textInput.text;
        //NSString *passValue = self.secureInput.text;
        defaults_set_object(@"invitationCodeForCompanyID", textValue);
        
        if (self.onSubmit != nil) {
            self.onSubmit();
            [self hide];
        }
        
//        if (self.onSubmit (textValue, passValue)) {
//            [self hide];
//        }
        
    } else {
        [self hide];
    }
}


#pragma mark - Numbers

- (void)textInputDidChange
{
    NSString *sText = self.textInput.text;
    sText = [sText stringByReplacingOccurrencesOfString:@"." withString:@""];
    double power = pow(10.0f, (double)self.numberOfDecimals);
    double number = sText.doubleValue / power;
    NSString *sPattern = [NSString stringWithFormat:@"%%.%df", self.numberOfDecimals];
    self.textInput.text = [NSString stringWithFormat:sPattern, number];
}


#pragma mark - Keyboard

- (void)keyboardDidShow:(NSNotification *)notification
{
    [self resetFrame:YES];

    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = self.actualBox.frame;
        frame.origin.y -= [self yCorrection];
        self.actualBox.frame = frame;
    }];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    [self resetFrame:YES];
}

- (CGFloat)yCorrection
{
    CGFloat yCorrection = 35.0f;

    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
            yCorrection = 80.0f;
        }
        else if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            yCorrection = 100.0f;
        }

        if (self.boxType == FirstNameLastNameInput) {
            yCorrection += 45.0f;
        }
    }
    else {
        if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            yCorrection = 0.0f;
        }
    }
    return yCorrection;
}

- (void)resetFrame:(BOOL)animated
{
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    self.frame = window.frame;

    if (animated) {
        [UIView animateWithDuration:0.3f animations:^{
            self.center = CGPointMake(window.center.x, window.center.y);
            self.actualBox.center = self.center;
        }];
    }
    else {
        self.center = CGPointMake(window.center.x, window.center.y);
        self.actualBox.center = self.center;
    }
}



@end
