//
//  ResponseObject.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"
#import "JSONModel.h"
//#import "ErrorObject.h"

@interface ResponseObject: JSONModel

@property (nonatomic, copy) NSString<Optional>* Title;
@property (nonatomic, copy) NSString<Optional>* Status;
@property (nonatomic, copy) NSArray<Optional>*  Errors;

- (BOOL)isSuccesful;

- (NSArray*)validate;

@end
