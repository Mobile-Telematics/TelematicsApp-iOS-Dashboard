//
//  MainApiRequest.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "MainApiRequest.h"
#import "LatestDayScoringResponse.h"
#import "DashboardResponse.h"
#import "APIRequest.h"
#import "CoinsResponse.h"
#import "CoinsDetailsResponse.h"
#import "StreaksResponse.h"
#import "CoinsResponse.h"
#import "EcoResponse.h"
#import "EcoIndividualResponse.h"
#import "DrivingDetailsResponse.h"
#import "IndicatorsResponse.h"
#import "UserService.h"
#import "Helpers.h"
#import "AFNetworking.h"
#import "ProfileResponse.h"
#import "ProfileRequestData.h"
@import MobileCoreServices;


@implementation MainApiRequest

#pragma mark Override

+ (instancetype)requestWithCompletion:(APIRequestCompletionBlock)completion {
    MainApiRequest* req = [[self alloc] init];
    [req setCompletionBlock:^(id response, NSError *error) {
        if (completion) {
            completion(response, error);
        }
    }];
    return req;
}

+ (NSString *)userServiceRootURL {
    return [Configurator sharedInstance].kUserServiceRootURL;
}

+ (NSString *)indicatorsServiceURL {
    return [Configurator sharedInstance].kIndicatorsServiceURL;
}

+ (NSString *)coinsServiceURL {
    return [Configurator sharedInstance].kDriveCoinsServiceURL;
}

+ (NSString *)instanceId {
    return [Configurator sharedInstance].kInstanceId;
}

+ (NSString *)instanceKey {
    return [Configurator sharedInstance].kInstanceKey;
}

+ (NSDictionary *)customRequestHeaders {
    NSMutableDictionary* headers = [[super customRequestHeaders] mutableCopy];
    if ([UserService sharedService].token) {
        NSString *jwt = [NSString stringWithFormat:@"Bearer %@", [UserService sharedService].token];
        headers[@"Authorization"] = jwt;
    }
    
    headers[@"InstanceId"] = [self instanceId];
    headers[@"InstanceKey"] = [self instanceKey];
    headers[@"DeviceToken"] = [UserService sharedService].virtualDeviceToken;
    
#if TARGET_IPHONE_SIMULATOR
    headers[@"refreshToken"] = [UserService sharedService].refreshToken;
#endif
    
    NSLog(@"%@", headers);
    return headers;
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


#pragma mark Coins

- (void)getCoinsDailyLimit {
    [self performRequestCoinsService:@"DriveCoins/dailylimit" responseClass:[CoinsResponse class] parameters:nil method:GET];
}

- (void)getCoinsTotal:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestCoinsService:@"DriveCoins/total" responseClass:[CoinsResponse class] parameters:params method:GET];
}

- (void)getCoinsDaily:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestCoinsService:@"DriveCoins/daily" responseClass:[CoinsDetailsResponse class] parameters:params method:GET];
}

- (void)getCoinsDetailed:(NSString *)startDate endDate:(NSString*)endDate {
    NSDictionary *params = @{@"StartDate": startDate, @"EndDate": endDate};
    [self performRequestCoinsService:@"DriveCoins/detailed" responseClass:[CoinsDetailsResponse class] parameters:params method:GET];
}


#pragma mark UserProfile

- (void)getUserProfile {
    [self performRequestWithPath:@"Management/users" responseClass:[ProfileResponse class] parameters:nil method:GET];
}

- (void)updateProfile:(ProfileRequestData *)profileData {
    [self performRequestWithPath:@"Management/users" responseClass:[ResponseObject class] parameters:[profileData paramsDictionary] method:PUT];
}

- (void)uploadProfilePicture:(ProfileRequestData *)profileData imageData:(NSData*)imageData {
    
    NSURL* URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/Management/users/images/upload", [[self class] userServiceRootURL]]];
    URL = NSURLByAppendingQueryParameters(URL, nil);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:URL];
    [request setHTTPMethod:POST];

    NSDictionary* customHeaders = [[self class] customRequestHeaders];
    for (NSString* key in customHeaders.allKeys) {
        [request setValue:customHeaders[key] forHTTPHeaderField:key];
    }
    
    NSString *boundary = @"----WebKitFormBoundary7MA4YWxkTrZu0gW";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];

    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"Image.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:imageData];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    [self performRequest:request withResponseClass:[ResponseObject class]];
}


