//
//  EcoResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 03.11.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "EcoResultResponse.h"

@interface EcoResponse: LARootResponse

@property (nonatomic, strong) EcoResultResponse<Optional>* Result;

@end
