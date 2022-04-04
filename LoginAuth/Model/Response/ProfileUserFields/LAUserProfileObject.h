//
//  LAUserProfileObject.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"

@protocol LAUserProfileObject;

@interface LAUserProfileObject: LAResponseObject

@property (nonatomic, strong) NSString<Optional>* FirstName;
@property (nonatomic, strong) NSString<Optional>* LastName;
@property (nonatomic, strong) NSString<Optional>* Gender;
@property (nonatomic, strong) NSString<Optional>* Birthday;
@property (nonatomic, strong) NSString<Optional>* MaritalStatus;
@property (nonatomic, strong) NSNumber<Optional>* ChildrenCount;
@property (nonatomic, strong) NSString<Optional>* Address;
@property (nonatomic, strong) NSString<Optional>* Country;
@property (nonatomic, strong) NSString<Optional>* District;
@property (nonatomic, strong) NSString<Optional>* City;
@property (nonatomic, strong) NSString<Optional>* Nickname;
@property (nonatomic, strong) NSString<Optional>* Email;
@property (nonatomic, strong) NSString<Optional>* Phone;
@property (nonatomic, strong) NSString<Optional>* ImageUrl;

@end
