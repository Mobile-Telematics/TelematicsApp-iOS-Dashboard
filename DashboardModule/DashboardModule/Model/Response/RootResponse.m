//
//  RootResponse.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"

@implementation RootResponse

- (ResponseObject<Optional> *)Result {
    return nil;
}

- (BOOL)isSuccesful {
    return self.Result != nil;
}

@end
