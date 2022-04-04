//
//  LAResponseObject.m
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"
#import "LAJSONModelLib.h"

@interface LAResponseObject: LAJSONModel

@property (nonatomic, copy) NSString<Optional>* Title;
@property (nonatomic, copy) NSString<Optional>* Status;
@property (nonatomic, copy) NSArray<Optional>* Errors;

- (BOOL)isSuccesful;

- (NSArray*)validate;

@end
