//
//  ZRCollapsibleConstraints.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 06.06.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;


@interface UIView (ZRCollapsibleConstraints)

@property (nonatomic, assign) BOOL fd_collapsed;
@property (nonatomic, copy) IBOutletCollection(NSLayoutConstraint) NSArray *fd_collapsibleConstraints;

@end


@interface UIView (FDAutomaticallyCollapseByIntrinsicContentSize)

@property (nonatomic, assign) BOOL fd_autoCollapse;
@property (nonatomic, assign, getter=fd_autoCollapse) IBInspectable BOOL autoCollapse;

@end
