//
//  UserService.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 20.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import Foundation;
@import UIKit;

@interface UserService: NSObject

@property (nonatomic, assign, readonly) BOOL isLoggedOn;
@property (nonatomic, copy, readonly) NSString* token;
@property (nonatomic, copy, readonly) NSString* expiresIn;
@property (nonatomic, copy, readonly) NSString* refreshToken;
@property (nonatomic, copy, readonly) NSString* virtualDeviceToken;
@property (nonatomic, strong) NSString* claimsToken;

+ (instancetype)sharedService;
- (void)loginWithSecretKeys:(NSString*)deviceToken jwToken:(NSString *)jwToken refreshToken:(NSString *)refreshToken;
- (void)refreshJWToken:(NSString *)jwToken refreshToken:(NSString *)refreshToken;

- (void)logout;
- (void)logout419;

- (void)loadProfile;
- (void)loadMainUserRequests;

- (void)updateInfoProfileUser:(NSString *)email name:(NSString *)name;

@end
