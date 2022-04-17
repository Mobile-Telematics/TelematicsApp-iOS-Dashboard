//
//  AnimateLabel.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 24.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "AnimateLabel.h"
#import <QuartzCore/QuartzCore.h>

NSString *const kAnimateLabelControllerRestartNotification = @"AnimateLabelViewControllerRestart";
NSString *const kAnimateLabelShouldLabelizeNotification = @"AnimateLabelShouldLabelizeNotification";
NSString *const kAnimateLabelShouldAnimateNotification = @"AnimateLabelShouldAnimateNotification";
NSString *const kAnimateLabelAnimationCompletionBlock = @"AnimateLabelAnimationCompletionBlock";

typedef void(^MLAnimationCompletionBlock)(BOOL finished);

#define SYSTEM_VERSION_IS_8_0_X ([[[UIDevice currentDevice] systemVersion] hasPrefix:@"8.0"])
#define CGFLOAT_LONG_DURATION 60*60*24*365

@interface GradientSetupAnimation: CABasicAnimation
@end

@interface UIView (AnimateLabelHelpers)
- (UIViewController *)firstAvailableViewController;
- (id)traverseResponderChainForFirstViewController;
@end

@interface CAMediaTimingFunction (AnimateLabelHelpers)
- (NSArray *)controlPoints;
- (CGFloat)durationPercentageForPositionPercentage:(CGFloat)positionPercentage withDuration:(NSTimeInterval)duration;
@end

@interface AnimateLabel()

@property (nonatomic, strong) UILabel *subLabel;

@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign, readonly) BOOL labelShouldScroll;
@property (nonatomic, weak) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, assign) CGRect homeLabelFrame;
@property (nonatomic, assign) CGFloat awayOffset;
@property (nonatomic, assign, readwrite) BOOL isPaused;
@property (nonatomic, copy) MLAnimationCompletionBlock scrollCompletionBlock;
@property (nonatomic, strong) NSArray *gradientColors;
CGPoint MLOffsetCGPoint(CGPoint point, CGFloat offset);

@end


@implementation AnimateLabel

#pragma mark - Class Methods and handlers

+ (void)restartLabelsOfController:(UIViewController *)controller {
    [AnimateLabel notifyController:controller
                       withMessage:kAnimateLabelControllerRestartNotification];
}

+ (void)controllerViewWillAppear:(UIViewController *)controller {
    [AnimateLabel restartLabelsOfController:controller];
}

+ (void)controllerViewDidAppear:(UIViewController *)controller {
    [AnimateLabel restartLabelsOfController:controller];
}

+ (void)controllerViewAppearing:(UIViewController *)controller {
    [AnimateLabel restartLabelsOfController:controller];
}

+ (void)controllerLabelsShouldLabelize:(UIViewController *)controller {
    [AnimateLabel notifyController:controller
                       withMessage:kAnimateLabelShouldLabelizeNotification];
}

+ (void)controllerLabelsShouldAnimate:(UIViewController *)controller {
    [AnimateLabel notifyController:controller
                       withMessage:kAnimateLabelShouldAnimateNotification];
}

+ (void)notifyController:(UIViewController *)controller withMessage:(NSString *)message
{
    if (controller && message) {
        [[NSNotificationCenter defaultCenter] postNotificationName:message
                                                            object:nil
                                                          userInfo:[NSDictionary dictionaryWithObject:controller
                                                                                               forKey:@"controller"]];
    }
}

- (void)viewControllerShouldRestart:(NSNotification *)notification {
    UIViewController *controller = [[notification userInfo] objectForKey:@"controller"];
    if (controller == [self firstAvailableViewController]) {
        [self restartLabel];
    }
}

- (void)labelsShouldLabelize:(NSNotification *)notification {
    UIViewController *controller = [[notification userInfo] objectForKey:@"controller"];
    if (controller == [self firstAvailableViewController]) {
        self.labelize = YES;
    }
}

- (void)labelsShouldAnimate:(NSNotification *)notification {
    UIViewController *controller = [[notification userInfo] objectForKey:@"controller"];
    if (controller == [self firstAvailableViewController]) {
        self.labelize = NO;
    }
}

#pragma mark - Initialization and Label Config

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame duration:7.0 andFadeLength:0.0];
}

- (id)initWithFrame:(CGRect)frame duration:(NSTimeInterval)aLengthOfScroll andFadeLength:(CGFloat)aFadeLength {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLabel];
        
        _scrollDuration = aLengthOfScroll;
        self.fadeLength = MIN(aFadeLength, frame.size.width/2);
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame rate:(CGFloat)pixelsPerSec andFadeLength:(CGFloat)aFadeLength {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLabel];
        
        _rate = pixelsPerSec;
        self.fadeLength = MIN(aFadeLength, frame.size.width/2);
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupLabel];
        
        if (self.scrollDuration == 0) {
            self.scrollDuration = 30.0;
        }
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self forwardPropertiesToSubLabel];
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    [self forwardPropertiesToSubLabel];
}

+ (Class)layerClass {
    return [CAReplicatorLayer class];
}

- (CAReplicatorLayer *)repliLayer {
    return (CAReplicatorLayer *)self.layer;
}

- (CAGradientLayer *)maskLayer {
    return (CAGradientLayer *)self.layer.mask;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetFillColorWithColor(ctx, self.backgroundColor.CGColor);
    CGContextFillRect(ctx, layer.bounds);
}

- (void)forwardPropertiesToSubLabel {
    NSArray *properties = @[@"baselineAdjustment", @"enabled", @"highlighted", @"highlightedTextColor",
                            @"minimumFontSize", @"textAlignment",
                            @"userInteractionEnabled", @"adjustsFontSizeToFitWidth",
                            @"lineBreakMode", @"numberOfLines", @"contentMode"];
    
    self.subLabel.text = super.text;
    self.subLabel.font = super.font;
    self.subLabel.textColor = super.textColor;
    self.subLabel.backgroundColor = (super.backgroundColor == nil ? [UIColor clearColor] : super.backgroundColor);
    self.subLabel.shadowColor = super.shadowColor;
    self.subLabel.shadowOffset = super.shadowOffset;
    for (NSString *property in properties) {
        id val = [super valueForKey:property];
        [self.subLabel setValue:val forKey:property];
    }
}

