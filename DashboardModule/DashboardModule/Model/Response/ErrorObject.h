//
//  ErrorObject.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 13.02.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@protocol ErrorObject;

@interface ErrorObject: NSMutableArray

@property (nonatomic, strong) NSString<Optional>* Key;
@property (nonatomic, strong) NSString<Optional>* Message;

@end
