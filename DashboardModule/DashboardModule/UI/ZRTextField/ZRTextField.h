//
//  ZRTextField.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 26.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;

@interface ZRTextField : UITextField

@property (nonatomic, strong) UIImage *leftIconNormal;
@property (nonatomic, strong) UIImage *leftIconHighlight;

@property (nonatomic, copy) NSString *leftTitleNormal;
@property (nonatomic, copy) NSString *leftTitleHighlight;

@property (nonatomic, strong) UIColor *colorNormal;
@property (nonatomic, strong) UIColor *colorHighlight;

@property (nonatomic, assign) BOOL showHighlightedEditing;

@property (nonatomic, assign) BOOL showBottomLine;

@property (nonatomic, assign) BOOL showBoundLine;

@property (nonatomic, assign) CGFloat separateLineWith;

@property (nonatomic, copy) BOOL (^shouldChangeBlock)(UITextField *textField, NSRange range, NSString *string);

@end
