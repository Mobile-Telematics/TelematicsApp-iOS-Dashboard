//
//  LatestDayScoringResultResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 06.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"

@interface LatestDayScoringResultResponse : LAResponseObject

@property (nonatomic, strong) NSString<Optional>* LatestTripDate;
@property (nonatomic, strong) NSString<Optional>* LatestScoringDate;

@end
