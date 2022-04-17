//
//  AccessTokenObject.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 15.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@protocol AccessTokenObject;

@interface AccessTokenObject: ResponseObject

@property (nonatomic, strong) NSString<Optional>* Token;
@property (nonatomic, strong) NSString<Optional>* ExpiresIn;

@end
