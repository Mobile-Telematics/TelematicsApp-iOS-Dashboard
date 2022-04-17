//
//  CirclePercentView.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 08.02.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "PercentLabel.h"

typedef enum {
    CirclePercentTypeLine = 0,
    CirclePercentTypePie
} CirclePercentType;

@interface CirclePercentView: UIView

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) CAMediaTimingFunction *timingFunction;
@property (nonatomic, strong) UILabel *percentLabel;

- (void)drawCircleWithPercent:(CGFloat)percent
                    duration:(CGFloat)duration
                   lineWidth:(CGFloat)lineWidth
                   clockwise:(BOOL)clockwise
                     lineCap:(NSString *)lineCap
                   fillColor:(UIColor *)fillColor
                 strokeColor:(UIColor *)strokeColor
              animatedColors:(NSArray *)colors;

- (void)drawPieChartWithPercent:(CGFloat)percent
                       duration:(CGFloat)duration
                      clockwise:(BOOL)clockwise
                      fillColor:(UIColor *)fillColor
                    strokeColor:(UIColor *)strokeColor
                 animatedColors:(NSArray *)colors;


- (void)startAnimation;

@end
