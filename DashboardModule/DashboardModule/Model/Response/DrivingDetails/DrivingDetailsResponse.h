//
//  DrivingDetailsResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 14.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "DrivingDetailsObject.h"

@interface DrivingDetailsResponse: ResponseObject

@property (nonatomic, strong) NSMutableArray<DrivingDetailsObject, Optional> *Result;

@end
