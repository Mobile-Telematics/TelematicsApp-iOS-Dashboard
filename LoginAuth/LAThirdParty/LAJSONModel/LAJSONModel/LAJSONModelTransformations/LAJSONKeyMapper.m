//
//  LAJSONKeyMapper.m
//  LAJSONModel
//

#import "LAJSONKeyMapper.h"

@implementation LAJSONKeyMapper

- (instancetype)initWithLAJSONToModelBlock:(LAJSONModelKeyMapBlock)toModel modelToLAJSONBlock:(LAJSONModelKeyMapBlock)toLAJSON
{
    return [self initWithModelToLAJSONBlock:toLAJSON];
}

- (instancetype)initWithModelToLAJSONBlock:(LAJSONModelKeyMapBlock)toLAJSON
{
    if (!(self = [self init]))
        return nil;

    _modelToLAJSONKeyBlock = toLAJSON;

    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)map
{
    NSDictionary *toLAJSON  = [LAJSONKeyMapper swapKeysAndValuesInDictionary:map];

    return [self initWithModelToLAJSONDictionary:toLAJSON];
}

- (instancetype)initWithModelToLAJSONDictionary:(NSDictionary <NSString *, NSString *> *)toLAJSON
{
    if (!(self = [super init]))
        return nil;

    _modelToLAJSONKeyBlock = ^NSString *(NSString *keyName)
    {
        return [toLAJSON valueForKeyPath:keyName] ?: keyName;
    };

    return self;
}

- (LAJSONModelKeyMapBlock)LAJSONToModelKeyBlock
{
    return nil;
}

+ (NSDictionary *)swapKeysAndValuesInDictionary:(NSDictionary *)dictionary
{
    NSArray *keys = dictionary.allKeys;
    NSArray *values = [dictionary objectsForKeys:keys notFoundMarker:[NSNull null]];

    return [NSDictionary dictionaryWithObjects:keys forKeys:values];
}

- (NSString *)convertValue:(NSString *)value isImportingToModel:(BOOL)importing
{
    return [self convertValue:value];
}

- (NSString *)convertValue:(NSString *)value
{
    return _modelToLAJSONKeyBlock(value);
}

+ (instancetype)mapperFromUnderscoreCaseToCamelCase
{
    return [self mapperForSnakeCase];
}

+ (instancetype)mapperForSnakeCase
{
    return [[self alloc] initWithModelToLAJSONBlock:^NSString *(NSString *keyName)
    {
        NSMutableString *result = [NSMutableString stringWithString:keyName];
        NSRange range;

        // handle upper case chars
        range = [result rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]];
        while (range.location != NSNotFound)
        {
            NSString *lower = [result substringWithRange:range].lowercaseString;
            [result replaceCharactersInRange:range withString:[NSString stringWithFormat:@"_%@", lower]];
            range = [result rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]];
        }

        // handle numbers
        range = [result rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
        while (range.location != NSNotFound)
        {
            NSRange end = [result rangeOfString:@"\\D" options:NSRegularExpressionSearch range:NSMakeRange(range.location, result.length - range.location)];

            // spans to the end of the key name
            if (end.location == NSNotFound)
                end = NSMakeRange(result.length, 1);

            NSRange replaceRange = NSMakeRange(range.location, end.location - range.location);
            NSString *digits = [result substringWithRange:replaceRange];
            [result replaceCharactersInRange:replaceRange withString:[NSString stringWithFormat:@"_%@", digits]];
            range = [result rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet] options:0 range:NSMakeRange(end.location + 1, result.length - end.location - 1)];
        }

        return result;
    }];
}

+ (instancetype)mapperForTitleCase
{
    return [[self alloc] initWithModelToLAJSONBlock:^NSString *(NSString *keyName)
    {
        return [keyName stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[keyName substringToIndex:1].uppercaseString];
    }];
}

+ (instancetype)mapperFromUpperCaseToLowerCase
{
    return [[self alloc] initWithModelToLAJSONBlock:^NSString *(NSString *keyName)
    {
        return keyName.uppercaseString;
    }];
}

+ (instancetype)mapper:(LAJSONKeyMapper *)baseKeyMapper withExceptions:(NSDictionary *)exceptions
{
    NSDictionary *toLAJSON = [LAJSONKeyMapper swapKeysAndValuesInDictionary:exceptions];

    return [self baseMapper:baseKeyMapper withModelToLAJSONExceptions:toLAJSON];
}

+ (instancetype)baseMapper:(LAJSONKeyMapper *)baseKeyMapper withModelToLAJSONExceptions:(NSDictionary *)toLAJSON
{
    return [[self alloc] initWithModelToLAJSONBlock:^NSString *(NSString *keyName)
    {
        if (!keyName)
            return nil;

        if (toLAJSON[keyName])
            return toLAJSON[keyName];

        return baseKeyMapper.modelToLAJSONKeyBlock(keyName);
    }];
}

@end
