//
//  CoinsResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 28.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "CoinsResultResponse.h"

@interface CoinsResponse: LARootResponse

@property (nonatomic, strong) CoinsResultResponse<Optional>* Result;

@end
