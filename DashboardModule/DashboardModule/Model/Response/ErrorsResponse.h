//
//  ErrorResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@interface ErrorsResponse: ResponseObject

@property (nonatomic, strong) NSNumber<Optional>* Code;
@property (nonatomic, strong) NSString<Optional>* Key;
@property (nonatomic, strong) NSString<Optional>* Message;

@end
