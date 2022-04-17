//
//  SCPopup.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 24.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

#define transitionAnimation(_inView,_duration,_option,_frames)            [UIView transitionWithView:_inView duration:_duration options:_option animations:^{ _frames    }

@class SCPopup;

typedef void (^SCActionBlock)(int);
@protocol SCPopupDelegate <NSObject>
@end

@interface SCPopup: UIControl <UITableViewDataSource,UITableViewDelegate>
{
    SCActionBlock completionBlock;
    UITableView *dropdownTable;
    NSString *titleText;
}

@property (nonatomic, assign) id <SCPopupDelegate> SCPopupDelegate;

- (void)createTableView:(NSArray *)contentArray withSender:(id)sender withTitle:(NSString *)title setCompletionBlock:(SCActionBlock )aCompletionBlock;

@end
