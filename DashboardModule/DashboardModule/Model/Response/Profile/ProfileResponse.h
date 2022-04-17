//
//  ProfileResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 16.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "ProfileResultResponse.h"

@class ProfileResultResponse;

@interface ProfileResponse: RootResponse

@property (nonatomic, strong) ProfileResultResponse<Optional>* Result;

@end
