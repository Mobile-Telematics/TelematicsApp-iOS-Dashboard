//
//  LAAPIRequest.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import Foundation;

static NSString* const GET = @"GET";
static NSString* const POST = @"POST";
static NSString* const PUT = @"PUT";
static NSString* const DELETE = @"DELETE";

static NSString* const kInternetConnectionLostNotification = @"InternetConnectionLostNotification";

@class LAAPIRequest;
@class LAResponseObject;
@class ALHTTPSessionManager;

typedef void(^LAAPIRequestCompletionBlock)(id response, NSError* error);

@protocol LAAPIRequestDelegate <NSObject>

@optional

- (void)apiRequest:(LAAPIRequest*)request didLoadResult:(LAResponseObject*)aResult;
- (void)apiRequest:(LAAPIRequest*)request didFailWithError:(NSError*)aError result:(LAResponseObject*)aResult;

@end

@interface LAAPIRequest: NSObject

@property (nonatomic, weak) id<LAAPIRequestDelegate>                delegate;
@property (nonatomic, assign, readonly) Class                       responseClass;
@property (nonatomic, assign, readonly) BOOL                        completed;
@property (nonatomic, assign, readonly) float                       progress;
@property (nonatomic, strong, readonly) ALHTTPSessionManager*       sessionManager;
@property (nonatomic, strong, readonly) NSDictionary*               responseHeaders;
@property (nonatomic, assign) NSInteger                             tag;


#pragma mark Configure

+ (NSString*)authServiceRootURL;
+ (NSString*)indicatorsServiceURL;
+ (NSDictionary*)customRequestHeaders;
+ (NSString*)contentTypePathToJson;
+ (NSString*)instanceId;
+ (NSString*)instanceKey;


#pragma mark Instantiate

- (id)initWithDelegate:(id<LAAPIRequestDelegate>)aDelegate;
+ (instancetype)requestWithDelegate:(id<LAAPIRequestDelegate>)aDelegate;
+ (instancetype)requestWithCompletion:(LAAPIRequestCompletionBlock)completion;
+ (instancetype)coldRequestWithCompletion:(LAAPIRequestCompletionBlock)completion;
+ (instancetype)requestWithCompletion:(LAAPIRequestCompletionBlock)completion progress:(void (^)(float))progress;
- (void)setCompletionBlock:(LAAPIRequestCompletionBlock)completionBlock;
- (void)setProgressBlock:(void (^)(float))progress;


#pragma mark Use

- (void)performRequestWithPath:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;

- (void)performRequestIndicatorsService:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod;

- (void)performRequestWithPathBodyObject:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters bodyObject:(NSDictionary*)bodyObject method:(NSString*)httpMethod;

- (void)performRequest:(NSMutableURLRequest*)arequest withResponseClass:(Class)responseClass;

- (void)cancel;

@end
