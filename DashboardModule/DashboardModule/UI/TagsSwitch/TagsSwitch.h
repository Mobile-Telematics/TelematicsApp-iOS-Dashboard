//
//  TagsSwitch.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 01.04.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagsSwitch : UIControl

@property (strong, nonatomic) UIColor       *backgroundColor;
@property (strong, nonatomic) UIColor       *sliderColor;
@property (strong, nonatomic) UIColor       *labelTextColorInsideSlider;
@property (strong, nonatomic) UIColor       *labelTextColorOutsideSlider;
@property (strong, nonatomic) UIFont        *font;
@property (nonatomic) CGFloat               cornerRadius;
@property (nonatomic) CGFloat               sliderOffset;

+ (instancetype)switchWithStringsArray:(NSArray *)strings;
- (instancetype)initWithStringsArray:(NSArray *)strings;
- (instancetype)initWithAttributedStringsArray:(NSArray *)strings;

- (void)forceSelectedIndex:(NSInteger)index animated:(BOOL)animated;
- (void)setPressedHandler:(void (^)(NSUInteger index))handler;
- (void)setWillBePressedHandler:(void (^)(NSUInteger index))handler;
- (void)selectIndex:(NSInteger)index animated:(BOOL)animated;

@end
