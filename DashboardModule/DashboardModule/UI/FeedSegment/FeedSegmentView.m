//
//  FeedSegmentView.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 17.09.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "FeedSegmentView.h"
#import <QuartzCore/QuartzCore.h>

#define ZR_SEG_BTN_TAG 100
#define ZR_SEG_LINE_TAG 110

@interface FeedSegmentView()
{
    UIScrollView *_scrollView;
    UIColor *_selectColor;
    UIColor *_normalColor;
    UILabel *_line;
    NSInteger _selectIndex;
    UIButton *_originSelectedBtn;
}
@end


@implementation FeedSegmentView

- (instancetype)initWithItems:(NSArray *)items andNormalFontColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor andLineColor:(UIColor *)lineColor andFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];

        _selectColor = selectedColor == nil ? [UIColor redColor]:selectedColor;
        _normalColor = normalColor == nil ? UIColorFromHex(0x333333):normalColor;
        _selectIndex = 0;
        
        CGFloat width = frame.size.width / items.count;
        if (items.count >3) {
            _scrollView.contentSize = CGSizeMake(width*items.count, _scrollView.bounds.size.height);
        }
        
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        bottomLine.backgroundColor = UIColorFromHex(0x939d9e);
        [_scrollView addSubview:bottomLine];
        
        _line = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 3, width, 3)];
        _line.backgroundColor = lineColor == nil ? [UIColor redColor] : lineColor;
        [_scrollView addSubview:_line];
        
        for (int i = 0 ; i < items.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            if (IS_IPHONE_5 || IS_IPHONE_4) {
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
            } else if (IS_IPHONE_8 || IS_IPHONE_XS || IS_IPHONE_13_PRO) {
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
            } else {
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            }
            btn.tag = ZR_SEG_BTN_TAG + i;
            btn.frame = CGRectMake(i *width, 1, width, frame.size.height - 2);
            
            if (i == _selectIndex) {
                [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:items[i] attributes:@{NSForegroundColorAttributeName:_selectColor}] forState:UIControlStateNormal];
                CGRect lineFrame=_line.frame;
                lineFrame.origin.x = btn.center.x-(_line.width/2);
                _line.frame = lineFrame;
                _originSelectedBtn = btn;
            } else {
                [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:items[i] attributes:@{NSForegroundColorAttributeName:_normalColor}] forState:UIControlStateNormal];
            }
            
            [btn addTarget:self action:@selector(chooseIndex:) forControlEvents:UIControlEventTouchUpInside];
            [_scrollView addSubview:btn];
            
//            if (i > 0 && i<items.count) {
//                UILabel *middleLine  = [[UILabel alloc] initWithFrame:CGRectMake(width * i - 0.25, 8, 0.5, _scrollView.height - 8*2)];
//                middleLine.backgroundColor = UIColorFromHex(0xe6e6e6);
//                [_scrollView addSubview:middleLine];
//            }
        }
    }
    return self;
}


- (instancetype)initWithItemsAndImages:(NSArray *)items andNormalFontColor:(UIColor *)normalColor andSelectedColor:(UIColor *)selectedColor andLineColor:(UIColor *)lineColor andFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        _selectColor = selectedColor == nil ? [UIColor redColor]:selectedColor;
        _normalColor = normalColor == nil ? UIColorFromHex(0x333333):normalColor;
        _selectIndex = 0;
        
        CGFloat width = frame.size.width / items.count;
        if (items.count >3) {
            _scrollView.contentSize = CGSizeMake(width*items.count, _scrollView.bounds.size.height);
        }
        
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
        bottomLine.backgroundColor = UIColorFromHex(0x939d9e);
        [_scrollView addSubview:bottomLine];
        
        _line = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 3, width, 3)];
        _line.backgroundColor = lineColor == nil ? [UIColor redColor] : lineColor;
        [_scrollView addSubview:_line];
        
        for (int i = 0 ; i < items.count; i++) {
            
            if (i == 0) {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
                if (IS_IPHONE_5 || IS_IPHONE_4) {
                    btn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
                } else {
                    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
                }
                
                btn.tag = ZR_SEG_BTN_TAG + i;
                btn.frame = CGRectMake(i *width, 1, width, frame.size.height - 2);
                
                if (i == _selectIndex) {
                    [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:items[i] attributes:@{NSForegroundColorAttributeName:_selectColor}] forState:UIControlStateNormal];
                    CGRect lineFrame=_line.frame;
                    lineFrame.origin.x = btn.center.x-(_line.width/2);
                    _line.frame = lineFrame;
                    _originSelectedBtn = btn;
                    
                } else {
                    [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:items[i] attributes:@{NSForegroundColorAttributeName:_normalColor}] forState:UIControlStateNormal];
                }
                
                [btn addTarget:self action:@selector(chooseIndexWithImages:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:btn];
                
            } else {
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
                if (IS_IPHONE_5 || IS_IPHONE_4) {
                    btn.titleLabel.font = [UIFont boldSystemFontOfSize:11];
                } else if (IS_IPHONE_XS) {
                    btn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
                } else {
                    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
                }
                
                btn.tag = ZR_SEG_BTN_TAG + i;
                btn.frame = CGRectMake(i *width, 1, width, frame.size.height - 2);
                
                if (i == _selectIndex) {
                    [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:items[i] attributes:@{NSForegroundColorAttributeName:_selectColor}] forState:UIControlStateNormal];
                    CGRect lineFrame=_line.frame;
                    lineFrame.origin.x = btn.center.x-(_line.width/2);
                    _line.frame = lineFrame;
                    _originSelectedBtn = btn;
                    
                } else {
                    [[btn imageView] setContentMode: UIViewContentModeScaleAspectFit];
                    [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 0, 5, 0)];
                    [btn setImage:[UIImage imageNamed:items[i]] forState:UIControlStateNormal];
                    
