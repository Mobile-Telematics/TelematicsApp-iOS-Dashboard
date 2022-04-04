//
//  DrivingDetailsResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 14.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "DrivingDetailsObject.h"

@interface DrivingDetailsResponse: LAResponseObject

@property (nonatomic, strong) NSMutableArray<DrivingDetailsObject, Optional> *Result;

@end
