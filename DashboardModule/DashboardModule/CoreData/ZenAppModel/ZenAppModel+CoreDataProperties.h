//
//  ZenAppModel+CoreDataProperties.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 28.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZenAppModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZenAppModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *current_user;
@property (nullable, nonatomic, retain) NSNumber *userId;
@property (nullable, nonatomic, retain) NSString *userEmail;
@property (nullable, nonatomic, retain) NSString *userFullName;
@property (nullable, nonatomic, retain) NSString *userFirstName;
@property (nullable, nonatomic, retain) NSString *userFamilyName;
@property (nullable, nonatomic, retain) NSString *userPhone;
@property (nullable, nonatomic, retain) NSString *userBirthday;
@property (nullable, nonatomic, retain) NSString *userReferral;
@property (nullable, nonatomic, retain) NSString *userNickname;
@property (nullable, nonatomic, retain) NSNumber *userFullAccountIsComplete;
@property (nullable, nonatomic, retain) NSNumber *userRegistrationByPhotos;
@property (nullable, nonatomic, retain) NSString *userMarital;
@property (nullable, nonatomic, retain) NSString *userChildren;
@property (nullable, nonatomic, retain) NSString *userAddress;
@property (nullable, nonatomic, retain) NSString *userInsurerId;
@property (nullable, nonatomic, retain) NSString *userGender;
@property (nullable, nonatomic, retain) NSString *userAvatarLink;
@property (nullable, nonatomic, retain) NSData *userPhotoData;

@property (nullable, nonatomic, retain) NSString *licenseId;
@property (nullable, nonatomic, retain) NSString *licenseNumber;
@property (nullable, nonatomic, retain) NSString *licenseRegistration;
@property (nullable, nonatomic, retain) NSString *licenseDocumentValid;
@property (nullable, nonatomic, retain) NSString *licenseDocumentIssued;
@property (nullable, nonatomic, retain) NSString *licenseRegLocation;
@property (nullable, nonatomic, retain) NSMutableArray *licenseCategory;
@property (nullable, nonatomic, retain) NSNumber *licenseIsComplete;
@property (nullable, nonatomic, retain) NSNumber *licenseIsVerifed;
@property (nullable, nonatomic, retain) NSString *licenseShortId;
@property (nullable, nonatomic, retain) NSString *licenseShortNumber;
@property (nullable, nonatomic, retain) NSString *licenseShortName;
@property (nullable, nonatomic, retain) NSString *licenseShortPhoto;
@property (nullable, nonatomic, retain) NSNumber *licenseShortIsComplete;
@property (nullable, nonatomic, retain) NSNumber *licenseShortVerifed;

@property (nullable, nonatomic, retain) NSString *vehicleId;
@property (nullable, nonatomic, retain) NSString *vehicleLicensePlate;
@property (nullable, nonatomic, retain) NSString *vehicleVin;
@property (nullable, nonatomic, retain) NSString *vehicleMakeAndModel;
@property (nullable, nonatomic, retain) NSString *vehicleCarType;
@property (nullable, nonatomic, retain) NSString *vehicleCarYear;
@property (nullable, nonatomic, retain) NSString *vehicleChassicNumber;
@property (nullable, nonatomic, retain) NSString *vehicleCarColor;
@property (nullable, nonatomic, retain) NSString *vehicleEnginePowerkWt;
@property (nullable, nonatomic, retain) NSString *vehicleEnginePowerHP;
@property (nullable, nonatomic, retain) NSString *vehicleEngineVolume;
@property (nullable, nonatomic, retain) NSString *vehicleEcologyClass;
@property (nullable, nonatomic, retain) NSString *vehicleTechnicalPasportSeries;
@property (nullable, nonatomic, retain) NSString *vehicleTechnicalPasportNumber;
@property (nullable, nonatomic, retain) NSString *vehicleMaxWeight;
@property (nullable, nonatomic, retain) NSString *vehicleNoLoadWeigth;
@property (nullable, nonatomic, retain) NSString *vehicleOwnerFirstName;
@property (nullable, nonatomic, retain) NSString *vehicleOwnerLastName;
@property (nullable, nonatomic, retain) NSString *vehicleOwnerMiddleName;
@property (nullable, nonatomic, retain) NSString *vehicleOwnerAddress;
@property (nullable, nonatomic, retain) NSString *vehicleSpecialMarks;
@property (nullable, nonatomic, retain) NSNumber *vehicleIsComplete;
@property (nullable, nonatomic, retain) NSMutableArray *vehicleShortData;

