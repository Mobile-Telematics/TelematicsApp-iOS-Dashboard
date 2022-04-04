//
//  ViewController.m
//  DemoLoginAuthApp
//
//  Created by Damoov on 01.09.2021.
//

#import "ViewController.h"
#import <LoginAuth/LoginAuth.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    //Use lines below separately!
    //
    
    //Create deviceToken, jwToken, refreshToken
    //[self show];
    
    
    //Create deviceToken, jwToken, refreshToken with parameters
    //[self createDeviceTokenForUserWithParameters];
    
    
    //Refresh jwToken if you have 401 or 419 error
    //[self refreshJWToken];
    
    
    //Get new jwToken & refreshToken with help of deviceToken
    //[self getJWTokenWithDeviceToken];
    
    
    //Get user profile from UserService API
    //[self getUserProfileFromUserService];
    
    
    //Update user profile in UserService API
    //[self updateUserProfileFromUserService];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [self show];
    
    
    //Get user profile from UserService API
    //[self getUserProfileFromUserService];
    
    
    //Update user profile in UserService API
    //[self updateUserProfileFromUserService];
}


#pragma mark - Create User

- (void)show {
    
    [[LoginAuthCore sharedManager] setCredentials:@"1" accessToken:@"2"];
    
//    [[LoginAuthCore sharedManager] createDeviceTokenForUserWithInstanceId:@"INSERT_YOUR_INSTANCE_ID"
//                                                              instanceKey:@"INSERT_YOUR_INSTANCE_KEY"
//                                                                   result:^(NSString *deviceToken, NSString *jwToken, NSString *refreshToken) {
//        //
//        NSLog(@"LoginAuthResponce deviceToken %@", deviceToken);
//        NSLog(@"LoginAuthResponce jwToken %@", jwToken);
//        NSLog(@"LoginAuthResponce refreshToken %@", refreshToken);
//        //
//    }];
}

- (void)createDeviceTokenForUserWithParameters {
    
    [[LoginAuthCore sharedManager] createDeviceTokenForUserWithParametersAndInstanceId:@"INSERT_YOUR_INSTANCE_ID"
                                                                           instanceKey:@"INSERT_YOUR_INSTANCE_KEY"
                                                                                 email:@"mail@mail.mail"
                                                                                 phone:@"+10000000000"
                                                                             firstName:@"TELEMATICS_USERNAME"
                                                                              lastName:@"TELEMATICS_LASTNAME"
                                                                               address:@"CITY"
                                                                              birthday:@"2020-04-23T'23:59:59-0400"
                                                                                gender:@"Male"    // String Male/Female
                                                                         maritalStatus:@"1"       // String 1/2/3/4 = "Married"/"Widowed"/"Divorced"/"Single"
                                                                         childrenCount:@0         // Number 1-10
                                                                              clientId:@"idOptional" result:^(NSString *deviceToken, NSString *jwToken, NSString *refreshToken) {
        //
        NSLog(@"UserServiceResponce deviceToken %@", deviceToken);
        NSLog(@"UserServiceResponce jwToken %@", jwToken);
        NSLog(@"UserServiceResponce refreshToken %@", refreshToken);
        //
    }];
}


#pragma mark - User jwToken & refresh token

- (void)refreshJWToken {
    
    [[LoginAuthCore sharedManager] refreshJWTokenForUserWith:@"INSERT_USER_JWTOKEN"
                                                refreshToken:@"INSERT_USER_REFRESH_TOKEN"
                                                      result:^(NSString *newJWToken, NSString *newRefreshToken) {
        //
        NSLog(@"NEW jwToken %@", newJWToken);
        NSLog(@"NEW refreshToken %@", newRefreshToken);
        //
    }];
}

- (void)getJWTokenWithDeviceToken {
    
    [[LoginAuthCore sharedManager] getJWTokenForUserWithDeviceToken:@"INSERT_USER_DEVICETOKEN"
                                                         instanceId:@"INSERT_YOUR_INSTANCE_ID"
                                                        instanceKey:@"INSERT_YOUR_INSTANCE_KEY"
                                                             result:^(NSString *jwToken, NSString *refreshToken) {
        //
        NSLog(@"NEW JWT by DEVICETOKEN %@", jwToken);
        NSLog(@"NEW REFRESHTOKEN by DEVICETOKEN %@", refreshToken);
        //
    }];
}


#pragma mark - User Profile

- (void)getUserProfileFromUserService {
    
    [[LoginAuthCore sharedManager] getUserProfileWithInstanceId:@"INSERT_YOUR_INSTANCE_ID"
                                                    instanceKey:@"INSERT_YOUR_INSTANCE_KEY"
                                                        jwToken:@"INSERT_USER_JWTOKEN"
                                                         result:^(NSString *email,
                                                                  NSString *phone,
                                                                  NSString *firstName,
                                                                  NSString *lastName,
                                                                  NSString *address,
                                                                  NSString *birthday,
                                                                  NSString *gender,
                                                                  NSString *maritalStatus,
                                                                  NSNumber *childrenCount,
                                                                  NSString *clientId) {
        //
        NSLog(@"Success fetch user profile");
        //
        
    }];
}

- (void)updateUserProfileFromUserService {
    
    [[LoginAuthCore sharedManager] updateUserProfileWithParametersAndInstanceId:@"INSERT_YOUR_INSTANCE_ID"
                                                                    instanceKey:@"INSERT_YOUR_INSTANCE_KEY"
                                                                        jwToken:@"INSERT_USER_JWTOKEN"
                                                                          email:@"newmail@newmail.newmail"
                                                                          phone:@"+10000000000"
                                                                      firstName:@"TELEMATICS_USERNAME"
                                                                       lastName:@"TELEMATICS_LASTNAME"
                                                                        address:@"CITY"
                                                                       birthday:@"2020-04-23T'23:59:59-0400"
                                                                         gender:@"Male"     // String Male/Female
                                                                  maritalStatus:@"1"        // String 1/2/3/4 = "Married"/"Widowed"/"Divorced"/"Single"
                                                                  childrenCount:@0          // Number 1-10
                                                                       clientId:nil result:^(NSString *result) {
        //
        NSLog(@"Success update user profile");
        //
    }];
}




@end
