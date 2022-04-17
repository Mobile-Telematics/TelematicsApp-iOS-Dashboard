//
//  SCPopup.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 24.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "SCPopup.h"
#import "Color.h"
#import "Font.h"

#define cellHt  50
#define tblheaderHt 80

@interface SCPopup ()
{
    NSArray *ordersArray;
    UIButton *parentBtn;
}
@end

@implementation SCPopup

- (id)initWithFrame:(CGRect)frame delegate:(id<SCPopupDelegate>)delegate
{
    self = [super init];
    if ((self = [super initWithFrame:frame]))
    {
        self.SCPopupDelegate = delegate;
    }
    
    return self;
}


- (void)createTableView:(NSArray *)contentArray withSender:(id)sender withTitle:(NSString *)title setCompletionBlock:(SCActionBlock )aCompletionBlock{
    
    self.alpha = 0;
    self.backgroundColor = [UIColor colorWithWhite:0.00 alpha:0.5];
    self->completionBlock = aCompletionBlock;
    parentBtn = (UIButton *)sender;
    
    titleText = title;
    
    ordersArray = [[NSArray alloc] initWithArray:contentArray];
    
    long cellHeight = (self.frame.size.height -40) - (cellHt * ordersArray.count);
    
    if (cellHeight>0) {
        cellHeight = (cellHt * ordersArray.count) + tblheaderHt;
    } else {
        cellHeight = (self.frame.size.height -40);
    }
    
    dropdownTable = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-(self.frame.size.width/1.2)/2,self.frame.size.height/2-(cellHeight)/2,self.frame.size.width/1.2,cellHeight)];
    dropdownTable.backgroundColor = [Color officialWhiteColor];
    dropdownTable.dataSource = self;
    dropdownTable.showsVerticalScrollIndicator = NO;
    dropdownTable.delegate = self;
    dropdownTable.layer.cornerRadius = 5.0f;
    dropdownTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:dropdownTable];
    
    [self addTarget:self action:@selector(closeAnimation) forControlEvents:UIControlEventTouchUpInside];
    
    transitionAnimation(self.superview, 0.30f, UIViewAnimationOptionTransitionNone, self.alpha=1;
                        )completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return tblheaderHt;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tblheaderHt)];
    [headView setBackgroundColor:[Color officialMainAppColor]];
    
    UILabel *headLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, headView.frame.size.width, tblheaderHt)];
    headLbl.backgroundColor = [UIColor clearColor];
    headLbl.textColor = [Color officialWhiteColor];
    headLbl.text = titleText ? titleText : @"Select number for invitation";
    headLbl.textAlignment = NSTextAlignmentCenter;
    headLbl.numberOfLines = 2;
    headLbl.font = [Font medium17];
    [headView addSubview:headLbl];
    
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return cellHt;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ordersArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    cell.backgroundColor = [Color officialWhiteColor];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    for (UILabel *lbl in cell.contentView.subviews)
    {
        if ([lbl isKindOfClass:[UILabel class]])
        {
            [lbl removeFromSuperview];
        }
    }
    
    UILabel *contentlbl = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, tableView.frame.size.width-20, cellHt-2)];
    contentlbl.backgroundColor = [UIColor clearColor];
    contentlbl.text = [ordersArray objectAtIndex:indexPath.row];
    contentlbl.textColor = [UIColor blackColor];
    contentlbl.textAlignment = NSTextAlignmentLeft;
    contentlbl.font = [Font regular16];
    [cell.contentView addSubview:contentlbl];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, contentlbl.frame.origin.y+contentlbl.frame.size.height-2, self.frame.size.width, 1.2)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [contentlbl addSubview:lineView];
    
    if (indexPath.row == [ordersArray count] -1){
        lineView.hidden=YES;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (completionBlock) {
        completionBlock((int)indexPath.row);
    }
    
    [self closeAnimation];
}

- (void)closeAnimation {
    
    transitionAnimation(self.superview, 0.20f, UIViewAnimationOptionTransitionNone,
                        self->dropdownTable.alpha=0;
                        )completion:^(BOOL finished){
        [self->dropdownTable removeFromSuperview];
        [self removeFromSuperview];
    }];
}

@end
