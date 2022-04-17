//
//  EcoIndividualResponse.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 03.11.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "RootResponse.h"
#import "EcoIndividualResultResponse.h"

@interface EcoIndividualResponse: RootResponse

@property (nonatomic, strong) EcoIndividualResultResponse<Optional>* Result;

@end
