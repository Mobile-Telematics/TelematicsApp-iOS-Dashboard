//
//  ZRPushNotificationAccessor.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRPrivacyRequestManager.h"
@interface ZRPushNotificationAccessor : NSObject<ZRPrivacyAccessor>

+ (void)requestUserNotificationAuthorization:(NSSet<UIUserNotificationCategory *> *)categories
                                     handler:(ZRRequestAuthorizationHandler)handler;

+ (void)requestUNNotificationAuthorization:(NSSet<UNNotificationCategory *> *)categories
                                   handler:(ZRRequestAuthorizationHandler)handler API_AVAILABLE(ios(10.0));
@end
