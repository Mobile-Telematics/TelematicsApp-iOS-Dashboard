//
//  EcoIndividualResultResponse.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 03.11.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "LAResponseObject.h"

@interface EcoIndividualResultResponse: LAResponseObject

@property (nonatomic, strong) NSNumber<Optional>* EcoScoreFuel;
@property (nonatomic, strong) NSNumber<Optional>* EcoScoreTyres;
@property (nonatomic, strong) NSNumber<Optional>* EcoScoreBrakes;
@property (nonatomic, strong) NSNumber<Optional>* EcoScoreDepreciation;
@property (nonatomic, strong) NSNumber<Optional>* EcoScore;

@end
