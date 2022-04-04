//
//  LAAPIRequest.m
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAAPIRequest.h"
#import "ALNetworking.h"
#import "LAJSONModelLib.h"
#import <ifaddrs.h>
#import <arpa/inet.h>


static NSString* const kLAAPIRequestErrorDomain = @"LAAPIRequestErrorDomain";

@interface LAAPIRequest () {
}

@property (nonatomic, strong) NSMutableURLRequest* request;
@property (nonatomic, strong) NSMutableURLRequest* savedRequest;
@property (nonatomic, strong) NSURLSessionDataTask* currentOperation;
@property (nonatomic, assign) float progress;
@property (nonatomic, assign) BOOL isColdRequest;
@property (nonatomic, assign) Class responseClass;
@property (nonatomic, assign) BOOL completed;
@property (nonatomic, strong) LAAPIRequestCompletionBlock completionBlock;
@property (nonatomic, strong) void (^progressBlock)(float);
@property (nonatomic, strong) NSDictionary *responseHeaders;
@property int extraMainResetCounter;
@property int counter;

@end

@implementation LAAPIRequest

- (void)dealloc {
    //
}

+ (NSString *)authServiceRootURL {
    @throw [NSException exceptionWithName:@"" reason:@"Subclass LAAPIRequest and override [authServiceRootURL] method to provide server URL" userInfo:nil];
    return nil;
}

+ (NSString *)indicatorsServiceURL {
    @throw [NSException exceptionWithName:@"" reason:@"Subclass LAAPIRequest and override [indicatorsServiceURL] method to provide server URL" userInfo:nil];
    return nil;
}

+ (NSString *)contentTypePathToJson {
    @throw [NSException exceptionWithName:@"" reason:@"Subclass LAAPIRequest and override [contentTypePathToJson] method to provide server URL" userInfo:nil];
    return nil;
}

+ (NSString *)instanceId {
    @throw [NSException exceptionWithName:@"" reason:@"Subclass LAAPIRequest and override [instanceId] method to provide server URL" userInfo:nil];
    return nil;
}

+ (NSString *)instanceKey {
    @throw [NSException exceptionWithName:@"" reason:@"Subclass LAAPIRequest and override [instanceKey] method to provide server URL" userInfo:nil];
    return nil;
}

+ (NSDictionary *)customRequestHeaders {
    return @{};
}

+ (ALHTTPSessionManager*)sharedHTTPSessionManager {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ALHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[self authServiceRootURL]]];
        ((ALHTTPSessionManager*)_sharedInstance).requestSerializer = [ALJSONRequestSerializer serializer];
        ((ALHTTPSessionManager*)_sharedInstance).responseSerializer = [ALJSONResponseSerializer serializer];
    });
    return _sharedInstance;
}

+ (instancetype)requestWithDelegate:(id<LAAPIRequestDelegate>)aDelegate {
    return [[self alloc] initWithDelegate:aDelegate];
}

+ (instancetype)requestWithCompletion:(LAAPIRequestCompletionBlock)completion {
    return [self requestWithCompletion:completion progress:NULL];
}

+ (instancetype)coldRequestWithCompletion:(LAAPIRequestCompletionBlock)completion {
    LAAPIRequest* result = [self requestWithCompletion:completion progress:NULL];
    result.isColdRequest = YES;
    return result;
}

+ (instancetype)requestWithCompletion:(LAAPIRequestCompletionBlock)completion progress:(void (^)(float))progress {
    LAAPIRequest* result = [[self alloc] initWithDelegate:(id<UIDropInteractionDelegate>)self];
    [result setCompletionBlock:completion];
    [result setProgressBlock:progress];
    return result;
}

- (ALHTTPSessionManager *)sessionManager {
    return [[self class] sharedHTTPSessionManager];
}

- (id)initWithDelegate:(id<LAAPIRequestDelegate>)aDelegate {
    self = [super init];
    if (self) {
        self.delegate = aDelegate;
    }
    return self;
}


#pragma mark - LoginAuth Request

- (void)performRequestWithPath:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod {
    self.responseClass = responseClass;
    if (![path hasPrefix:@"http"]) {
        path = [NSString stringWithFormat:@"%@/%@", [[self class] authServiceRootURL], path];
    }
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    ALHTTPSessionManager *manager = [[self class] sharedHTTPSessionManager];
    NSError* error = nil;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:httpMethod URLString:path parameters:parameters error:&error];
    request.timeoutInterval = 180;
    
    NSDictionary* customHeaders = [[self class] customRequestHeaders];
    for (NSString* key in customHeaders.allKeys) {
        [request setValue:customHeaders[key] forHTTPHeaderField:key];
    }
    [self performRequest:request withResponseClass:responseClass];
}


#pragma mark - IndicatorsService

