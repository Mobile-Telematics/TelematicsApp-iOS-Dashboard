//
//  LoginAuthApiRequest.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAAPIRequest.h"

@class LARegPhoneRequestData;
@class LARefreshTokenRequestData;
@class LALoginPhoneRequestData;
@class LAProfileRequestData;

@interface LoginAuthApiRequest: LAAPIRequest

#pragma mark Auth

- (void)registerUserWithParameters:(LARegPhoneRequestData*)regData;


#pragma mark RefreshToken

- (void)refreshJWToken:(LARefreshTokenRequestData*)refreshData;


#pragma mark JWT by DeviceToken

- (void)getJWTokenByDeviceToken:(LALoginPhoneRequestData*)loginData;


#pragma mark Indicators Service For Statistics & Scores

- (void)getLatestDayStatisticsScoring;

- (void)getIndicatorsStatisticsIndividualForPeriod:(NSString *)startDate endDate:(NSString*)endDate;

- (void)getScoringsIndividualCurrentDay:(NSString *)startDate endDate:(NSString*)endDate;

- (void)getScoringsIndividual14daysDaily:(NSString *)startDate endDate:(NSString*)endDate;


#pragma mark Indicators Eco For Dashboard

- (void)getEcoScoresForTimePeriod:(NSString *)startDate endDate:(NSString*)endDate;


#pragma mark Indicators For Coins For Dashboard Preloader

- (void)getCoinsStatisticsIndividualForPeriod:(NSString *)startDate endDate:(NSString*)endDate;


#pragma mark Indicators For Coins For Eco Percents

- (void)getIndicatorsIndividualForPeriod:(NSString *)startDate endDate:(NSString*)endDate;


#pragma mark Indicators Streaks

- (void)getIndicatorsStreaks;

#pragma markUser Profile

- (void)getUserProfile;
- (void)updateProfile:(LAProfileRequestData *)profileData;

@end
