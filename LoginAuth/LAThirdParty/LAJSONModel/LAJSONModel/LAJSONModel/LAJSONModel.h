//
//  LAJSONModel.h
//  LAJSONModel
//

#import <Foundation/Foundation.h>

#import "LAJSONModelError.h"
#import "LAJSONValueTransformer.h"
#import "LAJSONKeyMapper.h"

/////////////////////////////////////////////////////////////////////////////////////////////
#if TARGET_IPHONE_SIMULATOR
#define JMLog( s, ... ) NSLog( @"[%@:%d] %@", [[NSString stringWithUTF8String:__FILE__] \
lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define JMLog( s, ... )
#endif
/////////////////////////////////////////////////////////////////////////////////////////////

DEPRECATED_ATTRIBUTE
@protocol ConvertOnDemand
@end

DEPRECATED_ATTRIBUTE
@protocol Index
@end

#pragma mark - Property Protocols
/**
 * Protocol for defining properties in a LAJSON Model class that should not be considered at all
 * neither while importing nor when exporting LAJSON.
 *
 * @property (strong, nonatomic) NSString <Ignore> *propertyName;
 *
 */
@protocol Ignore
@end

/**
 * Protocol for defining optional properties in a LAJSON Model class. Use like below to define
 * model properties that are not required to have values in the LAJSON input:
 *
 * @property (strong, nonatomic) NSString <Optional> *propertyName;
 *
 */
@protocol Optional
@end

/**
 * Make all objects compatible to avoid compiler warnings
 */
@interface NSObject (LAJSONModelPropertyCompatibility) <Optional, Ignore>
@end

/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - LAJSONModel protocol
/**
 * A protocol describing an abstract LAJSONModel class
 * LAJSONModel conforms to this protocol, so it can use itself abstractly
 */
@protocol AbstractLAJSONModelProtocol <NSCopying, NSCoding>

@required
/**
 * All LAJSONModel classes should implement initWithDictionary:
 *
 * For most classes the default initWithDictionary: inherited from LAJSONModel itself
 * should suffice, but developers have the option to also overwrite it if needed.
 *
 * @param dict a dictionary holding LAJSON objects, to be imported in the model.
 * @param err an error or NULL
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError **)err;


/**
 * All LAJSONModel classes should implement initWithData:error:
 *
 * For most classes the default initWithData: inherited from LAJSONModel itself
 * should suffice, but developers have the option to also overwrite it if needed.
 *
 * @param data representing a LAJSON response (usually fetched from web), to be imported in the model.
 * @param error an error or NULL
 */
- (instancetype)initWithData:(NSData *)data error:(NSError **)error;

/**
 * All LAJSONModel classes should be able to export themselves as a dictionary of
 * LAJSON compliant objects.
 *
 * For most classes the inherited from LAJSONModel default toDictionary implementation
 * should suffice.
 *
 * @return NSDictionary dictionary of LAJSON compliant objects
 * @exception LAJSONModelTypeNotAllowedException thrown when one of your model's custom class properties
 * does not have matching transformer method in an LAJSONValueTransformer.
 */
- (NSDictionary *)toDictionary;

/**
 * Export a model class to a dictionary, including only given properties
 *
 * @param propertyNames the properties to export; if nil, all properties exported
 * @return NSDictionary dictionary of LAJSON compliant objects
 * @exception LAJSONModelTypeNotAllowedException thrown when one of your model's custom class properties
 * does not have matching transformer method in an LAJSONValueTransformer.
 */
- (NSDictionary *)toDictionaryWithKeys:(NSArray <NSString *> *)propertyNames;
@end

/////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - LAJSONModel interface
/**
 * The LAJSONModel is an abstract model class, you should not instantiate it directly,
 * as it does not have any properties, and therefore cannot serve as a data model.
 * Instead you should subclass it, and define the properties you want your data model
 * to have as properties of your own class.
 */
@interface LAJSONModel : NSObject <AbstractLAJSONModelProtocol, NSSecureCoding>

