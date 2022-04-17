//
//  CoinsResultResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 28.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@interface CoinsResultResponse: ResponseObject

@property (nonatomic, strong) NSNumber<Optional>* DailyLimit;
@property (nonatomic, strong) NSString<Optional>* TotalEarnedCoins;
@property (nonatomic, strong) NSString<Optional>* AcquiredCoins;

@end
