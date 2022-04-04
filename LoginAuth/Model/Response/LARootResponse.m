//
//  LARootResponse.m
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"

@implementation LARootResponse

- (LAResponseObject<Optional> *)Result {
    return nil;
}

- (BOOL)isSuccesful {
    return self.Result != nil;
}

@end
