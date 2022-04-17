//
//  CoinsDetailsResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 24.03.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "CoinsDetailsObject.h"

@interface CoinsDetailsResponse: ResponseObject

@property (nonatomic, strong) NSMutableArray<CoinsDetailsObject, Optional> *Result;

@end
