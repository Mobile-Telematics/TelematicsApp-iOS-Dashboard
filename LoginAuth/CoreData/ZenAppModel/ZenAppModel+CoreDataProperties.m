//
//  ZenAppModel+CoreDataProperties.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 28.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZenAppModel+CoreDataProperties.h"

@implementation ZenAppModel (CoreDataProperties)

@dynamic current_user;
@dynamic userId;
@dynamic userEmail;
@dynamic userFullName;
@dynamic userFirstName;
@dynamic userFamilyName;
@dynamic userPhone;
@dynamic userBirthday;
@dynamic userReferral;
@dynamic userNickname;
@dynamic userFullAccountIsComplete;
@dynamic userRegistrationByPhotos;
@dynamic userMarital;
@dynamic userChildren;
@dynamic userAddress;
@dynamic userInsurerId;
@dynamic userGender;
@dynamic userAvatarLink;
@dynamic userPhotoData;

@dynamic licenseId;
@dynamic licenseNumber;
@dynamic licenseRegistration;
@dynamic licenseDocumentValid;
@dynamic licenseDocumentIssued;
@dynamic licenseRegLocation;
@dynamic licenseCategory;
@dynamic licenseIsComplete;
@dynamic licenseIsVerifed;
@dynamic licenseShortId;
@dynamic licenseShortNumber;
@dynamic licenseShortName;
@dynamic licenseShortPhoto;
@dynamic licenseShortIsComplete;
@dynamic licenseShortVerifed;

@dynamic vehicleId;
@dynamic vehicleLicensePlate;
@dynamic vehicleVin;
@dynamic vehicleMakeAndModel;
@dynamic vehicleCarType;
@dynamic vehicleCarYear;
@dynamic vehicleChassicNumber;
@dynamic vehicleCarColor;
@dynamic vehicleEnginePowerkWt;
@dynamic vehicleEnginePowerHP;
@dynamic vehicleEngineVolume;
@dynamic vehicleEcologyClass;
@dynamic vehicleTechnicalPasportSeries;
@dynamic vehicleTechnicalPasportNumber;
@dynamic vehicleMaxWeight;
@dynamic vehicleNoLoadWeigth;
@dynamic vehicleOwnerFirstName;
@dynamic vehicleOwnerLastName;
@dynamic vehicleOwnerMiddleName;
@dynamic vehicleOwnerAddress;
@dynamic vehicleSpecialMarks;
@dynamic vehicleIsComplete;
@dynamic vehicleShortData;

@dynamic notFirstRunApp;
@dynamic notFirstRunWizard;
@dynamic notFirstRunRewards;

@dynamic statRating;
@dynamic statPreviousRating;
@dynamic statDiscount;
@dynamic statMileageLevel;
@dynamic statSpeedLevel;
@dynamic statDrivingLevel;
@dynamic statPhoneLevel;
@dynamic statTimeOfDayScore;
@dynamic statTrackCount;
@dynamic statSummaryDuration;
@dynamic statSummaryDistance;
@dynamic statDistanceForScoring;

@dynamic statWeeklyMaxSpeed;
@dynamic statWeeklyAverageSpeed;
@dynamic statWeeklyTotalKm;
@dynamic statMonthlyMaxSpeed;
@dynamic statMonthlyAverageSpeed;
@dynamic statMonthlyTotalKm;
@dynamic statYearlyMaxSpeed;
@dynamic statYearlyAverageSpeed;
@dynamic statYearlyTotalKm;

@dynamic statEco;
@dynamic statPreviousEcoScoring;
@dynamic statEcoScoringFuel;
@dynamic statEcoScoringTyres;
@dynamic statEcoScoringBrakes;
@dynamic statEcoScoringDepreciation;

@dynamic eventsDataAll;
@dynamic eventsData;
@dynamic eventsCount;

@dynamic detailsAllDrivingScores;

@dynamic detailsScoreOverall;
@dynamic detailsScoreAcceleration;
@dynamic detailsScoreDeceleration;
@dynamic detailsScorePhoneUsage;
@dynamic detailsScoreSpeeding;
@dynamic detailsScoreTurn;

@end
