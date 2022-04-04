//
//  LARefreshTokenRequestData.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARequestData.h"

@interface LARefreshTokenRequestData: LARequestData

@property (nonatomic, copy) NSString<Optional>* accessToken;
@property (nonatomic, copy) NSString<Optional>* refreshToken;

@end