- (void)setupLabel {
    
    self.clipsToBounds = YES;
    self.numberOfLines = 1;
    
    self.subLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.subLabel.tag = 700;
    self.subLabel.layer.anchorPoint = CGPointMake(0.0f, 0.0f);
    
    [self addSubview:self.subLabel];
    
    _marqueeType = MLContinuous;
    _awayOffset = 0.0f;
    _animationCurve = UIViewAnimationOptionCurveLinear;
    _labelize = NO;
    _holdScrolling = NO;
    _tapToScroll = NO;
    _isPaused = NO;
    _fadeLength = 0.0f;
    _animationDelay = 1.0;
    _animationDuration = 0.0f;
    _leadingBuffer = 0.0f;
    _trailingBuffer = 0.0f;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewControllerShouldRestart:) name:kAnimateLabelControllerRestartNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(labelsShouldLabelize:) name:kAnimateLabelShouldLabelizeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(labelsShouldAnimate:) name:kAnimateLabelShouldAnimateNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(restartLabel) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shutdownLabel) name:UIApplicationDidEnterBackgroundNotification object:nil];
}

- (void)minimizeLabelFrameWithMaximumSize:(CGSize)maxSize adjustHeight:(BOOL)adjustHeight {
    if (self.subLabel.text != nil) {
        if (CGSizeEqualToSize(maxSize, CGSizeZero)) {
            maxSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
        }
        CGSize minimumLabelSize = [self subLabelSize];
        
        CGSize minimumSize = CGSizeMake(minimumLabelSize.width + (self.fadeLength * 2), minimumLabelSize.height);
        minimumSize = CGSizeMake(MIN(minimumSize.width, maxSize.width), MIN(minimumSize.height, maxSize.height));
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, minimumSize.width, (adjustHeight ? minimumSize.height : self.frame.size.height));
    }
}

- (void)didMoveToSuperview {
    [self updateSublabel];
}

#pragma mark - AnimateLabel Heavy Lifting

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateSublabel];
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    if (!newWindow) {
        [self shutdownLabel];
    }
}

- (void)didMoveToWindow {
    if (!self.window) {
        [self shutdownLabel];
    } else {
        [self updateSublabel];
    }
}

- (void)updateSublabel {
    [self updateSublabelAndBeginScroll:YES];
}

- (void)updateSublabelAndBeginScroll:(BOOL)beginScroll {
    if (!self.subLabel.text || !self.superview) {
        return;
    }
    
    CGSize expectedLabelSize = [self subLabelSize];
    
    [self invalidateIntrinsicContentSize];
    
    [self returnLabelToOriginImmediately];
    
    [self applyGradientMaskForFadeLength:self.fadeLength animated:YES];
    
    if (!self.labelShouldScroll) {
        self.subLabel.textAlignment = [super textAlignment];
        self.subLabel.lineBreakMode = [super lineBreakMode];
        
        CGRect labelFrame, unusedFrame;
        switch (self.marqueeType) {
            case MLContinuousReverse:
            case MLRightLeft:
            case MLRight:
                CGRectDivide(self.bounds, &unusedFrame, &labelFrame, self.leadingBuffer, CGRectMaxXEdge);
                labelFrame = CGRectIntegral(labelFrame);
                break;
                
            default:
                labelFrame = CGRectIntegral(CGRectMake(self.leadingBuffer, 0.0f, self.bounds.size.width - self.leadingBuffer, self.bounds.size.height));
                break;
        }
        
        self.homeLabelFrame = labelFrame;
        self.awayOffset = 0.0f;
        
        self.repliLayer.instanceCount = 1;
        
        self.subLabel.frame = labelFrame;
        
        [self removeGradientMask];
        
        return;
    }
    
    [self.subLabel setLineBreakMode:NSLineBreakByClipping];
    
    CGFloat minTrailing = MAX(MAX(self.leadingBuffer, self.trailingBuffer), self.fadeLength);
    
    switch (self.marqueeType) {
        case MLContinuous:
        case MLContinuousReverse:
        {
            if (self.marqueeType == MLContinuous) {
                self.homeLabelFrame = CGRectIntegral(CGRectMake(self.leadingBuffer, 0.0f, expectedLabelSize.width, self.bounds.size.height));
                self.awayOffset = -(self.homeLabelFrame.size.width + minTrailing);
            } else {
                self.homeLabelFrame = CGRectIntegral(CGRectMake(self.bounds.size.width - (expectedLabelSize.width + self.leadingBuffer), 0.0f, expectedLabelSize.width, self.bounds.size.height));
                self.awayOffset = (self.homeLabelFrame.size.width + minTrailing);
            }
            
            self.subLabel.frame = self.homeLabelFrame;
            
            self.repliLayer.instanceCount = 2;
            self.repliLayer.instanceTransform = CATransform3DMakeTranslation(-self.awayOffset, 0.0, 0.0);
            
            self.animationDuration = (self.rate != 0) ? ((NSTimeInterval) fabs(self.awayOffset) / self.rate) : (self.scrollDuration);
            
            break;
        }
            
        case MLRightLeft:
        case MLRight:
        {
            self.homeLabelFrame = CGRectIntegral(CGRectMake(self.bounds.size.width - (expectedLabelSize.width + self.leadingBuffer), 0.0f, expectedLabelSize.width, self.bounds.size.height));
            self.awayOffset = (expectedLabelSize.width + self.trailingBuffer + self.leadingBuffer) - self.bounds.size.width;
            
            self.animationDuration = (self.rate != 0) ? (NSTimeInterval)fabs(self.awayOffset / self.rate) : (self.scrollDuration);
            
            self.subLabel.frame = self.homeLabelFrame;
            
            self.repliLayer.instanceCount = 1;
            
            self.subLabel.textAlignment = NSTextAlignmentRight;
            
            break;
        }
            
        case MLLeftRight:
        case MLLeft:
        {
            self.homeLabelFrame = CGRectIntegral(CGRectMake(self.leadingBuffer, 0.0f, expectedLabelSize.width, self.bounds.size.height));
            self.awayOffset = self.bounds.size.width - (expectedLabelSize.width + self.leadingBuffer + self.trailingBuffer);
            
            self.animationDuration = (self.rate != 0) ? (NSTimeInterval)fabs(self.awayOffset / self.rate) : (self.scrollDuration);
            
            self.subLabel.frame = self.homeLabelFrame;
            
            self.repliLayer.instanceCount = 1;
            
            self.subLabel.textAlignment = NSTextAlignmentLeft;
            
            break;
        }
            
        default:
        {
            self.homeLabelFrame = CGRectZero;
            self.awayOffset = 0.0f;
            
            return;
            break;
        }
            
    }
    
    if (!self.tapToScroll && !self.holdScrolling && beginScroll) {
        [self beginScroll];
    }
}

