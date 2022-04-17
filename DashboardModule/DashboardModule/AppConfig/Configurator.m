//
//  Configurator.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 03.03.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "Configurator.h"
#import <UIKit/UIKit.h>

@implementation Configurator


#pragma mark - App Appearance

+ (void)setAppearance {
    
    [[Configurator sharedInstance] setupWithPlist:@"Configurator"];
    [[Configurator sharedInstance] setCurrentConfigName:@"DashboardModule_Production"];
    
}

@end
