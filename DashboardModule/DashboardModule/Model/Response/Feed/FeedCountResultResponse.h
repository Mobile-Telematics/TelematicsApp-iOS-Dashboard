//
//  FeedResultResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 01.04.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@interface FeedCountResultResponse: ResponseObject

@property (nonatomic, strong) NSNumber<Optional>* eventsCount;

@end
