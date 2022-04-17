//
//  FeedCountResponseResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 01.04.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "FeedCountResultResponse.h"

@interface FeedCountResponse: RootResponse

@property (nonatomic, strong) FeedCountResultResponse<Optional>* Result;
@end
