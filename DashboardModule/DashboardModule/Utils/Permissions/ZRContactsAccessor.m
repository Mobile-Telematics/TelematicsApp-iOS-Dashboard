//
//  ZRContactsAccessor.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRContactsAccessor.h"
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
#import <Contacts/Contacts.h>
#endif
@implementation ZRContactsAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    if (@available(iOS 9.0, *)) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusNotDetermined:
                return ZRAuthorizationStatusNotDetermined;
            case CNAuthorizationStatusRestricted:
                return ZRAuthorizationStatusRestricted;
            case CNAuthorizationStatusDenied:
                return ZRAuthorizationStatusDenied;
            case CNAuthorizationStatusAuthorized:
                return ZRAuthorizationStatusAuthorized;
        }
    } else {
        return ZRAuthorizationStatusNotSupportForLowerOSVersion;
    }
}


- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    if (@available(iOS 9.0, *)) {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                ZRAuthorizationStatus status = [ZRContactsAccessor authorizationStatus];
                handler(status);
            });
        }];
    } else {
        handler(ZRAuthorizationStatusNotSupportForLowerOSVersion);
    }
}

@end
