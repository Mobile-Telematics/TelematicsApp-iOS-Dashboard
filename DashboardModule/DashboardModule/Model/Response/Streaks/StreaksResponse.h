//
//  StreaksResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "StreaksResultResponse.h"

@interface StreaksResponse: RootResponse

@property (nonatomic, strong) StreaksResultResponse<Optional>* Result;

@end
