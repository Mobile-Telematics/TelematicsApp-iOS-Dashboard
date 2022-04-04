//
//  IndicatorsResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 28.07.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "IndicatorsResultResponse.h"

@interface IndicatorsResponse: LARootResponse

@property (nonatomic, strong) IndicatorsResultResponse<Optional>* Result;

@end
