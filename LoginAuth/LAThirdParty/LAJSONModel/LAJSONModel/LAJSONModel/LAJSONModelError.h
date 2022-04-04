//
//  LAJSONModelError.h
//  LAJSONModel
//

#import <Foundation/Foundation.h>

/////////////////////////////////////////////////////////////////////////////////////////////
typedef NS_ENUM(int, kLAJSONModelErrorTypes)
{
    kLAJSONModelErrorInvalidData = 1,
    kLAJSONModelErrorBadResponse = 2,
    kLAJSONModelErrorBadLAJSON = 3,
    kLAJSONModelErrorModelIsInvalid = 4,
    kLAJSONModelErrorNilInput = 5
};

/////////////////////////////////////////////////////////////////////////////////////////////
/** The domain name used for the LAJSONModelError instances */
extern NSString *const LAJSONModelErrorDomain;

/**
 * If the model LAJSON input misses keys that are required, check the
 * userInfo dictionary of the LAJSONModelError instance you get back -
 * under the kLAJSONModelMissingKeys key you will find a list of the
 * names of the missing keys.
 */
extern NSString *const kLAJSONModelMissingKeys;

/**
 * If LAJSON input has a different type than expected by the model, check the
 * userInfo dictionary of the LAJSONModelError instance you get back -
 * under the kLAJSONModelTypeMismatch key you will find a description
 * of the mismatched types.
 */
extern NSString *const kLAJSONModelTypeMismatch;

/**
 * If an error occurs in a nested model, check the userInfo dictionary of
 * the LAJSONModelError instance you get back - under the kLAJSONModelKeyPath
 * key you will find key-path at which the error occurred.
 */
extern NSString *const kLAJSONModelKeyPath;

/////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Custom NSError subclass with shortcut methods for creating
 * the common LAJSONModel errors
 */
@interface LAJSONModelError : NSError

@property (strong, nonatomic) NSHTTPURLResponse *httpResponse;

@property (strong, nonatomic) NSData *responseData;

/**
 * Creates a LAJSONModelError instance with code kLAJSONModelErrorInvalidData = 1
 */
+ (id)errorInvalidDataWithMessage:(NSString *)message;

/**
 * Creates a LAJSONModelError instance with code kLAJSONModelErrorInvalidData = 1
 * @param keys a set of field names that were required, but not found in the input
 */
+ (id)errorInvalidDataWithMissingKeys:(NSSet *)keys;

/**
 * Creates a LAJSONModelError instance with code kLAJSONModelErrorInvalidData = 1
 * @param mismatchDescription description of the type mismatch that was encountered.
 */
+ (id)errorInvalidDataWithTypeMismatch:(NSString *)mismatchDescription;

/**
 * Creates a LAJSONModelError instance with code kLAJSONModelErrorBadResponse = 2
 */
+ (id)errorBadResponse;

/**
 * Creates a LAJSONModelError instance with code kLAJSONModelErrorBadLAJSON = 3
 */
+ (id)errorBadLAJSON;

/**
 * Creates a LAJSONModelError instance with code kLAJSONModelErrorModelIsInvalid = 4
 */
+ (id)errorModelIsInvalid;

/**
 * Creates a LAJSONModelError instance with code kLAJSONModelErrorNilInput = 5
 */
+ (id)errorInputIsNil;

/**
 * Creates a new LAJSONModelError with the same values plus information about the key-path of the error.
 * Properties in the new error object are the same as those from the receiver,
 * except that a new key kLAJSONModelKeyPath is added to the userInfo dictionary.
 * This key contains the component string parameter. If the key is already present
 * then the new error object has the component string prepended to the existing value.
 */
- (instancetype)errorByPrependingKeyPathComponent:(NSString *)component;

/////////////////////////////////////////////////////////////////////////////////////////////
@end
