//
//  APIRequest.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import Foundation;

static NSString* const GET = @"GET";
static NSString* const POST = @"POST";
static NSString* const PUT = @"PUT";
static NSString* const DELETE = @"DELETE";

static NSString* const kInternetConnectionLostNotification = @"InternetConnectionLostNotification";

@class APIRequest;
@class ResponseObject;
@class AFHTTPSessionManager;

typedef void(^APIRequestCompletionBlock)(id response, NSError* error);

@protocol APIRequestDelegate <NSObject>

@optional

- (void)apiRequest:(APIRequest*)request didLoadResult:(ResponseObject*)aResult;
- (void)apiRequest:(APIRequest*)request didFailWithError:(NSError*)aError result:(ResponseObject*)aResult;

@end

@interface APIRequest: NSObject

@property (nonatomic, weak) id<APIRequestDelegate>                  delegate;
@property (nonatomic, assign, readonly) Class                       responseClass;
@property (nonatomic, assign, readonly) BOOL                        completed;
@property (nonatomic, assign, readonly) float                       progress;
@property (nonatomic, strong, readonly) AFHTTPSessionManager*       sessionManager;
@property (nonatomic, strong, readonly) NSDictionary*               responseHeaders;
@property (nonatomic, assign) NSInteger                             tag;


#pragma mark Configure

+ (NSString*)userServiceRootURL;
+ (NSString*)indicatorsServiceURL;
+ (NSString*)leaderboardServiceURL;
+ (NSString*)carServiceURL;
+ (NSString*)claimsServiceURL;
+ (NSString*)coinsServiceURL;
+ (NSDictionary*)customRequestHeaders;
+ (NSString*)contentTypePathToJson;
+ (NSString*)instanceId;
+ (NSString*)instanceKey;


#pragma mark Instantiate

- (id)initWithDelegate:(id<APIRequestDelegate>)aDelegate;
+ (instancetype)requestWithDelegate:(id<APIRequestDelegate>)aDelegate;
+ (instancetype)requestWithCompletion:(APIRequestCompletionBlock)completion;
+ (instancetype)coldRequestWithCompletion:(APIRequestCompletionBlock)completion;
+ (instancetype)requestWithCompletion:(APIRequestCompletionBlock)completion progress:(void (^)(float))progress;
- (void)setCompletionBlock:(APIRequestCompletionBlock)completionBlock;
- (void)setProgressBlock:(void (^)(float))progress;


#pragma mark Use

- (void)performRequestWithPath:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;
- (void)performRequestWithPathV2:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;
- (void)performRequestWithPath:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters bodyObject:(NSDictionary*)bodyObject method:(NSString*)httpMethod;
- (void)performRequestIndicatorsService:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;
- (void)performRequestLeaderboardService:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;
- (void)performRequestCarService:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;
- (void)performRequestClaimsService:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;
- (void)performRequestCoinsService:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;
- (void)performRequest:(NSMutableURLRequest*)arequest withResponseClass:(Class)responseClass;
- (void)cancel;

@end
