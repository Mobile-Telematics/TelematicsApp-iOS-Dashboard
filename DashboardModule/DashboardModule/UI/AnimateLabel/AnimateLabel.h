//
//  AnimateLabel.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 24.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSUInteger, MarqueeType) {
    MLLeftRight = 0,
    MLRightLeft = 1,
    MLContinuous = 2,
    MLContinuousReverse = 3,
    MLLeft = 4,
    MLRight = 5
};


#ifndef IBInspectable
#define IBInspectable
#endif

IB_DESIGNABLE
@interface AnimateLabel: UILabel <CAAnimationDelegate>

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame rate:(CGFloat)pixelsPerSec andFadeLength:(CGFloat)fadeLength;
- (instancetype)initWithFrame:(CGRect)frame duration:(NSTimeInterval)scrollDuration andFadeLength:(CGFloat)fadeLength;
- (void)minimizeLabelFrameWithMaximumSize:(CGSize)maxSize adjustHeight:(BOOL)adjustHeight;

@property (nonatomic, assign) UIViewAnimationOptions animationCurve;
@property (nonatomic, assign) IBInspectable BOOL labelize;
@property (nonatomic, assign) IBInspectable BOOL holdScrolling;
@property (nonatomic, assign) IBInspectable BOOL tapToScroll;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSInteger marqueeType;
#else
@property (nonatomic, assign) MarqueeType marqueeType;
#endif

@property (nonatomic, assign) IBInspectable CGFloat scrollDuration;
@property (nonatomic, assign) IBInspectable CGFloat rate;
@property (nonatomic, assign) IBInspectable CGFloat leadingBuffer;
@property (nonatomic, assign) IBInspectable CGFloat trailingBuffer;
@property (nonatomic, assign) CGFloat continuousMarqueeExtraBuffer __deprecated_msg("Use trailingBuffer instead.");
@property (nonatomic, assign) IBInspectable CGFloat fadeLength;
@property (nonatomic, assign) IBInspectable CGFloat animationDelay;
@property (nonatomic, readonly) NSTimeInterval animationDuration;

- (void)restartLabel;
- (void)shutdownLabel;
- (void)resetLabel __deprecated_msg("Use resetLabel instead");
- (void)pauseLabel;
- (void)unpauseLabel;
- (void)triggerScrollStart;
- (void)labelWillBeginScroll;
- (void)labelReturnedToHome:(BOOL)finished;


@property (nonatomic, assign, readonly) BOOL isPaused;
@property (nonatomic, assign, readonly) BOOL awayFromHome;

+ (void)restartLabelsOfController:(UIViewController *)controller;
+ (void)controllerViewDidAppear:(UIViewController *)controller;
+ (void)controllerViewWillAppear:(UIViewController *)controller;
+ (void)controllerViewAppearing:(UIViewController *)controller __deprecated_msg("Use controllerViewDidAppear: instead.");
+ (void)controllerLabelsShouldLabelize:(UIViewController *)controller;
+ (void)controllerLabelsShouldAnimate:(UIViewController *)controller;


@end


