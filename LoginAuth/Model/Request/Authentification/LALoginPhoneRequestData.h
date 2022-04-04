//
//  LALoginPhoneRequestData.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARequestData.h"
#import "LALoginPhoneRequestObject.h"

@interface LALoginPhoneRequestData: LARequestData

@property (nonatomic, copy) NSString<Optional>* password;
@property (nonatomic, copy) NSDictionary<Optional>* loginFields;

@end
