//
//  ZRCoordinator.m
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 28.10.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

#import "ZRCoordinator.h"

@implementation ZRCoordinator

+ (void)saveAppCoreDataContext {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (success) {
            NSLog(@"You successfully saved your context.");
        } else if (error) {
            NSLog(@"Error saving context: %@", error.description);
        }
    }];
}

+ (void)saveAppCoreDataContextArrays {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

+ (void)saveAppCoreDataContextArraysTest {
    
//    [MagicalRecord saveInBackgroundWithBlock:^(NSManagedObjectContext *context) {
//    for (NSDictionary *project in projects)
//    {
//    [WRPProject importFromObject:project inContext:context];
//    }
//    }
//    completion:^{
//    if (completion)
//    completion();
//    }];
}

@end