- (CGSize)subLabelSize {
    CGSize expectedLabelSize = CGSizeZero;
    CGSize maximumLabelSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    
    expectedLabelSize = [self.subLabel sizeThatFits:maximumLabelSize];
    expectedLabelSize.width = MIN(expectedLabelSize.width, 5461.0f);
    expectedLabelSize.height = self.bounds.size.height;
    
    return expectedLabelSize;
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize fitSize = [self.subLabel sizeThatFits:size];
    fitSize.width += self.leadingBuffer;
    return fitSize;
}

#pragma mark - Animation Handlers

- (BOOL)labelShouldScroll {
    BOOL stringLength = ([self.subLabel.text length] > 0);
    if (!stringLength) {
        return NO;
    }
    
    BOOL labelTooLarge = ([self subLabelSize].width + self.leadingBuffer > self.bounds.size.width + FLT_EPSILON);
    BOOL animationHasDuration = (self.scrollDuration > 0.0f || self.rate > 0.0f);
    return (!self.labelize && labelTooLarge && animationHasDuration);
}

- (BOOL)labelReadyForScroll {
    if (!self.superview) {
        return NO;
    }
    
    if (!self.window) {
        return NO;
    }
    
    UIViewController *viewController = [self firstAvailableViewController];
    if (!viewController.isViewLoaded) {
        return NO;
    }
    
    return YES;
}

- (void)beginScroll {
    [self beginScrollWithDelay:YES];
}

- (void)beginScrollWithDelay:(BOOL)delay {
    switch (self.marqueeType) {
        case MLContinuous:
        case MLContinuousReverse:
            [self scrollContinuousWithInterval:self.animationDuration after:(delay ? self.animationDelay : 0.0)];
            break;
        case MLLeft:
        case MLRight:
            [self scrollAwayWithInterval:self.animationDuration delayAmount:(delay ? self.animationDelay : 0.0) shouldReturn:NO];
            break;
        default:
            [self scrollAwayWithInterval:self.animationDuration];
            break;
    }
}

- (void)returnLabelToOriginImmediately {
    [self.layer.mask removeAllAnimations];
    
    [self.subLabel.layer removeAllAnimations];
    
    self.scrollCompletionBlock = nil;
}

- (void)scrollAwayWithInterval:(NSTimeInterval)interval {
    [self scrollAwayWithInterval:interval delay:YES];
}

- (void)scrollAwayWithInterval:(NSTimeInterval)interval delay:(BOOL)delay {
    [self scrollAwayWithInterval:interval delayAmount:(delay ? self.animationDelay : 0.0) shouldReturn:YES];
}

- (void)scrollAwayWithInterval:(NSTimeInterval)interval delayAmount:(NSTimeInterval)delayAmount shouldReturn:(BOOL)shouldReturn {
    if (![self labelReadyForScroll]) {
        return;
    }
    
    [self returnLabelToOriginImmediately];
    
    [self labelWillBeginScroll];
    
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:(!shouldReturn ? CGFLOAT_MAX : 2.0 * (delayAmount + interval))];
    
    if (self.fadeLength != 0.0f) {
        CAKeyframeAnimation *gradAnim = [self keyFrameAnimationForGradientFadeLength:self.fadeLength
                                                                            interval:interval
                                                                               delay:delayAmount];
        [self.layer.mask addAnimation:gradAnim forKey:@"gradient"];
    }
    
    __weak __typeof__(self) weakSelf = self;
    self.scrollCompletionBlock = ^(BOOL finished) {
        if (!weakSelf) {
            return;
        }
        
        [weakSelf labelReturnedToHome:YES];
        
        if (!weakSelf.window) {
            return;
        }
        
        if ([weakSelf.subLabel.layer animationForKey:@"position"]) {
            return;
        }
        
        if (!finished) {
            return;
        }
        
        if (!weakSelf.scrollCompletionBlock) {
            return;
        }
        
        if (weakSelf.labelShouldScroll && !weakSelf.tapToScroll && !weakSelf.holdScrolling) {
            [weakSelf scrollAwayWithInterval:interval delayAmount:delayAmount shouldReturn:shouldReturn];
        }
    };
    
    CGPoint homeOrigin = self.homeLabelFrame.origin;
    CGPoint awayOrigin = MLOffsetCGPoint(self.homeLabelFrame.origin, self.awayOffset);
    
    NSArray *values = nil;
    switch (self.marqueeType) {
        case MLLeft:
        case MLRight:
            values = @[[NSValue valueWithCGPoint:homeOrigin],
                       [NSValue valueWithCGPoint:homeOrigin],
                       [NSValue valueWithCGPoint:awayOrigin],
                       [NSValue valueWithCGPoint:awayOrigin]];
            break;
            
        default:
            values = @[[NSValue valueWithCGPoint:homeOrigin],
                       [NSValue valueWithCGPoint:homeOrigin],
                       [NSValue valueWithCGPoint:awayOrigin],
                       [NSValue valueWithCGPoint:awayOrigin],
                       [NSValue valueWithCGPoint:homeOrigin]];
            break;
    }
    
    CAKeyframeAnimation *awayAnim = [self keyFrameAnimationForProperty:@"position"
                                                                values:values
                                                              interval:interval
                                                                 delay:delayAmount];
    [awayAnim setValue:@(YES) forKey:kAnimateLabelAnimationCompletionBlock];
    
    [self.subLabel.layer addAnimation:awayAnim forKey:@"position"];
    
    [CATransaction commit];
}

