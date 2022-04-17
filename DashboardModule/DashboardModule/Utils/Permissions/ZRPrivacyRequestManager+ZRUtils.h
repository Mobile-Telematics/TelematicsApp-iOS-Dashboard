//
//  ZRPrivacyRequestManager+ZRUtils.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRPrivacyRequestManager.h"

@interface ZRPrivacyRequestManager (ZRUtils)
+ (void)ZR_storeAuthorizationStatus:(ZRAuthorizationStatus)status forType:(ZRPrivacyType)type;
+ (ZRAuthorizationStatus)ZR_authorizationStatusFromUserDefault:(ZRPrivacyType)type;
@end
