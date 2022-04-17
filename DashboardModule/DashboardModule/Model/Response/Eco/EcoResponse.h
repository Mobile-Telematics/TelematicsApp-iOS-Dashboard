//
//  EcoResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 03.11.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "EcoResultResponse.h"

@interface EcoResponse: RootResponse

@property (nonatomic, strong) EcoResultResponse<Optional>* Result;

@end
