//
//  DashLiteCell.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 23.05.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "DashLiteGaugeView.h"
#import "UICountingLabel.h"

@interface DashLiteCell: UICollectionViewCell <DashLiteGaugeViewDelegate>

@property (strong, nonatomic) IBOutlet DashLiteGaugeView *gaugeView;

@property (weak, nonatomic) IBOutlet UICountingLabel *curveCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *curveCountPlaceholder;
@property (weak, nonatomic) IBOutlet UIImageView *faceImg;
@property (weak, nonatomic) IBOutlet UILabel *curveNameLbl;

@property (weak, nonatomic) IBOutlet UIImageView *trendArrowImg;

- (void)loadGauge:(NSNumber*)value curveName:(NSString*)curveName;
- (void)loadDemoGauge:(NSNumber*)value curveName:(NSString*)curveName;

@end
