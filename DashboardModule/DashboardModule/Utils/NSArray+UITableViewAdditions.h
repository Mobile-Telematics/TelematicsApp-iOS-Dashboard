//
//  NSArray+UITableViewAdditions.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 09.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import Foundation;

@interface NSArray (UITableViewAdditions)

- (NSArray *)sectionsGroupedByKeyPath:(NSString *)keyPath;
- (NSArray *)sectionsGroupedByKeyPath:(NSString *)keyPath ascending:(BOOL)ascending;

@end