- (void)scrollContinuousWithInterval:(NSTimeInterval)interval after:(NSTimeInterval)delayAmount {
    [self scrollContinuousWithInterval:interval after:delayAmount labelAnimation:nil gradientAnimation:nil];
}

- (void)scrollContinuousWithInterval:(NSTimeInterval)interval
                               after:(NSTimeInterval)delayAmount
                      labelAnimation:(CAKeyframeAnimation *)labelAnimation
                   gradientAnimation:(CAKeyframeAnimation *)gradientAnimation {

    if (![self labelReadyForScroll]) {
        return;
    }
    
    [self returnLabelToOriginImmediately];
    
    [self labelWillBeginScroll];
    
    [CATransaction begin];
    
    [CATransaction setAnimationDuration:(delayAmount + interval)];
    
    if (self.fadeLength != 0.0f) {
        if (!gradientAnimation) {
            gradientAnimation = [self keyFrameAnimationForGradientFadeLength:self.fadeLength
                                                                    interval:interval
                                                                       delay:delayAmount];
        }
        [self.layer.mask addAnimation:gradientAnimation forKey:@"gradient"];
    }
    
    if (!labelAnimation) {
        CGPoint homeOrigin = self.homeLabelFrame.origin;
        CGPoint awayOrigin = MLOffsetCGPoint(self.homeLabelFrame.origin, self.awayOffset);
        NSArray *values = @[[NSValue valueWithCGPoint:homeOrigin],
                            [NSValue valueWithCGPoint:homeOrigin],
                            [NSValue valueWithCGPoint:awayOrigin]];
        
        labelAnimation = [self keyFrameAnimationForProperty:@"position"
                                                     values:values
                                                   interval:interval
                                                      delay:delayAmount];
    }
    
    __weak __typeof__(self) weakSelf = self;
    self.scrollCompletionBlock = ^(BOOL finished) {
        if (!finished || !weakSelf) {
            return;
        }
        
        [weakSelf labelReturnedToHome:YES];
        
        if (weakSelf.window && ![weakSelf.subLabel.layer animationForKey:@"position"]) {
            if (weakSelf.labelShouldScroll && !weakSelf.tapToScroll && !weakSelf.holdScrolling) {
                [weakSelf scrollContinuousWithInterval:interval
                                             after:delayAmount
                                    labelAnimation:labelAnimation
                                 gradientAnimation:gradientAnimation];
            }
        }
    };
    
    [labelAnimation setValue:@(YES) forKey:kAnimateLabelAnimationCompletionBlock];
    [self.subLabel.layer addAnimation:labelAnimation forKey:@"position"];
    
    [CATransaction commit];
}

- (void)applyGradientMaskForFadeLength:(CGFloat)fadeLength animated:(BOOL)animated {
    
    [self.layer.mask removeAllAnimations];
    
    if (fadeLength <= 0.0f) {
        [self removeGradientMask];
        return;
    }
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    CAGradientLayer *gradientMask = (CAGradientLayer *)self.layer.mask;
    
    NSObject *transparent = (NSObject *)[[UIColor clearColor] CGColor];
    NSObject *opaque = (NSObject *)[[UIColor blackColor] CGColor];
    
    if (!gradientMask) {
        gradientMask = [CAGradientLayer layer];
        gradientMask.shouldRasterize = YES;
        gradientMask.rasterizationScale = [UIScreen mainScreen].scale;
        gradientMask.startPoint = CGPointMake(0.0f, 0.5f);
        gradientMask.endPoint = CGPointMake(1.0f, 0.5f);
    }
    
    if (!CGRectEqualToRect(gradientMask.bounds, self.bounds)) {
        CGFloat leftFadeStop = fadeLength/self.bounds.size.width;
        CGFloat rightFadeStop = fadeLength/self.bounds.size.width;
        gradientMask.locations = @[@(0.0f), @(leftFadeStop), @(1.0f - rightFadeStop), @(1.0f)];
    }
    
    gradientMask.bounds = self.layer.bounds;
    gradientMask.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    self.layer.mask = gradientMask;
    
    NSArray *adjustedColors;
    BOOL trailingFadeNeeded = self.labelShouldScroll;
    switch (self.marqueeType) {
        case MLContinuousReverse:
        case MLRightLeft:
        case MLRight:
            adjustedColors = @[(trailingFadeNeeded ? transparent : opaque),
                               opaque,
                               opaque,
                               opaque];
            break;
            
        default:
            adjustedColors = @[opaque,
                               opaque,
                               opaque,
                               (trailingFadeNeeded ? transparent : opaque)];
            break;
    }
    
#if TARGET_INTERFACE_BUILDER
    animated = NO;
#endif
    
    if (animated) {
        [CATransaction commit];
        
        GradientSetupAnimation *colorAnimation = [GradientSetupAnimation animationWithKeyPath:@"colors"];
        colorAnimation.fromValue = gradientMask.colors;
        colorAnimation.toValue = adjustedColors;
        colorAnimation.duration = 0.25;
        colorAnimation.removedOnCompletion = NO;
        colorAnimation.delegate = self;
        [gradientMask addAnimation:colorAnimation forKey:@"setupFade"];
    } else {
        gradientMask.colors = adjustedColors;
        [CATransaction commit];
    }
}

