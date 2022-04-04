//
//  LAProfileRequestData.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LARequestData.h"

@interface LAProfileRequestData: LARequestData

@property (nonatomic, copy) NSString<Optional>* email;
@property (nonatomic, copy) NSString<Optional>* phone;
@property (nonatomic, copy) NSString<Optional>* firstName;
@property (nonatomic, copy) NSString<Optional>* lastName;
@property (nonatomic, copy) NSString<Optional>* nickname;
@property (nonatomic, copy) NSString<Optional>* gender;
@property (nonatomic, copy) NSString<Optional>* birthday;
@property (nonatomic, copy) NSString<Optional>* maritalStatus;
@property (nonatomic, copy) NSNumber<Optional>* childrenCount;
@property (nonatomic, copy) NSString<Optional>* country;
@property (nonatomic, copy) NSString<Optional>* district;
@property (nonatomic, copy) NSString<Optional>* city;
@property (nonatomic, copy) NSString<Optional>* address;
@property (nonatomic, copy) NSString<Optional>* status;
@property (nonatomic, copy) NSDictionary<Optional>* UserFields;

@property (nonatomic, copy) NSString<Optional>* Image;
@property (nonatomic, copy) NSString<Optional>* MobileUid;
@property (nonatomic, copy) NSString<Optional>* MobileName;
@property (nonatomic, copy) NSString<Optional>* MobileOsType;
@property (nonatomic, copy) NSString<Optional>* MobileOsVersion;
@property (nonatomic, copy) NSString<Optional>* OldPassword;
@property (nonatomic, copy) NSString<Optional>* NewPassword;
@property (nonatomic, copy) NSString<Optional>* SendVerificationCodeForEmailPhone;

@end
