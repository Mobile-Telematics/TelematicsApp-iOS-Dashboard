//
//  ProgressBarSpeed.h
//  CoreProduct
//
//  Created by Pavel 6450127@gmail.com on 16.01.18.
//  Copyright (c) 2017-2018 All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgressBarSpeed : UIView

@property (nonatomic) CGFloat progress;
@property (nonatomic) CGFloat barBorderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic) UIColor *barBorderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat barInnerBorderWidth UI_APPEARANCE_SELECTOR;
@property (nonatomic) UIColor *barInnerBorderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) CGFloat barInnerPadding UI_APPEARANCE_SELECTOR;
@property (nonatomic) UIColor *barFillColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) UIColor *barBackgroundColor UI_APPEARANCE_SELECTOR;
@property (nonatomic) NSInteger usesRoundedCorners UI_APPEARANCE_SELECTOR;

+ (UIColor *)defaultBarColor;

@end
