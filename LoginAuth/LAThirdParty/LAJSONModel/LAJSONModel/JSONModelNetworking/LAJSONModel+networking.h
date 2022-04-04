//
//  LAJSONModel+networking.h
//  LAJSONModel
//

#import "LAJSONModel.h"
#import "LAJSONHTTPClient.h"

typedef void (^LAJSONModelBlock)(id model, LAJSONModelError *err) DEPRECATED_ATTRIBUTE;

@interface LAJSONModel (Networking)

@property (assign, nonatomic) BOOL isLoading DEPRECATED_ATTRIBUTE;
- (instancetype)initFromURLWithString:(NSString *)urlString completion:(LAJSONModelBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)getModelFromURLWithString:(NSString *)urlString completion:(LAJSONModelBlock)completeBlock DEPRECATED_ATTRIBUTE;
+ (void)postModel:(LAJSONModel *)post toURLWithString:(NSString *)urlString completion:(LAJSONModelBlock)completeBlock DEPRECATED_ATTRIBUTE;

@end
