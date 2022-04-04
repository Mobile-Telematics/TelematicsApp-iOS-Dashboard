//
//  ZRAddressBookAccessor.m
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 04.12.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRAddressBookAccessor.h"
#import "ZRContactsAccessor.h"
#import <AddressBook/AddressBook.h>


@implementation ZRAddressBookAccessor
+ (ZRAuthorizationStatus)authorizationStatus {
    if (@available(iOS 9.0, *)) {
        return [ZRContactsAccessor authorizationStatus];
    } else {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        switch (status) {
            case kABAuthorizationStatusNotDetermined:
                return ZRAuthorizationStatusNotDetermined;
            case kABAuthorizationStatusRestricted:
                return ZRAuthorizationStatusRestricted;
            case kABAuthorizationStatusDenied:
                return ZRAuthorizationStatusDenied;
            case kABAuthorizationStatusAuthorized:
                return ZRAuthorizationStatusAuthorized;
        }
    }
}
- (void)requestAuthorization:(ZRRequestAuthorizationHandler)handler {
    if (@available(iOS 9.0, *)) {
        ZRContactsAccessor *contactsAccessor = [[ZRContactsAccessor alloc] init];
        [contactsAccessor requestAuthorization:handler];
    } else {
        CFErrorRef anError = nil;
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &anError);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            NSLog(@"granted:%d, error:%@", granted, error);
            dispatch_async(dispatch_get_main_queue(), ^{
                ZRAuthorizationStatus status = [ZRAddressBookAccessor authorizationStatus];
                handler(status);
            });
        });
        if (addressBook != NULL) {
            NSLog(@"release addressBook");
            CFRelease(addressBook);
        }
    }
}
@end