//                    [btn imageView].image = [[btn imageView].image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//                    [[btn imageView] setTintColor:[Color officialWhiteColor]];
//                    [btn setImage:[UIImage imageNamed:items[i]] forState:UIControlStateNormal];
                }
                
                [btn addTarget:self action:@selector(chooseIndexWithImages:) forControlEvents:UIControlEventTouchUpInside];
                [_scrollView addSubview:btn];
            }
        }
    }
    return self;
}


#pragma mark - Feed Segment

- (void)chooseIndex:(UIButton *)btn
{
    NSInteger index = btn.tag - ZR_SEG_BTN_TAG;
    if (index == _selectIndex) {
        return;
    }
    
    [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:btn.titleLabel.text attributes:@{NSForegroundColorAttributeName:_selectColor}]  forState:UIControlStateNormal];
    [_originSelectedBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:_originSelectedBtn.titleLabel.text attributes:@{NSForegroundColorAttributeName:_normalColor}]  forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.1 animations:^{
        self->_scrollView.userInteractionEnabled = NO;
        self->_originSelectedBtn = btn;
        CGRect lineFrame = self->_line.frame;
        lineFrame.origin.x = btn.center.x-(self->_line.width/2);
        self->_line.frame = lineFrame;
        
    } completion:^(BOOL finished){
        self->_scrollView.userInteractionEnabled = YES;
        self->_selectIndex = index;
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentChose:)]) {
        [self.delegate segmentChose:index];
    }
}

- (void)chooseIndexWithImages:(UIButton *)btn
{
    NSInteger index = btn.tag - ZR_SEG_BTN_TAG;
    if (index == _selectIndex) {
        return;
    }
    
    if (index == 0 && _selectIndex != 1 && _selectIndex != 2 && _selectIndex != 3) {
        [btn setAttributedTitle:[[NSAttributedString alloc] initWithString:btn.titleLabel.text attributes:@{NSForegroundColorAttributeName:_selectColor}]  forState:UIControlStateNormal];
        [_originSelectedBtn setAttributedTitle:[[NSAttributedString alloc] initWithString:_originSelectedBtn.titleLabel.text attributes:@{NSForegroundColorAttributeName:_normalColor}]  forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        self->_scrollView.userInteractionEnabled = NO;
        self->_originSelectedBtn = btn;
        CGRect lineFrame = self->_line.frame;
        lineFrame.origin.x = btn.center.x-(self->_line.width/2);
        self->_line.frame = lineFrame;
        
    } completion:^(BOOL finished){
        self->_scrollView.userInteractionEnabled = YES;
        self->_selectIndex = index;
    }];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentChose:)]) {
        [self.delegate segmentChose:index];
    }
}

- (void)setSelectedIndex:(NSInteger)index
{
    UIButton *btn=(UIButton *)[self viewWithTag:ZR_SEG_BTN_TAG+index];
    
    if (index>=5) {
        NSInteger num=index/5;
        
        _scrollView.contentOffset=CGPointMake(num*_scrollView.bounds.size.width, 0);
    } else {
        _scrollView.contentOffset=CGPointMake(0, 0);
    }
    
    //[self chooseIndex:btn];
    [self chooseIndexWithImages:btn];
}

@end
