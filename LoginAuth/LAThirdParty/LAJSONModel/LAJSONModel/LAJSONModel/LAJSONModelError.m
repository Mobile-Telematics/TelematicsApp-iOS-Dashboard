//
//  LAJSONModelError.m
//  LAJSONModel
//

#import "LAJSONModelError.h"

NSString* const LAJSONModelErrorDomain = @"LAJSONModelErrorDomain";
NSString* const kLAJSONModelMissingKeys = @"kLAJSONModelMissingKeys";
NSString* const kLAJSONModelTypeMismatch = @"kLAJSONModelTypeMismatch";
NSString* const kLAJSONModelKeyPath = @"kLAJSONModelKeyPath";

@implementation LAJSONModelError

+(id)errorInvalidDataWithMessage:(NSString*)message
{
    message = [NSString stringWithFormat:@"Invalid LAJSON data: %@", message];
    return [LAJSONModelError errorWithDomain:LAJSONModelErrorDomain
                                      code:kLAJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
}

+(id)errorInvalidDataWithMissingKeys:(NSSet *)keys
{
    return [LAJSONModelError errorWithDomain:LAJSONModelErrorDomain
                                      code:kLAJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:@"Invalid LAJSON data. Required LAJSON keys are missing from the input. Check the error user information.",kLAJSONModelMissingKeys:[keys allObjects]}];
}

+(id)errorInvalidDataWithTypeMismatch:(NSString*)mismatchDescription
{
    return [LAJSONModelError errorWithDomain:LAJSONModelErrorDomain
                                      code:kLAJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:@"Invalid LAJSON data. The LAJSON type mismatches the expected type. Check the error user information.",kLAJSONModelTypeMismatch:mismatchDescription}];
}

+(id)errorBadResponse
{
    return [LAJSONModelError errorWithDomain:LAJSONModelErrorDomain
                                      code:kLAJSONModelErrorBadResponse
                                  userInfo:@{NSLocalizedDescriptionKey:@"Bad network response. Probably the LAJSON URL is unreachable."}];
}

+(id)errorBadLAJSON
{
    return [LAJSONModelError errorWithDomain:LAJSONModelErrorDomain
                                      code:kLAJSONModelErrorBadLAJSON
                                  userInfo:@{NSLocalizedDescriptionKey:@"Malformed LAJSON. Check the LAJSONModel data input."}];
}

+(id)errorModelIsInvalid
{
    return [LAJSONModelError errorWithDomain:LAJSONModelErrorDomain
                                      code:kLAJSONModelErrorModelIsInvalid
                                  userInfo:@{NSLocalizedDescriptionKey:@"Model does not validate. The custom validation for the input data failed."}];
}

+(id)errorInputIsNil
{
    return [LAJSONModelError errorWithDomain:LAJSONModelErrorDomain
                                      code:kLAJSONModelErrorNilInput
                                  userInfo:@{NSLocalizedDescriptionKey:@"Initializing model with nil input object."}];
}

- (instancetype)errorByPrependingKeyPathComponent:(NSString*)component
{
    // Create a mutable  copy of the user info so that we can add to it and update it
    NSMutableDictionary* userInfo = [self.userInfo mutableCopy];

    // Create or update the key-path
    NSString* existingPath = userInfo[kLAJSONModelKeyPath];
    NSString* separator = [existingPath hasPrefix:@"["] ? @"" : @".";
    NSString* updatedPath = (existingPath == nil) ? component : [component stringByAppendingFormat:@"%@%@", separator, existingPath];
    userInfo[kLAJSONModelKeyPath] = updatedPath;

    // Create the new error
    return [LAJSONModelError errorWithDomain:self.domain
                                      code:self.code
                                  userInfo:[NSDictionary dictionaryWithDictionary:userInfo]];
}

@end
