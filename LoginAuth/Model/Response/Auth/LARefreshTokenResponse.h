//
//  LARefreshTokenResponse.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARootResponse.h"
#import "LARefreshTokenResultResponse.h"

@interface LARefreshTokenResponse: LAResponseObject

@property (nonatomic, strong) LARefreshTokenResultResponse<Optional>* Result;

@end