- (void)removeGradientMask {
    self.layer.mask = nil;
}

- (CAKeyframeAnimation *)keyFrameAnimationForGradientFadeLength:(CGFloat)fadeLength
                                                       interval:(NSTimeInterval)interval
                                                          delay:(NSTimeInterval)delayAmount
{
    NSArray *values = nil;
    NSArray *keyTimes = nil;
    NSTimeInterval totalDuration;
    NSObject *transp = (NSObject *)[[UIColor clearColor] CGColor];
    NSObject *opaque = (NSObject *)[[UIColor blackColor] CGColor];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"colors"];
    
    CAMediaTimingFunction *timingFunction = [self timingFunctionForAnimationOptions:self.animationCurve];
    
    switch (self.marqueeType) {
        case MLLeftRight:
        case MLRightLeft:
            totalDuration = 2.0 * (delayAmount + interval);
            keyTimes = @[@(0.0),
                         @(delayAmount/totalDuration),
                         @((delayAmount + 0.4)/totalDuration),
                         @((delayAmount + interval - 0.4)/totalDuration),
                         @((delayAmount + interval)/totalDuration),
                         @((delayAmount + interval + delayAmount)/totalDuration),
                         @((delayAmount + interval + delayAmount + 0.4)/totalDuration),
                         @((totalDuration - 0.4)/totalDuration),
                         @(1.0)];
            break;
            
        case MLLeft:
        case MLRight:
            totalDuration = CGFLOAT_MAX;
            keyTimes = @[@(0.0),
                         @(delayAmount/totalDuration),
                         @((delayAmount + 0.4)/totalDuration),
                         @((delayAmount + interval - 0.4)/totalDuration),
                         @((delayAmount + interval)/totalDuration),
                         @(1.0)];                                                       
            break;
        case MLContinuousReverse:
        default:
            totalDuration = delayAmount + interval;
            
            CGFloat startFadeFraction = fabs((self.subLabel.bounds.size.width + self.leadingBuffer) / self.awayOffset);
            CGFloat startFadeTimeFraction = [timingFunction durationPercentageForPositionPercentage:startFadeFraction withDuration:totalDuration];
            NSTimeInterval startFadeTime = delayAmount + startFadeTimeFraction * interval;
            
            keyTimes = @[
                         @(0.0),
                         @(delayAmount/totalDuration),
                         @((delayAmount + 0.2)/totalDuration),
                         @((startFadeTime)/totalDuration),
                         @((startFadeTime + 0.1)/totalDuration),
                         @(1.0)
                         ];
            break;
    }
    
    CAGradientLayer *currentMask = [[self maskLayer] presentationLayer];
    NSArray *currentValues = currentMask.colors;
    
    switch (self.marqueeType) {
        case MLContinuousReverse:
            values = @[
                       (currentValues ? currentValues : @[transp, opaque, opaque, opaque]),
                       @[transp, opaque, opaque, opaque],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, opaque],
                       @[transp, opaque, opaque, opaque]
                       ];
            break;
            
        case MLRight:
            values = @[
                       (currentValues ? currentValues : @[transp, opaque, opaque, opaque]),
                       @[transp, opaque, opaque, opaque],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[opaque, opaque, opaque, transp],
                       @[opaque, opaque, opaque, transp],
                       ];
            break;
            
        case MLRightLeft:
            values = @[
                       (currentValues ? currentValues : @[transp, opaque, opaque, opaque]),
                       @[transp, opaque, opaque, opaque],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[opaque, opaque, opaque, transp],
                       @[opaque, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, opaque]
                       ];
            break;
            
        case MLContinuous:
            values = @[
                       (currentValues ? currentValues : @[opaque, opaque, opaque, transp]),
                       @[opaque, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[opaque, opaque, opaque, transp],
                       @[opaque, opaque, opaque, transp]
                       ];
            break;
            
        case MLLeft:
            values = @[
                       (currentValues ? currentValues : @[opaque, opaque, opaque, transp]),
                       @[opaque, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, opaque],
                       @[transp, opaque, opaque, opaque],
                       ];
            break;
            
        case MLLeftRight:
        default:
            values = @[
                       (currentValues ? currentValues : @[opaque, opaque, opaque, transp]),
                       @[opaque, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, opaque],
                       @[transp, opaque, opaque, opaque],
                       @[transp, opaque, opaque, transp],
                       @[transp, opaque, opaque, transp],
                       @[opaque, opaque, opaque, transp]
                       ];
            break;
    }
    
    animation.values = values;
    animation.keyTimes = keyTimes;
    animation.timingFunctions = @[timingFunction, timingFunction, timingFunction, timingFunction];
    
    return animation;
}

- (CAKeyframeAnimation *)keyFrameAnimationForProperty:(NSString *)property
                                               values:(NSArray *)values
                                             interval:(NSTimeInterval)interval
                                                delay:(NSTimeInterval)delayAmount
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:property];
    
    CAMediaTimingFunction *timingFunction = [self timingFunctionForAnimationOptions:self.animationCurve];
    
    NSTimeInterval totalDuration;
    switch (self.marqueeType) {
        case MLLeftRight:
        case MLRightLeft:
            NSAssert(values.count == 5, @"Incorrect number of values passed for MLLeftRight-type animation");
            totalDuration = 2.0 * (delayAmount + interval);
            
            animation.keyTimes = @[@(0.0),
                                   @(delayAmount/totalDuration),
                                   @((delayAmount + interval)/totalDuration),
                                   @((delayAmount + interval + delayAmount)/totalDuration),
                                   @(1.0)];
            
            animation.timingFunctions = @[timingFunction,
                                          timingFunction,
                                          timingFunction,
                                          timingFunction];
            
            break;
            
        case MLLeft:
        case MLRight:
            NSAssert(values.count == 4, @"Incorrect number of values passed for MLLeft-type animation");
            totalDuration = CGFLOAT_MAX;
            
            animation.keyTimes = @[@(0.0),
                                   @(delayAmount/totalDuration),
                                   @((delayAmount + interval)/totalDuration),
                                   @(1.0)];
            
            animation.timingFunctions = @[timingFunction,
                                          timingFunction,
                                          timingFunction];
            
            break;
            
        default:
            NSAssert(values.count == 3, @"Incorrect number of values passed for MLContinous-type animation");
            totalDuration = delayAmount + interval;
            
            animation.keyTimes = @[@(0.0),
                                   @(delayAmount/totalDuration),
                                   @(1.0)];
            
            animation.timingFunctions = @[timingFunction,
                                          timingFunction];
            
            break;
    }
    
    animation.values = values;
    animation.delegate = self;
    
    return animation;
}

