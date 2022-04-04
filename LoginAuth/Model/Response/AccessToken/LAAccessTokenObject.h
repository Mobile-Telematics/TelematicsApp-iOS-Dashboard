//
//  LAAccessTokenObject.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"

@protocol LAAccessTokenObject;

@interface LAAccessTokenObject: LAResponseObject

@property (nonatomic, strong) NSString<Optional>* Token;
@property (nonatomic, strong) NSString<Optional>* ExpiresIn;

@end
