//
//  UserProfileObject.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 27.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@protocol UserProfileObject;

@interface UserProfileObject: ResponseObject

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
