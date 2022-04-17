//
//  VisibleBuildConfig.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 03.03.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//


#import <Foundation/Foundation.h>

#define kVisibleBuildConfigChanged  @"kVisibleBuildConfigChanged"

@interface VisibleBuildConfig : NSObject


@property(nonatomic, strong) NSString *configName;

+ (instancetype)sharedInstance;

- (void)setupWithPlist:(NSString *)plistFile;

- (void)setCurrentConfigName:(NSString *)configName;

//Fix to use the build config with Release parameter valued YES. If no Release, use the first.
- (void)setAsRelease;

//Enable left swipe to show build config browser
- (void)enableSwipe;

//Show build config browser
- (void)showConfigBrowser;

//Get value with key from the current build config data
- (id)configValueForKey:(NSString *)key; //[[Configurator sharedInstance] configValueForKey:@"MockDict"];

@end
