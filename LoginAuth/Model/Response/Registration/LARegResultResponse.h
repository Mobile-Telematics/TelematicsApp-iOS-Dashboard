//
//  LARegResultResponse.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"
#import "LAAccessTokenObject.h"

@interface LARegResultResponse: LAResponseObject

@property (nonatomic, strong) NSString<Optional>* DeviceToken;
@property (nonatomic, strong) NSString<Optional>* RefreshToken;
@property (nonatomic, strong) LAAccessTokenObject<Optional>* AccessToken;

@property (nonatomic, strong) NSString<Optional>* ConfirmationResult;

@end
