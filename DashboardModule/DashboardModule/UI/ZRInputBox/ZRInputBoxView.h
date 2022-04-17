//
//  ZRInputBoxView.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 31.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZRInputBoxType) {
    PlainTextInput,
    NumberInput,
    PhoneNumberInput,
    EmailInput,
    SecureTextInput,
    FirstNameLastNameInput
};


@interface ZRInputBoxView : UIView

+ (instancetype)boxOfType:(ZRInputBoxType)boxType;
- (void)setBlurEffectStyle:(UIBlurEffectStyle)blurEffectStyle;
- (void)setTitle:(NSString *)title;
- (void)setMessage:(NSString *)message;
- (void)setSubmitButtonText:(NSString *)submitButtonText;
- (void)setCancelButtonText:(NSString *)cancelButtonText;
- (void)setNumberOfDecimals:(int)numberOfDecimals;

- (void)show;
- (void)hide;

//@property (nonatomic, copy) BOOL(^onSubmit)(NSString *, NSString *);
@property (nonatomic, copy) void(^onSubmit)(void);
@property (nonatomic, copy) void(^onCancel)(void);
@property (nonatomic, copy) UITextField *(^customise)(UITextField *);

@property (nonatomic, assign) BOOL disableBlurEffect;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIColor *messageLabelTextColor;
@property (nonatomic, strong) UIColor *elementBackgroundColor;
@property (nonatomic, strong) UIColor *buttonBackgroundColor;
@property (nonatomic, strong) UIColor *buttonLabelTextColor;
@property (nonatomic, strong) UIColor *contentBackgroundColor;
@property (nonatomic, strong) UIColor *buttonBorderColor;

@end
