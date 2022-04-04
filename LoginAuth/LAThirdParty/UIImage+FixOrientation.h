//
//  UIImage+FixOrientation.h
//  Damoov ZenRoad Telematics Platform
//
//  Created by pp@datamotion.ai on 09.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;

@interface UIImage (FixOrientation)

- (UIImage *)fixOrientation;
+ (UIImage *)imageWithImageHelper:(UIImage *)image scale:(CGFloat)scale;
+ (NSData *)scaleImage:(UIImage*)image;
+ (NSData *)scaleImageForAvatar:(UIImage*)image;

@end
