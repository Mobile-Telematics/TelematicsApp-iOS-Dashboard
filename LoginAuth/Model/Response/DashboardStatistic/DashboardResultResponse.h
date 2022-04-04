//
//  DashboardResultResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 28.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"

@interface DashboardResultResponse: LAResponseObject

@property (nonatomic, strong) NSNumber<Optional>* Rating;
@property (nonatomic, strong) NSNumber<Optional>* PreviousRating;
@property (nonatomic, strong) NSNumber<Optional>* MileageLevel;
@property (nonatomic, strong) NSNumber<Optional>* SpeedLevel;
@property (nonatomic, strong) NSNumber<Optional>* DrivingLevel;
@property (nonatomic, strong) NSNumber<Optional>* PhoneLevel;
@property (nonatomic, strong) NSNumber<Optional>* TimeOfDayScore;
@property (nonatomic, strong) NSNumber<Optional>* EcoScoringFuel;
@property (nonatomic, strong) NSNumber<Optional>* EcoScoringTyres;
@property (nonatomic, strong) NSNumber<Optional>* EcoScoringBrakes;
@property (nonatomic, strong) NSNumber<Optional>* EcoScoringDepreciation;
@property (nonatomic, strong) NSNumber<Optional>* EcoScoring;
@property (nonatomic, strong) NSNumber<Optional>* PreviousEcoScoring;
@property (nonatomic, strong) NSNumber<Optional>* Discount;
@property (nonatomic, strong) NSNumber<Optional>* TrackCount;
@property (nonatomic, strong) NSNumber<Optional>* SummaryDuration;
@property (nonatomic, strong) NSNumber<Optional>* SummaryDistance;
@property (nonatomic, strong) NSNumber<Optional>* DistanceForScoring;
@property (nonatomic, strong) NSNumber<Optional>* WeeklyMaxSpeed;
@property (nonatomic, strong) NSNumber<Optional>* WeeklyAverageSpeed;
@property (nonatomic, strong) NSNumber<Optional>* WeeklyTotalKm;
@property (nonatomic, strong) NSNumber<Optional>* MonthlyMaxSpeed;
@property (nonatomic, strong) NSNumber<Optional>* MonthlyAverageSpeed;
@property (nonatomic, strong) NSNumber<Optional>* MonthlyTotalKm;
@property (nonatomic, strong) NSNumber<Optional>* YearlyMaxSpeed;
@property (nonatomic, strong) NSNumber<Optional>* YearlyAverageSpeed;
@property (nonatomic, strong) NSNumber<Optional>* YearlyTotalKm;

@property (nonatomic, strong) NSNumber<Optional>* TripsCount;
@property (nonatomic, strong) NSNumber<Optional>* MileageKm;
@property (nonatomic, strong) NSNumber<Optional>* DrivingTime;

@property (nonatomic, strong) NSNumber<Optional>* SafetyScore;
@property (nonatomic, strong) NSNumber<Optional>* AccelerationScore;
@property (nonatomic, strong) NSNumber<Optional>* BrakingScore;
@property (nonatomic, strong) NSNumber<Optional>* SpeedingScore;
@property (nonatomic, strong) NSNumber<Optional>* PhoneUsageScore;
@property (nonatomic, strong) NSNumber<Optional>* CorneringScore;

@end
