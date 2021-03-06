//
//  ProgressBarView.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 16.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ProgressBarView.h"

void strokeRectInContext(CGContextRef context, CGRect rect, CGFloat lineWidth, CGFloat radius);
void fillRectInContext(CGContextRef context, CGRect rect, CGFloat radius);
void setRectPathInContext(CGContextRef context, CGRect rect, CGFloat radius);

@implementation ProgressBarView


#pragma mark - Accessors

@synthesize progress = _progress;
@synthesize barBorderWidth = _barBorderWidth;
@synthesize barBorderColor = _barBorderColor;
@synthesize barInnerBorderWidth = _barInnerBorderWidth;
@synthesize barInnerBorderColor = _barInnerBorderColor;
@synthesize barInnerPadding = _barInnerPadding;
@synthesize barFillColor = _barFillColor;
@synthesize barBackgroundColor = _barBackgroundColor;
@synthesize usesRoundedCorners = _usesRoundedCorners;


- (void)setProgress:(CGFloat)newProgress {
    _progress = fmaxf(0.0, fminf(1.0, newProgress));
    [self setNeedsDisplay];
}

- (void)setBarBorderWidth:(CGFloat)barBorderWidth {
    _barBorderWidth = barBorderWidth;
    [self setNeedsDisplay];
}

- (void)setBarBorderColor:(UIColor *)barBorderColor {
    _barBorderColor = barBorderColor;
    [self setNeedsDisplay];
}

- (void)setBarInnerBorderWidth:(CGFloat)barInnerBorderWidth {
    _barInnerBorderWidth = barInnerBorderWidth;
    [self setNeedsDisplay];
}

- (void)setBarInnerBorderColor:(UIColor *)barInnerBorderColor {
    _barInnerBorderColor = barInnerBorderColor;
    [self setNeedsDisplay];
}

- (void)setBarInnerPadding:(CGFloat)barInnerPadding {
    _barInnerPadding = barInnerPadding;
    [self setNeedsDisplay];
}

- (void)setBarFillColor:(UIColor *)barFillColor {
    _barFillColor = barFillColor;
    [self setNeedsDisplay];
}

- (void)setBarBackgroundColor:(UIColor *)barBackgroundColor {
    _barBackgroundColor = barBackgroundColor;
    [self setNeedsDisplay];
}

- (void)setUsesRoundedCorners:(NSInteger)usesRoundedCorners {
    _usesRoundedCorners = usesRoundedCorners;
    [self setNeedsDisplay];
}


#pragma mark - Class Methods

+ (UIColor *)defaultBarColor {
    return [Color officialWhiteColor];
}

+ (void)initialize {
    if (self == [ProgressBarView class]) {
        ProgressBarView *appearance = [ProgressBarView appearance];
        [appearance setUsesRoundedCorners:YES];
        [appearance setProgress:0];
        [appearance setBarBorderWidth:0.0];
        [appearance setBarBorderColor:[self defaultBarColor]];
        [appearance setBarInnerBorderWidth:0];
        [appearance setBarInnerBorderColor:nil];
        [appearance setBarInnerPadding:0.0];
        [appearance setBarFillColor:[Color lightSeparatorColor]];
        [appearance setBarBackgroundColor:[Color officialWhiteColor]];
    }
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)aFrame {
    if ((self = [super initWithFrame:aFrame])) {
        [self initialize];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetAllowsAntialiasing(context, TRUE);
    
    CGRect currentRect = rect;
    CGFloat radius = 0;
    CGFloat halfLineWidth = 0;
    
    if (self.backgroundColor) {
        if (self.usesRoundedCorners) radius = currentRect.size.height / 2.0;
        
        [self.barBackgroundColor setFill];
        fillRectInContext(context, currentRect, radius);
    }
    
    if (self.barBorderColor && self.barBorderWidth > 0.0) {
        halfLineWidth = self.barBorderWidth / 2.0;
        currentRect = CGRectInset(currentRect, halfLineWidth, halfLineWidth);
        if (self.usesRoundedCorners) radius = currentRect.size.height / 2.0;
        
        [self.barBorderColor setStroke];
        strokeRectInContext(context, currentRect, self.barBorderWidth, radius);
        
        currentRect = CGRectInset(currentRect, halfLineWidth, halfLineWidth);
    }
    
    currentRect = CGRectInset(currentRect, self.barInnerPadding, self.barInnerPadding);
    
    BOOL hasInnerBorder = NO;
    if (self.barInnerBorderColor && self.barInnerBorderWidth > 0.0) {
        hasInnerBorder = YES;
        halfLineWidth = self.barInnerBorderWidth / 2.0;
        currentRect = CGRectInset(currentRect, halfLineWidth, halfLineWidth);
        if (self.usesRoundedCorners) radius = currentRect.size.height / 2.0;
        
        currentRect.size.width *= self.progress;
        currentRect.size.width = fmaxf(currentRect.size.width, 2 * radius);
        
        [self.barInnerBorderColor setStroke];
        strokeRectInContext(context, currentRect, self.barInnerBorderWidth, radius);
        
        currentRect = CGRectInset(currentRect, halfLineWidth, halfLineWidth);
    }
    
    if (self.barFillColor) {
        if (self.usesRoundedCorners) radius = currentRect.size.height / 2;
        
        if (!hasInnerBorder) {
            currentRect.size.width *= self.progress;
            currentRect.size.width = fmaxf(currentRect.size.width, 2 * radius);
        }
        
        [self.barFillColor setFill];
        fillRectInContext(context, currentRect, radius);
    }
    CGContextRestoreGState(context);
}


#pragma mark - Private

- (void)initialize {
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = [UIColor clearColor];
}

@end


#pragma mark - Drawing Functions

void strokeRectInContext(CGContextRef context, CGRect rect, CGFloat lineWidth, CGFloat radius) {
    CGContextSetLineWidth(context, lineWidth);
    setRectPathInContext(context, rect, radius);
    CGContextStrokePath(context);
}

void fillRectInContext(CGContextRef context, CGRect rect, CGFloat radius) {
    setRectPathInContext(context, rect, radius);
    CGContextFillPath(context);
}

void setRectPathInContext(CGContextRef context, CGRect rect, CGFloat radius) {
    CGContextBeginPath(context);
    if (radius > 0.0) {
        CGContextMoveToPoint(context, CGRectGetMinX(rect), CGRectGetMidY(rect));
        CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMidX(rect), CGRectGetMinY(rect), radius);
        CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMidY(rect), radius);
        CGContextAddArcToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMidX(rect), CGRectGetMaxY(rect), radius);
        CGContextAddArcToPoint(context, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMidY(rect), radius);
    } else {
        CGContextAddRect(context, rect);
    }
    CGContextClosePath(context);
}