// deprecated
+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array DEPRECATED_MSG_ATTRIBUTE("use arrayOfModelsFromDictionaries:error:");
+ (void)setGlobalKeyMapper:(LAJSONKeyMapper *)globalKeyMapper DEPRECATED_MSG_ATTRIBUTE("override +keyMapper in a base model class instead");
+ (NSString *)protocolForArrayProperty:(NSString *)propertyName DEPRECATED_MSG_ATTRIBUTE("use classForCollectionProperty:");
- (void)mergeFromDictionary:(NSDictionary *)dict useKeyMapping:(BOOL)useKeyMapping DEPRECATED_MSG_ATTRIBUTE("use mergeFromDictionary:useKeyMapping:error:");
- (NSString *)indexPropertyName DEPRECATED_ATTRIBUTE;
- (NSComparisonResult)compare:(id)object DEPRECATED_ATTRIBUTE;

/** @name Creating and initializing models */

/**
 * Create a new model instance and initialize it with the LAJSON from a text parameter. The method assumes UTF8 encoded input text.
 * @param string LAJSON text data
 * @param err an initialization error or nil
 * @exception LAJSONModelTypeNotAllowedException thrown when unsupported type is found in the incoming LAJSON,
 * or a property type in your model is not supported by LAJSONValueTransformer and its categories
 * @see initWithString:usingEncoding:error: for use of custom text encodings
 */
- (instancetype)initWithString:(NSString *)string error:(LAJSONModelError **)err;

/**
 * Create a new model instance and initialize it with the LAJSON from a text parameter using the given encoding.
 * @param string LAJSON text data
 * @param encoding the text encoding to use when parsing the string (see NSStringEncoding)
 * @param err an initialization error or nil
 * @exception LAJSONModelTypeNotAllowedException thrown when unsupported type is found in the incoming LAJSON,
 * or a property type in your model is not supported by LAJSONValueTransformer and its categories
 */
- (instancetype)initWithString:(NSString *)string usingEncoding:(NSStringEncoding)encoding error:(LAJSONModelError **)err;

/** @name Exporting model contents */

/**
 * Export the whole object to a LAJSON data text string
 * @return LAJSON text describing the data model
 */
- (NSString *)toLAJSONString;

/**
 * Export the whole object to a LAJSON data text string
 * @return LAJSON text data describing the data model
 */
- (NSData *)toLAJSONData;

/**
 * Export the specified properties of the object to a LAJSON data text string
 * @param propertyNames the properties to export; if nil, all properties exported
 * @return LAJSON text describing the data model
 */
- (NSString *)toLAJSONStringWithKeys:(NSArray <NSString *> *)propertyNames;

/**
 * Export the specified properties of the object to a LAJSON data text string
 * @param propertyNames the properties to export; if nil, all properties exported
 * @return LAJSON text data describing the data model
 */
- (NSData *)toLAJSONDataWithKeys:(NSArray <NSString *> *)propertyNames;

/** @name Batch methods */

/**
 * If you have a list of dictionaries in a LAJSON feed, you can use this method to create an NSArray
 * of model objects. Handy when importing LAJSON data lists.
 * This method will loop over the input list and initialize a data model for every dictionary in the list.
 *
 * @param array list of dictionaries to be imported as models
 * @return list of initialized data model objects
 * @exception LAJSONModelTypeNotAllowedException thrown when unsupported type is found in the incoming LAJSON,
 * or a property type in your model is not supported by LAJSONValueTransformer and its categories
 * @exception LAJSONModelInvalidDataException thrown when the input data does not include all required keys
 * @see arrayOfDictionariesFromModels:
 */
