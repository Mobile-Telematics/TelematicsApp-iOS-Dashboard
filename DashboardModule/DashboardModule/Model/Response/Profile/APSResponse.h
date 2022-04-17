//
//  APSResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 16.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ResponseObject.h"

@interface APSResponse: ResponseObject

@property (nonatomic, copy) NSString<Optional>* alert;
@property (nonatomic, copy) NSString<Optional>* sound;

@end
