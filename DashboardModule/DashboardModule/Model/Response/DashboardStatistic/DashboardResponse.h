//
//  DashboardResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 28.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "DashboardResultResponse.h"

@interface DashboardResponse: RootResponse

@property (nonatomic, strong) DashboardResultResponse<Optional>* Result;

@end
