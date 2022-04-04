//
//  StreaksResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "StreaksResultResponse.h"

@interface StreaksResponse: LARootResponse

@property (nonatomic, strong) StreaksResultResponse<Optional>* Result;

@end
