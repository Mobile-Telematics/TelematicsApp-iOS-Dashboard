//
//  BaseViewController.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 12.01.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import UIKit;
#import "APIErrorHandler.h"
#import <RMessage/RMessage.h>
#import <GKImagePicker_robseward/GKImagePicker.h>
#import <SafariServices/SafariServices.h>

@interface BaseViewController: UIViewController <GKImagePickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SFSafariViewControllerDelegate>

@property (nonatomic, strong, nullable) IBOutlet UIScrollView*      keyboardAvoidingScrollView;
@property (nonatomic, strong, nullable) APIErrorHandler*            errorHandler;
@property (nonatomic, strong, nullable) GKImagePicker*              imagePicker;
@property (assign, nonatomic) BOOL                                  needDisplayGPSAlert;
@property (readonly, nonatomic) BOOL                                hidesBackgroundImage;

+ (NSString* __nonnull)storyboardIdentifier;

- (void)showMessageWithTitle:(NSString* __nullable)title subTitle:(NSString* __nullable)subTitle type:(RMessageType)type;
- (void)showImagePicker;
- (void)chatWithUser:(NSString* _Nonnull)email name:(NSString* _Nonnull)name;
- (void)setViewsHidden:(BOOL)hidden;

@end
