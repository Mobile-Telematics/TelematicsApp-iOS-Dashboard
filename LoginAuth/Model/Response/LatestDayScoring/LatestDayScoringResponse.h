//
//  LatestDayScoringResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 06.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "LatestDayScoringResultResponse.h"

@interface LatestDayScoringResponse : LARootResponse

@property (nonatomic, strong) LatestDayScoringResultResponse<Optional>* Result;

@end
