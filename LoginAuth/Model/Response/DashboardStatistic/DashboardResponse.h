//
//  DashboardResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 28.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "DashboardResultResponse.h"

@interface DashboardResponse: LARootResponse

@property (nonatomic, strong) DashboardResultResponse<Optional>* Result;

@end
