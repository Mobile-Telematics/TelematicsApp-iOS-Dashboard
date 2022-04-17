//
//  DrivingDetailsObject.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 14.08.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@protocol DrivingDetailsObject;

@interface DrivingDetailsObject: ResponseObject

@property (nonatomic, strong) NSNumber<Optional>* SafetyScore;

@property (nonatomic, strong) NSNumber<Optional>* AccelerationScore;
@property (nonatomic, strong) NSNumber<Optional>* BrakingScore;
@property (nonatomic, strong) NSNumber<Optional>* SpeedingScore;
@property (nonatomic, strong) NSNumber<Optional>* PhoneUsageScore;
@property (nonatomic, strong) NSNumber<Optional>* CorneringScore;

@property (nonatomic, strong) NSString<Optional>* CalcDate;

@end
