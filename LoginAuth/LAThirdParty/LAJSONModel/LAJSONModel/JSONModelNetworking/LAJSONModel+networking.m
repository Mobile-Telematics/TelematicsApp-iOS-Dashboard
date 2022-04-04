//
//  LAJSONModel+networking.m
//  LAJSONModel
//

#import "LAJSONModel+networking.h"
#import "LAJSONHTTPClient.h"

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
#pragma GCC diagnostic ignored "-Wdeprecated-implementations"

BOOL _isLoading;

@implementation LAJSONModel(Networking)

@dynamic isLoading;

-(BOOL)isLoading
{
    return _isLoading;
}

-(void)setIsLoading:(BOOL)isLoading
{
    _isLoading = isLoading;
}

-(instancetype)initFromURLWithString:(NSString *)urlString completion:(LAJSONModelBlock)completeBlock
{
    id placeholder = [super init];
    __block id blockSelf = self;

    if (placeholder) {
        //initialization
        self.isLoading = YES;

        [LAJSONHTTPClient getLAJSONFromURLWithString:urlString
                                      completion:^(NSDictionary *json, LAJSONModelError* e) {

                                          LAJSONModelError* initError = nil;
                                          blockSelf = [self initWithDictionary:json error:&initError];

                                          if (completeBlock) {
                                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_MSEC), dispatch_get_main_queue(), ^{
                                                  completeBlock(blockSelf, e?e:initError );
                                              });
                                          }

                                          self.isLoading = NO;

                                      }];
    }
    return placeholder;
}

+ (void)getModelFromURLWithString:(NSString*)urlString completion:(LAJSONModelBlock)completeBlock
{
    [LAJSONHTTPClient getLAJSONFromURLWithString:urlString
                                  completion:^(NSDictionary* jsonDict, LAJSONModelError* err)
    {
        LAJSONModel* model = nil;

        if(err == nil)
        {
            model = [[self alloc] initWithDictionary:jsonDict error:&err];
        }

        if(completeBlock != nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                completeBlock(model, err);
            });
        }
    }];
}

+ (void)postModel:(LAJSONModel*)post toURLWithString:(NSString*)urlString completion:(LAJSONModelBlock)completeBlock
{
    [LAJSONHTTPClient postLAJSONFromURLWithString:urlString
                                   bodyString:[post toLAJSONString]
                                   completion:^(NSDictionary* jsonDict, LAJSONModelError* err)
    {
        LAJSONModel* model = nil;

        if(err == nil)
        {
            model = [[self alloc] initWithDictionary:jsonDict error:&err];
        }

        if(completeBlock != nil)
        {
            dispatch_async(dispatch_get_main_queue(), ^
            {
                completeBlock(model, err);
            });
        }
    }];
}

@end
