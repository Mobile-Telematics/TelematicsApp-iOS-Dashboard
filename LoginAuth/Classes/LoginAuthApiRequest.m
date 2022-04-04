//
//  LoginAuthApiRequest.m
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD. on 20.01.19.
//  Copyright © 2019-2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LoginAuthApiRequest.h"
#import "ALNetworking.h"
#import "LARegPhoneRequestData.h"
#import "LARefreshTokenRequestData.h"
#import "LALoginPhoneRequestData.h"
#import "LARegResponse.h"
#import "LARefreshTokenResponse.h"
#import "LAProfileResponse.h"
#import "LAProfileRequestData.h"
#import "LANSUserDefaults-helper.h"

#import "LatestDayScoringResponse.h"
#import "DashboardResponse.h"
#import "DrivingDetailsResponse.h"
#import "EcoIndividualResponse.h"
#import "IndicatorsResponse.h"
#import "StreaksResponse.h"

@implementation LoginAuthApiRequest

#pragma mark Override

+ (instancetype)requestWithCompletion:(LAAPIRequestCompletionBlock)completion {
    LoginAuthApiRequest* req = [[self alloc] init];
    [req setCompletionBlock:^(id response, NSError *error) {
        if (completion) {
            completion(response, error);
        }
    }];
    return req;
}

+ (NSString *)authServiceRootURL {
    return @"https://user.telematicssdk.com/v1";
}

+ (NSString *)indicatorsServiceURL {
    return @"https://api.telematicssdk.com/indicators/v1";
}

+ (NSString *)instanceId {
    return defaults_object(@"InstanceIdHeader");
}

+ (NSString *)instanceKey {
    return defaults_object(@"InstanceKeyHeader");
}

+ (NSDictionary *)customRequestHeaders {
    NSMutableDictionary* headers = [[super customRequestHeaders] mutableCopy];
    
    headers[@"InstanceId"] = [self instanceId];
    headers[@"InstanceKey"] = [self instanceKey];
    
    if (defaults_object(@"OldJWTokenHeader") != nil) {
        NSString *authToken = [NSString stringWithFormat:@"Bearer %@", defaults_object(@"OldJWTokenHeader")];
        headers[@"Authorization"] = authToken;
    }
    
    return headers;
}


#pragma mark Registration

- (void)registerUserWithParameters:(LARegPhoneRequestData*)regData {
    NSDictionary* params = [regData paramsDictionary];
    [self performRequestWithPath:@"Registration/create" responseClass:[LARegResponse class] parameters:params method:POST];
}


#pragma mark RefreshToken

- (void)refreshJWToken:(LARefreshTokenRequestData*)refreshData {
    NSDictionary* params = [refreshData paramsDictionary];
    [self performRequestWithPathBodyObject:@"Auth/RefreshToken" responseClass:[LARefreshTokenResponse class] parameters:nil bodyObject:params method:POST];
}


#pragma mark JWT by DeviceToken

- (void)getJWTokenByDeviceToken:(LALoginPhoneRequestData*)loginData {
    NSDictionary* params = [loginData paramsDictionary];
    [self performRequestWithPathBodyObject:@"Auth/Login" responseClass:[LARefreshTokenResponse class] parameters:nil bodyObject:params method:POST];
}


#pragma mark Indicators Service For Statistics & Scores

- (void)getLatestDayStatisticsScoring {
    [self performRequestIndicatorsService:@"Statistics/dates" responseClass:[LatestDayScoringResponse class] parameters:nil method:GET];
}

- (void)getIndicatorsStatisticsIndividualForPeriod:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestIndicatorsService:@"Statistics" responseClass:[DashboardResponse class] parameters:params method:GET];
}

- (void)getScoringsIndividualCurrentDay:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestIndicatorsService:@"Scores/safety" responseClass:[DashboardResponse class] parameters:params method:GET];
}

- (void)getScoringsIndividual14daysDaily:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestIndicatorsService:@"Scores/safety/daily" responseClass:[DrivingDetailsResponse class] parameters:params method:GET];
}


#pragma mark Indicators Eco For Dashboard

- (void)getEcoScoresForTimePeriod:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestIndicatorsService:@"Scores/eco" responseClass:[EcoIndividualResponse class] parameters:params method:GET];
}


#pragma mark Indicators For Coins For Dashboard Preloader

- (void)getCoinsStatisticsIndividualForPeriod:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestIndicatorsService:@"Statistics" responseClass:[IndicatorsResponse class] parameters:params method:GET];
}


#pragma mark Indicators For Coins For Eco Percents

- (void)getIndicatorsIndividualForPeriod:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestIndicatorsService:@"Scores/eco" responseClass:[EcoIndividualResponse class] parameters:params method:GET];
}


#pragma mark Indicators Streaks

- (void)getIndicatorsStreaks {
    [self performRequestIndicatorsService:@"Streaks" responseClass:[StreaksResponse class] parameters:nil method:GET];
}


#pragma mark UserProfile

- (void)getUserProfile {
    [self performRequestWithPath:@"Management/users" responseClass:[LAProfileResponse class] parameters:nil method:GET];
}

- (void)updateProfile:(LAProfileRequestData *)profileData {
    NSDictionary* params = [profileData paramsDictionary];
    [self performRequestWithPath:@"Management/users" responseClass:[LAResponseObject class] parameters:params method:PUT];
}


#pragma mark URLHelpers

+ (NSString *)contentTypePathToJson {
    return @"application/json; charset=utf-8";
}


@end
