//
//  IndicatorsResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 28.07.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "IndicatorsResultResponse.h"

@interface IndicatorsResponse: RootResponse

@property (nonatomic, strong) IndicatorsResultResponse<Optional>* Result;

@end