- (CAMediaTimingFunction *)timingFunctionForAnimationOptions:(UIViewAnimationOptions)animationOptions {
    NSString *timingFunction;
    switch (animationOptions) {
        case UIViewAnimationOptionCurveEaseIn:
            timingFunction = kCAMediaTimingFunctionEaseIn;
            break;
            
        case UIViewAnimationOptionCurveEaseInOut:
            timingFunction = kCAMediaTimingFunctionEaseInEaseOut;
            break;
            
        case UIViewAnimationOptionCurveEaseOut:
            timingFunction = kCAMediaTimingFunctionEaseOut;
            break;
            
        default:
            timingFunction = kCAMediaTimingFunctionLinear;
            break;
    }
    
    return [CAMediaTimingFunction functionWithName:timingFunction];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if ([anim isMemberOfClass:[GradientSetupAnimation class]]) {
        GradientSetupAnimation *setupFade = (GradientSetupAnimation *)anim;
        NSArray *finalColors = setupFade.toValue;
        if (finalColors) {
            [(CAGradientLayer *)self.layer.mask setColors:finalColors];
        }
        [self.layer.mask removeAnimationForKey:@"setupFade"];
    } else {
        if (self.scrollCompletionBlock) {
            self.scrollCompletionBlock(flag);
        }
    }
}

#pragma mark - Label Control

- (void)restartLabel {
    [self shutdownLabel];
    if (self.labelShouldScroll && !self.tapToScroll && !self.holdScrolling) {
        [self beginScroll];
    }
}

- (void)resetLabel {
    [self returnLabelToOriginImmediately];
    self.homeLabelFrame = CGRectNull;
    self.awayOffset = 0.0f;
}

- (void)shutdownLabel {
    [self returnLabelToOriginImmediately];
    [self applyGradientMaskForFadeLength:self.fadeLength animated:false];
}

- (void)pauseLabel
{
    if (!self.isPaused && self.awayFromHome) {
        CFTimeInterval labelPauseTime = [self.subLabel.layer convertTime:CACurrentMediaTime() fromLayer:nil];
        self.subLabel.layer.speed = 0.0;
        self.subLabel.layer.timeOffset = labelPauseTime;
        CFTimeInterval gradientPauseTime = [self.layer.mask convertTime:CACurrentMediaTime() fromLayer:nil];
        self.layer.mask.speed = 0.0;
        self.layer.mask.timeOffset = gradientPauseTime;
        
        self.isPaused = YES;
    }
}

- (void)unpauseLabel
{
    if (self.isPaused) {
        CFTimeInterval labelPausedTime = self.subLabel.layer.timeOffset;
        self.subLabel.layer.speed = 1.0;
        self.subLabel.layer.timeOffset = 0.0;
        self.subLabel.layer.beginTime = 0.0;
        self.subLabel.layer.beginTime = [self.subLabel.layer convertTime:CACurrentMediaTime() fromLayer:nil] - labelPausedTime;
        CFTimeInterval gradientPauseTime = self.layer.mask.timeOffset;
        self.layer.mask.speed = 1.0;
        self.layer.mask.timeOffset = 0.0;
        self.layer.mask.beginTime = 0.0;
        self.layer.mask.beginTime = [self.layer.mask convertTime:CACurrentMediaTime() fromLayer:nil] - gradientPauseTime;
        
        self.isPaused = NO;
    }
}

- (void)labelWasTapped:(UITapGestureRecognizer *)recognizer {
    if (self.labelShouldScroll && !self.awayFromHome) {
        [self beginScrollWithDelay:NO];
    }
}

- (void)triggerScrollStart {
    if (self.labelShouldScroll && !self.awayFromHome) {
        [self beginScroll];
    }
}

- (void)labelWillBeginScroll {
    return;
}

- (void)labelReturnedToHome:(BOOL)finished {
    return;
}

#pragma mark - Modified UIView Methods/Getters/Setters

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (SYSTEM_VERSION_IS_8_0_X) {
        [self updateSublabel];
    }
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (SYSTEM_VERSION_IS_8_0_X) {
        [self updateSublabel];
    }
    
}

#pragma mark - Modified UILabel Methods/Getters/Setters

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 100000 && !(TARGET_OS_TV)
- (UIView *)viewForBaselineLayout {
    return self.subLabel;
}
#endif

- (UIView *)viewForLastBaselineLayout {
    return self.subLabel;
}

- (UIView *)viewForFirstBaselineLayout {
    return self.subLabel;
}

- (NSString *)text {
    return self.subLabel.text;
}

- (void)setText:(NSString *)text {
    if ([text isEqualToString:self.subLabel.text]) {
        return;
    }
    self.subLabel.text = text;
    super.text = text;
    [self updateSublabel];
}

- (NSAttributedString *)attributedText {
    return self.subLabel.attributedText;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if ([attributedText isEqualToAttributedString:self.subLabel.attributedText]) {
        return;
    }
    self.subLabel.attributedText = attributedText;
    super.attributedText = attributedText;
    [self updateSublabel];
}

- (UIFont *)font {
    return self.subLabel.font;
}

