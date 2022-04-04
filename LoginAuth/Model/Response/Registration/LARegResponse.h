//
//  LARegResponse.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "LARegResultResponse.h"

@class LARegResultResponse;

@interface LARegResponse: LAResponseObject

@property (nonatomic, strong) LARegResultResponse<Optional>* Result;

@end
