//
//  InfiniteHorizontalLayout.h
//  collectionview
//
//  Created by Stasyuk on 24.06.14.
//  Copyright (c) 2014 fort1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfiniteHorizontalLayout : UICollectionViewFlowLayout

- (CGPoint)preferredContentOffsetForElementAtIndex:(NSInteger)index;
- (void)recenterLayoutIfNeeded;

@end