- (void)setFont:(UIFont *)font {
    if ([font isEqual:self.subLabel.font]) {
        return;
    }
    self.subLabel.font = font;
    super.font = font;
    [self updateSublabel];
}

- (UIColor *)textColor {
    return self.subLabel.textColor;
}

- (void)setTextColor:(UIColor *)textColor {
    self.subLabel.textColor = textColor;
    super.textColor = textColor;
}

- (UIColor *)backgroundColor {
    return self.subLabel.backgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    self.subLabel.backgroundColor = backgroundColor;
    super.backgroundColor = backgroundColor;
}

- (UIColor *)shadowColor {
    return self.subLabel.shadowColor;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.subLabel.shadowColor = shadowColor;
    super.shadowColor = shadowColor;
}

- (CGSize)shadowOffset {
    return self.subLabel.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.subLabel.shadowOffset = shadowOffset;
    super.shadowOffset = shadowOffset;
}

- (UIColor *)highlightedTextColor {
    return self.subLabel.highlightedTextColor;
}

- (void)setHighlightedTextColor:(UIColor *)highlightedTextColor {
    self.subLabel.highlightedTextColor = highlightedTextColor;
    super.highlightedTextColor = highlightedTextColor;
}

- (BOOL)isHighlighted {
    return self.subLabel.isHighlighted;
}

- (void)setHighlighted:(BOOL)highlighted {
    self.subLabel.highlighted = highlighted;
    super.highlighted = highlighted;
}

- (BOOL)isEnabled {
    return self.subLabel.isEnabled;
}

- (void)setEnabled:(BOOL)enabled {
    self.subLabel.enabled = enabled;
    super.enabled = enabled;
}

- (void)setNumberOfLines:(NSInteger)numberOfLines {
    [super setNumberOfLines:1];
}

- (void)setAdjustsFontSizeToFitWidth:(BOOL)adjustsFontSizeToFitWidth {
    [super setAdjustsFontSizeToFitWidth:NO];
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
- (void)setMinimumFontSize:(CGFloat)minimumFontSize {
    [super setMinimumFontSize:0.0];
}
#endif

- (UIBaselineAdjustment)baselineAdjustment {
    return self.subLabel.baselineAdjustment;
}

- (void)setBaselineAdjustment:(UIBaselineAdjustment)baselineAdjustment {
    self.subLabel.baselineAdjustment = baselineAdjustment;
    super.baselineAdjustment = baselineAdjustment;
}

- (UIColor *)tintColor {
    return self.subLabel.tintColor;
}

- (void)setTintColor:(UIColor *)tintColor {
    self.subLabel.tintColor = tintColor;
    super.tintColor = tintColor;
}

- (void)tintColorDidChange {
    [super tintColorDidChange];
    [self.subLabel tintColorDidChange];
}

- (CGSize)intrinsicContentSize {
    CGSize contentSize = self.subLabel.intrinsicContentSize;
    contentSize.width += self.leadingBuffer;
    return contentSize;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < 70000
- (void)setAdjustsLetterSpacingToFitWidth:(BOOL)adjustsLetterSpacingToFitWidth {
    [super setAdjustsLetterSpacingToFitWidth:NO];
}
#endif

- (void)setMinimumScaleFactor:(CGFloat)minimumScaleFactor {
    [super setMinimumScaleFactor:0.0f];
}

- (UIViewContentMode)contentMode {
    return self.subLabel.contentMode;
}

- (void)setContentMode:(UIViewContentMode)contentMode {
    super.contentMode = contentMode;
    self.subLabel.contentMode = contentMode;
}

- (void)setIsAccessibilityElement:(BOOL)isAccessibilityElement {
    [super setIsAccessibilityElement:isAccessibilityElement];
    self.subLabel.isAccessibilityElement = isAccessibilityElement;
}

#pragma mark - Custom Getters and Setters

- (void)setRate:(CGFloat)rate {
    if (_rate == rate) {
        return;
    }
    
    _scrollDuration = 0.0f;
    _rate = rate;
    [self updateSublabel];
}

- (void)setScrollDuration:(CGFloat)lengthOfScroll {
    if (_scrollDuration == lengthOfScroll) {
        return;
    }
    
    _rate = 0.0f;
    _scrollDuration = lengthOfScroll;
    [self updateSublabel];
}

- (void)setAnimationCurve:(UIViewAnimationOptions)animationCurve {
    if (_animationCurve == animationCurve) {
        return;
    }
    
    NSUInteger allowableOptions = UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionCurveLinear;
    if ((allowableOptions & animationCurve) == animationCurve) {
        _animationCurve = animationCurve;
    }
}

- (void)setLeadingBuffer:(CGFloat)leadingBuffer {
    if (_leadingBuffer == leadingBuffer) {
        return;
    }
    
    _leadingBuffer = fabs(leadingBuffer);
    [self updateSublabel];
}

- (void)setTrailingBuffer:(CGFloat)trailingBuffer {
    if (_trailingBuffer == trailingBuffer) {
        return;
    }
    
    _trailingBuffer = fabs(trailingBuffer);
    [self updateSublabel];
}

- (void)setContinuousMarqueeExtraBuffer:(CGFloat)continuousMarqueeExtraBuffer {
    [self setTrailingBuffer:continuousMarqueeExtraBuffer];
}

- (CGFloat)continuousMarqueeExtraBuffer {
    return self.trailingBuffer;
}

- (void)setFadeLength:(CGFloat)fadeLength {
    if (_fadeLength == fadeLength) {
        return;
    }
    
    _fadeLength = fadeLength;
    
    [self updateSublabel];
}

- (void)setTapToScroll:(BOOL)tapToScroll {
    if (_tapToScroll == tapToScroll) {
        return;
    }
    
    _tapToScroll = tapToScroll;
    
    if (_tapToScroll) {
        UITapGestureRecognizer *newTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelWasTapped:)];
        [self addGestureRecognizer:newTapRecognizer];
        self.tapRecognizer = newTapRecognizer;
        self.userInteractionEnabled = YES;
    } else {
        [self removeGestureRecognizer:self.tapRecognizer];
        self.tapRecognizer = nil;
        self.userInteractionEnabled = NO;
    }
}

