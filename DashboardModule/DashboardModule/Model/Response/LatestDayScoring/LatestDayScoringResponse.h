//
//  LatestDayScoringResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 06.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "LatestDayScoringResultResponse.h"

@interface LatestDayScoringResponse : RootResponse

@property (nonatomic, strong) LatestDayScoringResultResponse<Optional>* Result;

@end
