//
//  UserActivityCell.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 19.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;

@interface UserActivityCell: UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *averageSpeed;
@property (weak, nonatomic) IBOutlet UILabel *maxSpeed;
@property (weak, nonatomic) IBOutlet UILabel *averageTrip;

@end