- (void)setMarqueeType:(MarqueeType)marqueeType {
    if (marqueeType == _marqueeType) {
        return;
    }
    
    _marqueeType = marqueeType;
    
    [self updateSublabel];
}

- (void)setLabelize:(BOOL)labelize {
    if (_labelize == labelize) {
        return;
    }
    
    _labelize = labelize;
    
    [self updateSublabelAndBeginScroll:YES];
}

- (void)setHoldScrolling:(BOOL)holdScrolling {
    if (_holdScrolling == holdScrolling) {
        return;
    }
    
    _holdScrolling = holdScrolling;
    
    if (!holdScrolling && !(self.awayFromHome || self.labelize || self.tapToScroll) && self.labelShouldScroll) {
        [self beginScroll];
    }
}

- (BOOL)awayFromHome {
    CALayer *presentationLayer = self.subLabel.layer.presentationLayer;
    if (!presentationLayer) {
        return NO;
    }
    return !(presentationLayer.position.x == self.homeLabelFrame.origin.x);
}

#pragma mark - Support

- (NSArray *)gradientColors {
    if (!_gradientColors) {
        NSObject *transparent = (NSObject *)[[UIColor clearColor] CGColor];
        NSObject *opaque = (NSObject *)[[UIColor blackColor] CGColor];
        _gradientColors = [NSArray arrayWithObjects: transparent, opaque, opaque, transparent, nil];
    }
    return _gradientColors;
}

#pragma mark -

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end



#pragma mark - Helpers

CGPoint MLOffsetCGPoint(CGPoint point, CGFloat offset) {
    return CGPointMake(point.x + offset, point.y);
}

@implementation GradientSetupAnimation

@end

@implementation UIView (AnimateLabelHelpers)

- (id)firstAvailableViewController
{
    return [self traverseResponderChainForFirstViewController];
}

- (id)traverseResponderChainForFirstViewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    } else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder traverseResponderChainForFirstViewController];
    } else {
        return nil;
    }
}

@end

@implementation CAMediaTimingFunction (AnimateLabelHelpers)

- (CGFloat)durationPercentageForPositionPercentage:(CGFloat)positionPercentage withDuration:(NSTimeInterval)duration
{
    NSArray *controlPoints = [self controlPoints];
    CGFloat epsilon = 1.0f / (100.0f * duration);
    
    CGFloat t_found = [self solveTForY:positionPercentage
                           withEpsilon:epsilon
                         controlPoints:controlPoints];
    
    CGFloat durationPercentage = [self XforCurveAt:t_found withControlPoints:controlPoints];
    
    return durationPercentage;
}

- (CGFloat)solveTForY:(CGFloat)y_0 withEpsilon:(CGFloat)epsilon controlPoints:(NSArray *)controlPoints
{
    CGFloat t0 = y_0;
    CGFloat t1 = y_0;
    CGFloat f0, df0;
    
    for (int i = 0; i < 15; i++) {
        t0 = t1;
        f0 = [self YforCurveAt:t0 withControlPoints:controlPoints] - y_0;
        if (fabs(f0) < epsilon) {
            return t0;
        }
        df0 = [self derivativeYValueForCurveAt:t0 withControlPoints:controlPoints];
        if (fabs(df0) < 1e-6) {
            break;
        }
        t1 = t0 - f0/df0;
    }
    
    return t0;
}

- (CGFloat)YforCurveAt:(CGFloat)t withControlPoints:(NSArray *)controlPoints
{
    CGPoint P0 = [controlPoints[0] CGPointValue];
    CGPoint P1 = [controlPoints[1] CGPointValue];
    CGPoint P2 = [controlPoints[2] CGPointValue];
    CGPoint P3 = [controlPoints[3] CGPointValue];
    
    return  powf((1 - t),3) * P0.y +
    3.0f * powf(1 - t, 2) * t * P1.y +
    3.0f * (1 - t) * powf(t, 2) * P2.y +
    powf(t, 3) * P3.y;
    
}

- (CGFloat)XforCurveAt:(CGFloat)t withControlPoints:(NSArray *)controlPoints
{
    CGPoint P0 = [controlPoints[0] CGPointValue];
    CGPoint P1 = [controlPoints[1] CGPointValue];
    CGPoint P2 = [controlPoints[2] CGPointValue];
    CGPoint P3 = [controlPoints[3] CGPointValue];
    
    return  powf((1 - t),3) * P0.x +
    3.0f * powf(1 - t, 2) * t * P1.x +
    3.0f * (1 - t) * powf(t, 2) * P2.x +
    powf(t, 3) * P3.x;
    
}

- (CGFloat)derivativeYValueForCurveAt:(CGFloat)t withControlPoints:(NSArray *)controlPoints
{
    CGPoint P0 = [controlPoints[0] CGPointValue];
    CGPoint P1 = [controlPoints[1] CGPointValue];
    CGPoint P2 = [controlPoints[2] CGPointValue];
    CGPoint P3 = [controlPoints[3] CGPointValue];
    
    return  powf(t, 2) * (-3.0f * P0.y - 9.0f * P1.y - 9.0f * P2.y + 3.0f * P3.y) +
    t * (6.0f * P0.y + 6.0f * P2.y) +
    (-3.0f * P0.y + 3.0f * P1.y);
}

- (NSArray *)controlPoints
{
    float point[2];
    NSMutableArray *pointArray = [NSMutableArray array];
    for (int i = 0; i <= 3; i++) {
        [self getControlPointAtIndex:i values:point];
        [pointArray addObject:[NSValue valueWithCGPoint:CGPointMake(point[0], point[1])]];
    }
    
    return [NSArray arrayWithArray:pointArray];
}

@end
