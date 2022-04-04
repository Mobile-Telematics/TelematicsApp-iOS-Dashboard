//
//  LARegPhoneRequestData.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARequestData.h"

@interface LARegPhoneRequestData: LARequestData

@property (nonatomic, copy) NSString<Optional>*         password;
@property (nonatomic, copy) NSString<Optional>*         createAccessToken;
@property (nonatomic, copy) NSString<Optional>*         generatePassword;
@property (nonatomic, copy) NSString<Optional>*         firstName;
@property (nonatomic, copy) NSString<Optional>*         lastName;
@property (nonatomic, copy) NSString<Optional>*         nickname;
@property (nonatomic, copy) NSString<Optional>*         phone;
@property (nonatomic, copy) NSString<Optional>*         email;
@property (nonatomic, copy) NSString<Optional>*         gender;
@property (nonatomic, copy) NSString<Optional>*         birthday;
@property (nonatomic, copy) NSString<Optional>*         maritalStatus;
@property (nonatomic, copy) NSNumber<Optional>*         childrenCount;
@property (nonatomic, copy) NSString<Optional>*         address;
@property (nonatomic, copy) NSString<Optional>*         InstanceInviteCode;
@property (nonatomic, copy) NSDictionary<Optional>*     userFields;

@end
