//
//  ResponseObject.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"
#import "JSONModelClassProperty.h"

@implementation ResponseObject

- (BOOL)isSuccesful {
    return YES;
}

- (NSArray*)validate {
    return nil;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{@"id":@"objectId",
                                                                  @"description":@"objectDescription",
                                                                  }];
}

@end
