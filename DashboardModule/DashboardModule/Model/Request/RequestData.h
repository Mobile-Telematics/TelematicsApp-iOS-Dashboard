//
//  RequestData.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 24.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface RequestData: JSONModel

- (NSDictionary* _Nonnull)paramsDictionary;
- (NSArray<NSString *> * _Nullable)validateCheckEmail;
- (NSArray<NSString *> * _Nullable)validateCheckNewUserEmail;
- (NSArray<NSString *> * _Nullable)validateCheckPhone;
- (NSArray<NSString *> * _Nullable)validateNewPassword;
- (NSArray<NSString *> * _Nullable)validateCheckPasswordForUserLogin;
- (NSArray<NSString *> * _Nullable)validateCheckVin;
- (NSArray<NSString *> * _Nullable)validate;

@end
