//
//  LAErrorObject.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"

@protocol LAErrorObject;

@interface LAErrorObject: NSMutableArray

@property (nonatomic, strong) NSString<Optional>* Key;
@property (nonatomic, strong) NSString<Optional>* Message;

@end
