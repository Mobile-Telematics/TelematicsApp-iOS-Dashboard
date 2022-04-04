//
//  LAProfileResultResponse.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"
#import "LAUserProfileObject.h"

@interface LAProfileResultResponse: LAResponseObject


@property (nonatomic, strong) LAUserProfileObject<Optional>* UserProfile;
@property (nonatomic, strong) NSArray<Optional>* UserFields;

@property (nonatomic, strong) NSNumber<Optional>* UserId;
@property (nonatomic, strong) NSString<Optional>* Name;
@property (nonatomic, strong) NSString<Optional>* FamilyName;
@property (nonatomic, strong) NSString<Optional>* Nickname;
@property (nonatomic, strong) NSString<Optional>* Email;
@property (nonatomic, strong) NSString<Optional>* Phone;
@property (nonatomic, strong) NSString<Optional>* MobileUid;
@property (nonatomic, strong) NSString<Optional>* MobileName;
@property (nonatomic, strong) NSString<Optional>* MobileOsType;
@property (nonatomic, strong) NSString<Optional>* MobileOsVersion;
@property (nonatomic, strong) NSString<Optional>* SdkVersion;
@property (nonatomic, strong) NSString<Optional>* AppVersion;
@property (nonatomic, strong) NSString<Optional>* Language;
@property (nonatomic, strong) NSString<Optional>* Image;
@property (nonatomic, strong) NSString<Optional>* Gender;
@property (nonatomic, strong) NSString<Optional>* Birthday;
@property (nonatomic, strong) NSString<Optional>* ReferralLink;
@property (nonatomic, strong) NSString<Optional>* Address;
@property (nonatomic, strong) NSString<Optional>* Marital;
@property (nonatomic, strong) NSNumber<Optional>* ChildrenCount;

@end
