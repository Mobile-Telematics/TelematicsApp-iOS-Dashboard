//
//  APIErrorHandler.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import Foundation;

@class UIViewController;
@class RootResponse;

@interface APIErrorHandler : NSObject

@property (nonatomic, weak) UIViewController* viewController;

- (void)handleError:(NSError*)error response:(id)response;
- (void)showErrorMessages:(NSArray<NSString *>*)errors;
- (void)handleSuccess:(RootResponse*)response;
- (void)showErrorNow:(NSString*)message;
- (void)showSuccessNow:(NSString*)message;
- (void)dismissActiveNotifNow;

@end