#pragma mark Feed


#pragma mark Delete Trip Status

- (void)deleteThisTripSendStatusForBackEnd:(NSString *)tripToken {
    NSString *URLStr = [NSString stringWithFormat:@"https://mobilesdk.telematicssdk.com/mobilesdk/stage/track/%@/setdeleted/v1", tripToken];
    NSError *error;
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:POST URLString:URLStr parameters:nil error:&error];
    NSDictionary* customHeaders = [[self class] customRequestHeaders];
    for (NSString* key in customHeaders.allKeys) {
        [request setValue:customHeaders[key] forHTTPHeaderField:key];
    }
    [self performRequest:request withResponseClass:[ResponseObject class]];
}


#pragma mark Events review

- (void)tripBrowseStart:(NSString *)tripToken {
    NSString *URLStr = [NSString stringWithFormat:@"https://mobilesdk.telematicssdk.com/mobilesdk/stage/track/browsestart/v1/%@", tripToken];
    NSError *error;
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:POST URLString:URLStr parameters:nil error:&error];
    NSDictionary* customHeaders = [[self class] customRequestHeaders];
    for (NSString* key in customHeaders.allKeys) {
        [request setValue:customHeaders[key] forHTTPHeaderField:key];
    }
    [self performRequest:request withResponseClass:[ResponseObject class]];
}

- (void)reportWrongEventNoEvent:(NSString *)tripToken lat:(NSString *)lat lon:(NSString *)lon eventType:(NSString *)eventType date:(NSString *)date {
    NSDictionary *params = @{@"PointDate": date,
                             @"Latitude": lat,
                             @"Longitude": lon,
                             @"EventType": eventType
                             };
    
    NSString *URLStr = [NSString stringWithFormat:@"https://mobilesdk.telematicssdk.com/mobilesdk/stage/events/reportwrongevent/v1/%@", tripToken];
    NSError *error;
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:POST URLString:URLStr parameters:params error:&error];
    NSDictionary* customHeaders = [[self class] customRequestHeaders];
    for (NSString* key in customHeaders.allKeys) {
        [request setValue:customHeaders[key] forHTTPHeaderField:key];
    }
    [self performRequest:request withResponseClass:[ResponseObject class]];
}

- (void)reportWrongEventNewEvent:(NSString *)tripToken lat:(NSString *)lat lon:(NSString *)lon eventType:(NSString *)eventType newEventType:(NSString *)newEventType date:(NSString *)date {
    NSDictionary *params = @{@"PointDate": date,
                             @"Latitude": lat,
                             @"Longitude": lon,
                             @"EventType": eventType,
                             @"ChangeTypeTo": newEventType
                             };
    
    NSString *URLStr = [NSString stringWithFormat:@"https://mobilesdk.telematicssdk.com/mobilesdk/stage/events/reportwrongeventtype/v1/%@", tripToken];
    NSError *error;
    NSMutableURLRequest *request = [self.sessionManager.requestSerializer requestWithMethod:POST URLString:URLStr parameters:params error:&error];
    NSDictionary* customHeaders = [[self class] customRequestHeaders];
    for (NSString* key in customHeaders.allKeys) {
        [request setValue:customHeaders[key] forHTTPHeaderField:key];
    }
    [self performRequest:request withResponseClass:[ResponseObject class]];
}

- (NSString *)mimeTypeForPath:(NSString *)path {

    CFStringRef extension = (__bridge CFStringRef)[path pathExtension];
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, extension, NULL);
    assert(UTI != NULL);

    NSString *mimetype = CFBridgingRelease(UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType));
    assert(mimetype != NULL);

    CFRelease(UTI);

    return mimetype;
}

- (NSString *)generateBoundaryString {
    return [NSString stringWithFormat:@"Boundary-%@", [[NSUUID UUID] UUIDString]];
}


#pragma mark URLHelpers

+ (NSString *)contentTypePathToJson {
    return @"application/json; charset=utf-8";
}

static NSString* NSStringFromQueryParameters(NSDictionary* queryParameters) {
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]],
                          [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]]
                          ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

static NSURL* NSURLByAppendingQueryParameters(NSURL* URL, NSDictionary* queryParameters) {
    NSString* URLString = [NSString stringWithFormat:@"%@?%@",
                           [URL absoluteString],
                           NSStringFromQueryParameters(queryParameters)];
    return [NSURL URLWithString:URLString];
}

@end
