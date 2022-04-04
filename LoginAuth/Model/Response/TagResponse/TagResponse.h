//
//  TagResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.03.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "TagResultResponse.h"

@interface TagResponse: LARootResponse

@property (nonatomic, strong) TagResultResponse<Optional>* Result;

@end
