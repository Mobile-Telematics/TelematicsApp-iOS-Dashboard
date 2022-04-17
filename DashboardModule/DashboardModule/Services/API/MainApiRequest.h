//
//  APIRequest.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "APIRequest.h"

@class RefreshTokenRequestData;
@class ProfileRequestData;
@class FeedRequestData;

@interface MainApiRequest: APIRequest


#pragma mark Indicators Statistic
    
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


#pragma mark Indicators Streaks For Coins

- (void)getIndicatorsStreaks;


#pragma mark Delete Trip Status

- (void)deleteThisTripSendStatusForBackEnd:(NSString *)tripToken;


#pragma mark Coins

- (void)getCoinsDailyLimit;
- (void)getCoinsTotal:(NSString *)startDate endDate:(NSString*)endDate;
- (void)getCoinsDetailed:(NSString *)startDate endDate:(NSString*)endDate;
- (void)getCoinsDaily:(NSString *)startDate endDate:(NSString*)endDate;


#pragma mark Cornering browse trip events

- (void)tripBrowseStart:(NSString *)tripToken;
- (void)reportWrongEventNoEvent:(NSString *)tripToken lat:(NSString *)lat lon:(NSString *)lon eventType:(NSString *)eventType date:(NSString *)date;
- (void)reportWrongEventNewEvent:(NSString *)tripToken lat:(NSString *)lat lon:(NSString *)lon eventType:(NSString *)eventType newEventType:(NSString *)newEventType date:(NSString *)date;

    
#pragma mark Leaderboard

- (void)getLeaderboardForCurrentUser;
- (void)getLeaderboardScore:(NSUInteger)scoringRate;


#pragma mark UserProfile

- (void)getUserProfile;
- (void)updateProfile:(ProfileRequestData *)profileData;
- (void)uploadProfilePicture:(ProfileRequestData *)profileData imageData:(NSData*)imageData;


@end