+ (NSMutableArray *)arrayOfModelsFromDictionaries:(NSArray *)array error:(NSError **)err;
+ (NSMutableArray *)arrayOfModelsFromData:(NSData *)data error:(NSError **)err;
+ (NSMutableArray *)arrayOfModelsFromString:(NSString *)string error:(NSError **)err;
+ (NSMutableDictionary *)dictionaryOfModelsFromDictionary:(NSDictionary *)dictionary error:(NSError **)err;
+ (NSMutableDictionary *)dictionaryOfModelsFromData:(NSData *)data error:(NSError **)err;
+ (NSMutableDictionary *)dictionaryOfModelsFromString:(NSString *)string error:(NSError **)err;

/**
 * If you have an NSArray of data model objects, this method takes it in and outputs a list of the
 * matching dictionaries. This method does the opposite of arrayOfObjectsFromDictionaries:
 * @param array list of LAJSONModel objects
 * @return a list of NSDictionary objects
 * @exception LAJSONModelTypeNotAllowedException thrown when unsupported type is found in the incoming LAJSON,
 * or a property type in your model is not supported by LAJSONValueTransformer and its categories
 * @see arrayOfModelsFromDictionaries:
 */
+ (NSMutableArray *)arrayOfDictionariesFromModels:(NSArray *)array;
+ (NSMutableDictionary *)dictionaryOfDictionariesFromModels:(NSDictionary *)dictionary;

/** @name Validation */

/**
 * Overwrite the validate method in your own models if you need to perform some custom validation over the model data.
 * This method gets called at the very end of the LAJSONModel initializer, thus the model is in the state that you would
 * get it back when initialized. Check the values of any property that needs to be validated and if any invalid values
 * are encountered return NO and set the error parameter to an NSError object. If the model is valid return YES.
 *
 * NB: Only setting the error parameter is not enough to fail the validation, you also need to return a NO value.
 *
 * @param error a pointer to an NSError object, to pass back an error if needed
 * @return a BOOL result, showing whether the model data validates or not. You can use the convenience method
 * [LAJSONModelError errorModelIsInvalid] to set the NSError param if the data fails your custom validation
 */
- (BOOL)validate:(NSError **)error;

/** @name Key mapping */
/**
 * Overwrite in your models if your property names don't match your LAJSON key names.
 * Lookup LAJSONKeyMapper docs for more details.
 */
+ (LAJSONKeyMapper *)keyMapper;

/**
 * Indicates whether the property with the given name is Optional.
 * To have a model with all of its properties being Optional just return YES.
 * This method returns by default NO, since the default behaviour is to have all properties required.
 * @param propertyName the name of the property
 * @return a BOOL result indicating whether the property is optional
 */
+ (BOOL)propertyIsOptional:(NSString *)propertyName;

/**
 * Indicates whether the property with the given name is Ignored.
 * To have a model with all of its properties being Ignored just return YES.
 * This method returns by default NO, since the default behaviour is to have all properties required.
 * @param propertyName the name of the property
 * @return a BOOL result indicating whether the property is ignored
 */
+ (BOOL)propertyIsIgnored:(NSString *)propertyName;

/**
 * Indicates the class used for the elements of a collection property.
 * Rather than using:
 *     @property (strong) NSArray <MyType> *things;
 * You can implement classForCollectionProperty: and keep your property
 * defined like:
 *     @property (strong) NSArray *things;
 * @param propertyName the name of the property
 * @return Class the class used to deserialize the elements of the collection
 *
 * Example in Swift 3.0:
 * override static func classForCollectionProperty(propertyName: String) -> AnyClass? {
 *   switch propertyName {
 *     case "childModel":
 *       return ChildModel.self
 *     default:
 *       return nil
 *   }
 * }
 */
+ (Class)classForCollectionProperty:(NSString *)propertyName NS_SWIFT_NAME(classForCollectionProperty(propertyName:));

/**
 * Merges values from the given dictionary into the model instance.
 * @param dict dictionary with values
 * @param useKeyMapping if YES the method will use the model's key mapper and the global key mapper, if NO
 * it'll just try to match the dictionary keys to the model's properties
 */
- (BOOL)mergeFromDictionary:(NSDictionary *)dict useKeyMapping:(BOOL)useKeyMapping error:(NSError **)error;

@end
