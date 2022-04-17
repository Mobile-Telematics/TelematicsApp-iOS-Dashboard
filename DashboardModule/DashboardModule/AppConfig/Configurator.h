//
//  Configurator.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 03.03.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Helpers.h"
#import "VisibleBuildConfig.h"

@interface Configurator : VisibleBuildConfig

@property(nonatomic, strong) NSString       *kUserServiceRootURL;
@property(nonatomic, strong) NSString       *kIndicatorsServiceURL;
@property(nonatomic, strong) NSString       *kDriveCoinsServiceURL;
@property(nonatomic, strong) NSString       *kInstanceId;
@property(nonatomic, strong) NSString       *kInstanceKey;

@property(nonatomic, strong) NSString       *hereMapsAppID;
@property(nonatomic, strong) NSString       *hereMapsAppCode;
@property(nonatomic, strong) NSString       *hereMapsLicenseKey;
@property(nonatomic, strong) NSString       *hereMapsRestApiKey;

@property(nonatomic, strong) NSString       *mainBackgroundImg;
@property(nonatomic, strong) NSString       *secondBackgroundImg;

@property(nonatomic, strong) NSString       *mainLogoGreen;
@property(nonatomic, strong) NSString       *mainLogoClear;

@property(nonatomic, strong) NSString       *kGeneratePassword;
@property(nonatomic, strong) NSString       *kOTPpassword;
@property(nonatomic, strong) NSString       *kDeviceTokenForTest;
@property(nonatomic, assign) BOOL           kEnableHighFrequency;

@property(nonatomic, strong) NSNumber       *sNeedDistanceForScoringKm;

@property(nonatomic, assign) BOOL           sNeedDelTrips;
@property(nonatomic, assign) BOOL           needDistanceInMiles;
@property(nonatomic, assign) BOOL           sNeedAmPmTime;

+ (void)setAppearance;

@end
