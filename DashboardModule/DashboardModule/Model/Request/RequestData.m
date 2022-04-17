//
//  RequestData.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 24.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RequestData.h"

@implementation RequestData

- (NSDictionary *)paramsDictionary {
    return [self toDictionary];
}

- (NSArray<NSString *> *)validateCheckEmail {
    return nil;
}

- (NSArray<NSString *> *)validateCheckNewUserEmail {
    return nil;
}

- (NSArray<NSString *> *)validateCheckPhone {
    return nil;
}

- (NSArray<NSString *> *)validateNewPassword {
    return nil;
}

- (NSArray<NSString *> *)validateCheckPasswordForUserLogin {
    return nil;
}

- (NSArray<NSString *> *)validateCheckVin {
    return nil;
}

- (NSArray<NSString *> *)validate {
    return nil;
}

@end
