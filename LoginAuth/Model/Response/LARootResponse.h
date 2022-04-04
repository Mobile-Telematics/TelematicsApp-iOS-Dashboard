//
//  LARootResponse.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"
#import "LAErrorsResponse.h"

@interface LARootResponse: LAResponseObject

@property (nonatomic, copy) LAErrorsResponse<Optional>* Errors;

- (__kindof LAResponseObject<Optional>*)Result;

@end
