//
//  LAResponseObject.m
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"
#import "LAJSONModelClassProperty.h"

@implementation LAResponseObject

- (BOOL)isSuccesful {
    return YES;
}

- (NSArray*)validate {
    return nil;
}

+ (LAJSONKeyMapper *)keyMapper {
    return [[LAJSONKeyMapper alloc] initWithModelToLAJSONDictionary:@{@"id":@"objectId",
                                                                      @"description":@"objectDescription",
                                                                      }];
}

@end
