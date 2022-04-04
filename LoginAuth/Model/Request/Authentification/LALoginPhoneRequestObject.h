//
//  LALoginPhoneRequestObject.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"

@protocol LALoginPhoneRequestObject;

@interface LALoginPhoneRequestObject: NSObject

@property (nonatomic, strong) NSString<Optional>* Phone;

@end
