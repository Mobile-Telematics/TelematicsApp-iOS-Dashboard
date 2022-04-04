//
//  LAJSONModelHTTPClient.h
//  LAJSONModel
//

#import "LAJSONModel.h"

extern NSString *const kHTTPMethodGET DEPRECATED_ATTRIBUTE;
extern NSString *const kHTTPMethodPOST DEPRECATED_ATTRIBUTE;
extern NSString *const kContentTypeAutomatic DEPRECATED_ATTRIBUTE;
extern NSString *const kContentTypeLAJSON DEPRECATED_ATTRIBUTE;
extern NSString *const kContentTypeWWWEncoded DEPRECATED_ATTRIBUTE;

typedef void (^LAJSONObjectBlock)(id json, LAJSONModelError *err) DEPRECATED_ATTRIBUTE;

DEPRECATED_ATTRIBUTE
@interface LAJSONHTTPClient : NSObject

+ (NSMutableDictionary *)requestHeaders DEPRECATED_ATTRIBUTE;
+ (void)setDefaultTextEncoding:(NSStringEncoding)encoding DEPRECATED_ATTRIBUTE;
+ (void)setCachingPolicy:(NSURLRequestCachePolicy)policy DEPRECATED_ATTRIBUTE;
+ (void)setTimeoutInSeconds:(int)seconds DEPRECATED_ATTRIBUTE;
+ (void)setRequestContentType:(NSString *)contentTypeString DEPRECATED_ATTRIBUTE;
+ (void)getLAJSONFromURLWithString:(NSString *)urlString completion:(LAJSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)getLAJSONFromURLWithString:(NSString *)urlString params:(NSDictionary *)params completion:(LAJSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)LAJSONFromURLWithString:(NSString *)urlString method:(NSString *)method params:(NSDictionary *)params orBodyString:(NSString *)bodyString completion:(LAJSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)LAJSONFromURLWithString:(NSString *)urlString method:(NSString *)method params:(NSDictionary *)params orBodyString:(NSString *)bodyString headers:(NSDictionary *)headers completion:(LAJSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)LAJSONFromURLWithString:(NSString *)urlString method:(NSString *)method params:(NSDictionary *)params orBodyData:(NSData *)bodyData headers:(NSDictionary *)headers completion:(LAJSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)postLAJSONFromURLWithString:(NSString *)urlString params:(NSDictionary *)params completion:(LAJSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)postLAJSONFromURLWithString:(NSString *)urlString bodyString:(NSString *)bodyString completion:(LAJSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)postLAJSONFromURLWithString:(NSString *)urlString bodyData:(NSData *)bodyData completion:(LAJSONObjectBlock)completeBlock DEPRECATED_ATTRIBUTE;

@end
