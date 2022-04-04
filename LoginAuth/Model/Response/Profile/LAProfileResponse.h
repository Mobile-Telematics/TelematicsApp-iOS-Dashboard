//
//  LAProfileResponse.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "LAProfileResultResponse.h"

@class LAProfileResultResponse;

@interface LAProfileResponse: LARootResponse

@property (nonatomic, strong) LAProfileResultResponse<Optional>* Result;

@end
