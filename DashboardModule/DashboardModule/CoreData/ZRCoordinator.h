//
//  ZRCoordinator.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 28.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
@import Foundation;
#import <MagicalRecord/MagicalRecord.h>

@interface ZRCoordinator: NSObject

+ (void)saveAppCoreDataContext;
+ (void)saveAppCoreDataContextArrays;

@end
