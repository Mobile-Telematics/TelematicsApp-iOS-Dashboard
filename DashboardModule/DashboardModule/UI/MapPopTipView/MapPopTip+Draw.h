//
//  MapPopTip+Draw.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.09.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "MapPopTip.h"

@interface MapPopTip (Draw)

- (nonnull UIBezierPath *)pathWithRect:(CGRect)rect direction:(MapPopTipDirection)direction;

@end
