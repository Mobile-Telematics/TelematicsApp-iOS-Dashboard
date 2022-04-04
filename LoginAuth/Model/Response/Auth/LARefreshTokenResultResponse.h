//
//  LARefreshTokenResultResponse.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"
#import "LAAccessTokenObject.h"

@interface LARefreshTokenResultResponse: LAResponseObject

@property (nonatomic, strong) NSString<Optional>* DeviceToken;
@property (nonatomic, strong) NSString<Optional>* RefreshToken;
@property (nonatomic, strong) LAAccessTokenObject<Optional>* AccessToken;

@end