- (void)performRequestIndicatorsService:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters method:(NSString*)httpMethod {
    self.responseClass = responseClass;
    if (![path hasPrefix:@"http"]) {
        path = [NSString stringWithFormat:@"%@/%@", [[self class] indicatorsServiceURL], path];
    }
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    ALHTTPSessionManager *manager = [[self class] sharedHTTPSessionManager];
    NSError* error = nil;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:httpMethod URLString:path parameters:parameters error:&error];
    
    NSLog(@"req %@", request.URL.absoluteString);
    NSDictionary* customHeaders = [[self class] customRequestHeaders];
    for (NSString* key in customHeaders.allKeys) {
        [request setValue:customHeaders[key] forHTTPHeaderField:key];
    }
    [self performRequest:request withResponseClass:responseClass];
}


#pragma mark - LoginAuth Request with Body

- (void)performRequestWithPathBodyObject:(NSString*)path responseClass:(Class)responseClass parameters:(NSDictionary*)parameters bodyObject:(NSDictionary*)bodyObject method:(NSString*)httpMethod {
    
    self.responseClass = responseClass;
    if (![path hasPrefix:@"http"]) {
        path = [NSString stringWithFormat:@"%@/%@", [[self class] authServiceRootURL], path];
    }
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL* URL = [NSURL URLWithString:path];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    
    [request addValue:[[self class] contentTypePathToJson] forHTTPHeaderField:@"Content-Type"];
    [request addValue:[[self class] instanceId] forHTTPHeaderField:@"InstanceId"];
    [request addValue:[[self class] instanceKey] forHTTPHeaderField:@"InstanceKey"];
    
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:bodyObject options:kNilOptions error:NULL];
    
    [self performRequest:request withResponseClass:responseClass];
}


#pragma mark - Root LoginAuth Request

- (void)performRequest:(NSMutableURLRequest*)arequest withResponseClass:(Class)responseClass {
    self.request = arequest;
    
    ALHTTPSessionManager *manager = [[self class] sharedHTTPSessionManager];
    
    self.currentOperation = [manager dataTaskWithRequest:arequest uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable parsedObject, NSError * _Nullable error) {
        if (error) {
            
            NSLog(@"%@ %ld", error.localizedDescription, (long)error.code);
            if (error.code == 405 || [error.localizedDescription isEqualToString:@"Request failed: method not allowed (405)"]) {
                NSLog(@"FULL STOP ERROR 405");
                if (self.completionBlock) {
                    self.completionBlock(nil, error);
                }
                return;
            }
            
            NSString *clUrl = [NSString stringWithFormat:@"%@", arequest.URL];
            if ([clUrl isEqualToString:@"https://insp.telematicssdk.com/api/v1/profiles/login"]) {
                if (self.completionBlock) {
                    self.completionBlock(nil, error);
                }
                return;
            }
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            self.completed = YES;
            
            if (((NSHTTPURLResponse*)response).statusCode == 401) {
                //
            } else {
                
                NSDictionary* respDict = nil;
                id responseObject = nil;
                if ([parsedObject isKindOfClass:[NSDictionary class]]) {
                    respDict = parsedObject;
                    if (responseClass) {
                        NSError* err = nil;
                        responseObject = [[responseClass alloc] initWithDictionary:respDict error:&err];
                    } else {
                        responseObject = respDict;
                    }
                }
                if (self.completionBlock) {
                    self.completionBlock(nil, error);
                }
                if ([self.delegate respondsToSelector:@selector(apiRequest:didFailWithError:result:)]) {
                    [self.delegate apiRequest:self didFailWithError:error result:responseObject];
                }
                if (error.code == NSURLErrorNotConnectedToInternet) {
                    //SITUATION NOT NEED
                } else {
                    //
                }
            }
            
        } else {
            
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            self.completed = YES;
            
            //NSLog(@"********PARSEDRESULTBACKEND>>>>>>>>>> %@", parsedObject);
            
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                self.responseHeaders = ((NSHTTPURLResponse *)response).allHeaderFields;
            }
            NSDictionary* respDict = nil;
            respDict = parsedObject;
            id responseObject;
            if (responseClass) {
                NSError* err = nil;
                responseObject = [[responseClass alloc] initWithDictionary:respDict error:&err];
            } else {
                responseObject = respDict;
            }

            if (self.completionBlock) {
                self.completionBlock(responseObject, nil);
            }
            if ([self.delegate respondsToSelector:@selector(apiRequest:didLoadResult:)]) {
                [self.delegate apiRequest:self didLoadResult:responseObject];
            }
        }
    }];
    
    if (!self.isColdRequest) {
        [self.currentOperation resume];
    }
}

- (void)cancel {
    [self.currentOperation cancel];
}

@end
