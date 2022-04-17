//
//  LatestDayScoringResultResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 06.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@interface LatestDayScoringResultResponse : ResponseObject

@property (nonatomic, strong) NSString<Optional>* LatestTripDate;
@property (nonatomic, strong) NSString<Optional>* LatestScoringDate;

@end
