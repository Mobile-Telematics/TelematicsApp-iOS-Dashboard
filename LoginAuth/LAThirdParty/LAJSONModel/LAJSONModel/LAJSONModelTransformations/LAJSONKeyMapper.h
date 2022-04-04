//
//  LAJSONKeyMapper.h
//  LAJSONModel
//

#import <Foundation/Foundation.h>

typedef NSString *(^LAJSONModelKeyMapBlock)(NSString *keyName);

/**
 * **You won't need to create or store instances of this class yourself.** If you want your model
 * to have different property names than the LAJSON feed keys, look below on how to
 * make your model use a key mapper.
 *
 * For example if you consume LAJSON from twitter
 * you get back underscore_case style key names. For example:
 *
 * <pre>"profile_sidebar_border_color": "0094C2",
 * "profile_background_tile": false,</pre>
 *
 * To comply with Obj-C accepted camelCase property naming for your classes,
 * you need to provide mapping between LAJSON keys and ObjC property names.
 *
 * In your model overwrite the + (LAJSONKeyMapper *)keyMapper method and provide a LAJSONKeyMapper
 * instance to convert the key names for your model.
 *
 * If you need custom mapping it's as easy as:
 * <pre>
 * + (LAJSONKeyMapper *)keyMapper {
 * &nbsp; return [[LAJSONKeyMapper&nbsp;alloc]&nbsp;initWithDictionary:@{@"crazy_LAJSON_name":@"myCamelCaseName"}];
 * }
 * </pre>
 * In case you want to handle underscore_case, **use the predefined key mapper**, like so:
 * <pre>
 * + (LAJSONKeyMapper *)keyMapper {
 * &nbsp; return [LAJSONKeyMapper&nbsp;mapperFromUnderscoreCaseToCamelCase];
 * }
 * </pre>
 */
@interface LAJSONKeyMapper : NSObject

// deprecated
@property (readonly, nonatomic) LAJSONModelKeyMapBlock LAJSONToModelKeyBlock DEPRECATED_ATTRIBUTE;
- (NSString *)convertValue:(NSString *)value isImportingToModel:(BOOL)importing DEPRECATED_MSG_ATTRIBUTE("use convertValue:");
- (instancetype)initWithDictionary:(NSDictionary *)map DEPRECATED_MSG_ATTRIBUTE("use initWithModelToLAJSONDictionary:");
- (instancetype)initWithLAJSONToModelBlock:(LAJSONModelKeyMapBlock)toModel modelToLAJSONBlock:(LAJSONModelKeyMapBlock)toLAJSON DEPRECATED_MSG_ATTRIBUTE("use initWithModelToLAJSONBlock:");
+ (instancetype)mapper:(LAJSONKeyMapper *)baseKeyMapper withExceptions:(NSDictionary *)exceptions DEPRECATED_MSG_ATTRIBUTE("use baseMapper:withModelToLAJSONExceptions:");
+ (instancetype)mapperFromUnderscoreCaseToCamelCase DEPRECATED_MSG_ATTRIBUTE("use mapperForSnakeCase:");
+ (instancetype)mapperFromUpperCaseToLowerCase DEPRECATED_ATTRIBUTE;

/** @name Name converters */
/** Block, which takes in a property name and converts it to the corresponding LAJSON key name */
@property (readonly, nonatomic) LAJSONModelKeyMapBlock modelToLAJSONKeyBlock;

/** Combined converter method
 * @param value the source name
 * @return LAJSONKeyMapper instance
 */
- (NSString *)convertValue:(NSString *)value;

/** @name Creating a key mapper */

/**
 * Creates a LAJSONKeyMapper instance, based on the block you provide this initializer.
 * The parameter takes in a LAJSONModelKeyMapBlock block:
 * <pre>NSString *(^LAJSONModelKeyMapBlock)(NSString *keyName)</pre>
 * The block takes in a string and returns the transformed (if at all) string.
 * @param toLAJSON transforms your model property name to a LAJSON key
 */
- (instancetype)initWithModelToLAJSONBlock:(LAJSONModelKeyMapBlock)toLAJSON;

/**
 * Creates a LAJSONKeyMapper instance, based on the mapping you provide.
 * Use your LAJSONModel property names as keys, and the LAJSON key names as values.
 * @param toLAJSON map dictionary, in the format: <pre>@{@"myCamelCaseName":@"crazy_LAJSON_name"}</pre>
 * @return LAJSONKeyMapper instance
 */
- (instancetype)initWithModelToLAJSONDictionary:(NSDictionary <NSString *, NSString *> *)toLAJSON;

/**
 * Given a camelCase model property, this mapper finds LAJSON keys using the snake_case equivalent.
 */
+ (instancetype)mapperForSnakeCase;

/**
 * Given a camelCase model property, this mapper finds LAJSON keys using the TitleCase equivalent.
 */
+ (instancetype)mapperForTitleCase;

/**
 * Creates a LAJSONKeyMapper based on a built-in LAJSONKeyMapper, with specific exceptions.
 * Use your LAJSONModel property names as keys, and the LAJSON key names as values.
 */
+ (instancetype)baseMapper:(LAJSONKeyMapper *)baseKeyMapper withModelToLAJSONExceptions:(NSDictionary *)toLAJSON;

@end
