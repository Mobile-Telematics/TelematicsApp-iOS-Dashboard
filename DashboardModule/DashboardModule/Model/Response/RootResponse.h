//
//  RootResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"
#import "ErrorsResponse.h"

@interface RootResponse: ResponseObject

@property (nonatomic, copy) ErrorsResponse<Optional>* Errors;

- (__kindof ResponseObject<Optional>*)Result;

@end