@property (nonatomic, assign) BOOL notFirstRunApp;
@property (nonatomic, assign) BOOL notFirstRunWizard;
@property (nonatomic, assign) BOOL notFirstRunRewards;

@property (nullable, nonatomic, retain) NSNumber *statDiscount;
@property (nullable, nonatomic, retain) NSNumber *statRating;
@property (nullable, nonatomic, retain) NSNumber *statPreviousRating;
@property (nullable, nonatomic, retain) NSNumber *statMileageLevel;
@property (nullable, nonatomic, retain) NSNumber *statSpeedLevel;
@property (nullable, nonatomic, retain) NSNumber *statDrivingLevel;
@property (nullable, nonatomic, retain) NSNumber *statPhoneLevel;
@property (nullable, nonatomic, retain) NSNumber *statTimeOfDayScore;
@property (nullable, nonatomic, retain) NSNumber *statTrackCount;
@property (nullable, nonatomic, retain) NSNumber *statSummaryDuration;
@property (nullable, nonatomic, retain) NSNumber *statSummaryDistance;
@property (nullable, nonatomic, retain) NSNumber *statDistanceForScoring;

@property (nullable, nonatomic, retain) NSNumber *statWeeklyMaxSpeed;
@property (nullable, nonatomic, retain) NSNumber *statWeeklyAverageSpeed;
@property (nullable, nonatomic, retain) NSNumber *statWeeklyTotalKm;
@property (nullable, nonatomic, retain) NSNumber *statMonthlyMaxSpeed;
@property (nullable, nonatomic, retain) NSNumber *statMonthlyAverageSpeed;
@property (nullable, nonatomic, retain) NSNumber *statMonthlyTotalKm;
@property (nullable, nonatomic, retain) NSNumber *statYearlyMaxSpeed;
@property (nullable, nonatomic, retain) NSNumber *statYearlyAverageSpeed;
@property (nullable, nonatomic, retain) NSNumber *statYearlyTotalKm;

@property (nullable, nonatomic, retain) NSNumber *statEco;
@property (nullable, nonatomic, retain) NSNumber *statPreviousEcoScoring;
@property (nullable, nonatomic, retain) NSNumber *statEcoScoringFuel;
@property (nullable, nonatomic, retain) NSNumber *statEcoScoringTyres;
@property (nullable, nonatomic, retain) NSNumber *statEcoScoringBrakes;
@property (nullable, nonatomic, retain) NSNumber *statEcoScoringDepreciation;

@property (nullable, nonatomic, retain) NSMutableArray *eventsDataAll;
@property (nullable, nonatomic, retain) NSMutableArray *eventsData;
@property (nullable, nonatomic, retain) NSNumber *eventsCount;

@property (nullable, nonatomic, retain) NSArray *detailsAllDrivingScores;

@property (nullable, nonatomic, retain) NSNumber *detailsScoreOverall;
@property (nullable, nonatomic, retain) NSNumber *detailsScoreAcceleration;
@property (nullable, nonatomic, retain) NSNumber *detailsScoreDeceleration;
@property (nullable, nonatomic, retain) NSNumber *detailsScorePhoneUsage;
@property (nullable, nonatomic, retain) NSNumber *detailsScoreSpeeding;
@property (nullable, nonatomic, retain) NSNumber *detailsScoreTurn;

@end

NS_ASSUME_NONNULL_END
