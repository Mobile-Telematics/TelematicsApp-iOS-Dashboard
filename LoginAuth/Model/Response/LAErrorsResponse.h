//
//  LAErrorResponse.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"

@interface LAErrorsResponse: LAResponseObject

@property (nonatomic, strong) NSNumber<Optional>* Code;
@property (nonatomic, strong) NSString<Optional>* Key;
@property (nonatomic, strong) NSString<Optional>* Message;

@end
