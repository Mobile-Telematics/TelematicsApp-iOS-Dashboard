//
//  FeedSegmentView.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 17.09.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "UIView+Extension.h"

@protocol FeedSegmentViewDelegate <NSObject>

- (void)segmentChose:(NSInteger)index;

@end

@interface FeedSegmentView : UIView

@property (nonatomic,weak) id<FeedSegmentViewDelegate> delegate;

- (instancetype)initWithItems:(NSArray *)items andNormalFontColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor andLineColor:(UIColor *)lineColor andFrame:(CGRect)frame;
- (instancetype)initWithItemsAndImages:(NSArray *)items andNormalFontColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor andLineColor:(UIColor *)lineColor andFrame:(CGRect)frame;
- (void)setSelectedIndex:(NSInteger)index;

@end
