# DashboardModule for iOS

![](https://img.shields.io/badge/version-1.0-blue) ![](https://img.shields.io/badge/release-blueviolet) ![](https://img.shields.io/badge/easyinuse-release) ![](https://img.shields.io/badge/AppStore-ready-important)

## Description

DashboardModule is created by DATA MOTION PTE. LTD. and allows you to integrate with our UserService API & Indicators API in a few steps. DashboardModule allows you to embed a complete Dashboard screen into your app, and provide the user with all the detailed statistics based on their detailed statistics and trips.

DashboardModule has three main functions:
1. Creating `deviceToken` for each new Telematics SDK user.
2. Refeshing the `jwToken` when it is expired.
3. Geting `jwToken` for existing SDK User.
4. Provides out-of-the-box Dashboard UI access for your app.


## Credentials

Before you start, make sure you registered a company account in the [Datahub](https://userdatahub.com/) and obtained `InstanceId` and`InstanceKey`. If you are new, please refer to the [documentation](doc.telematicssdk.com) and register your company account in Datahub. [Sing Up](https://userdatahub.com/user/registration)


## DashboardModule setup

The DashboardModule works closely with the `LoginAuth.xcframework`, which organizes the interaction to receive `deviceToken`, `jwToken`, `refreshToken`. 

`deviceToken` - is the main individual SDK user identifier for your app. this identifier is used as a key across all our services.

`jwToken` - or JSON Web Token (JWT) is the main UserService API key, that allows you to get user individual statistics and user scorings by UserService APIs calls.

`refreshToken` - is a secret key that allows you to refresh the `jwToken` when it expires.

More information can be found in this `LoginAuth.xcframework` [repository](https://github.com/Mobile-Telematics/LoginAuthFramework-iOS).

To integrate DashboardModule, you need to perform a few simple steps:

Step 1: Download demo project from this repository. Inside you will see the `DashboardModule` folder. You can copy this folder to your project. Thus, by making a call from your application, you can call the Dashboard:

    UIViewController* rootVc = [[UIStoryboard storyboardWithName:@"DashboardMain" bundle:nil] instantiateInitialViewController];
    [UIView transitionWithView:self.window duration:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.window.rootViewController = rootVc;
    } completion:nil];

![](https://github.com/Mobile-Telematics/TelematicsApp-iOS-Dashboard/raw/master/img_readme/dashboardmodule.png)

Step 2: Copy `LoginAuth.xcframework` to your iOS project folder where the rest of your project files are located.

Step 3: Open your project in xCode.

Step 4: Go to the first General tab of your project, select your Target.

Step 5: Scroll down to the "Frameworks, Libraries and Embeddeed Content" section.

Step 6: Drag&Drop`LoginAuth.xcframework` from Finder project folder to this section, OR click the "Plus" button below, and select "Add Other" and manually specify the path to the `LoginAuth.xcframework` location.

![](https://github.com/Mobile-Telematics/LoginAuthFramework-iOS/raw/master/images/al.png)

Step 7: Add in header AppDelegate.h (or any file need for you) of your project this line `#import <LoginAuth/LoginAuth.h>`

Step 8: You must run the `pod install` command and install the dependencies required for the DashboardModule to work, the same as in this demo application.

    pod 'RaxelPulse', '5.16'
    pod 'AFNetworking'
    pod 'JSONModel'
    pod 'HEREMaps'
    pod 'GKImagePicker@robseward'
    pod 'TTTLocalizedPluralString'
    pod 'SAMKeychain'
    pod 'SystemServices'
    pod 'UICountingLabel'
    pod 'UIActionSheet+Blocks'
    pod 'UIAlertView+Blocks'
    pod 'CMTabbarView'
    pod 'DLRadioButton'
    pod 'YYWebImage'
    pod 'SHSPhoneComponent'
    pod "IQDropDownTextField"
    pod "IQMediaPickerController"
    pod 'libPhoneNumber-iOS', '~> 0.8'
    pod 'KDLoadingView'
    pod "RMessage", '~> 2.3.0'
    pod 'CircleTimer', '0.2.0'
    pod 'MagicalRecord', :git => 'https://github.com/magicalpanda/MagicalRecord'

Step 9: You will need an HEREMaps API key's to display a preview of the last trip on the map. After creating your HERE account, open your project in https://developer.here.com/projects 
In the REST table click "Generate App".

![](https://github.com/Mobile-Telematics/TelematicsApp-iOS-Dashboard/raw/master/img_readme/here_step_1.png)

Step 10: Click "Create API key"

![](https://github.com/Mobile-Telematics/TelematicsApp-iOS-Dashboard/raw/master/img_readme/here_step_2.png)
Step 11: Enloy!

## Methods
### Create DeviceToken

Each SDK user has to have a `deviceToken` and be associated with the app users. To create `deviceToken` please use the method below. To complete a call, you are required to provide `instanceId` & `instanceKey`. If you still have quiestions on how to obtain the credentails, please refer to the [documentation](https://dev.telematicssdk.com/docs/datahub#user-service-credentials)

Objective-C

     [[LoginAuthCore sharedManager] createDeviceTokenForUserWithInstanceId:@"instanceId"
                                                               instanceKey:@"instanceKey"
                                                                    result:^(NSString *deviceToken, NSString *jwToken, NSString *refreshToken) {
        NSLog(@"LoginAuthResponce deviceToken %@", deviceToken);
        NSLog(@"LoginAuthResponce jwToken %@", jwToken);
        NSLog(@"LoginAuthResponce refreshToken %@", refreshToken);
    }];

Swift

     LoginAuthCore.sharedManager()?.createDeviceTokenForUser(withInstanceId: "instanceId",
                                                                instanceKey: "instanceKey",
                                                                result: { (deviceToken, jwToken, refreshToken) in
            print("Success Create User")
    })

Once user is registered, you will receive the user credentails. make sure you pass the `deviceToken` to your server and store it against a user profile, then pass it to your App - this is the main user detials that you will use for our services.


### Refresh JWT

Each `JWTtoken` has a limmited lifetime and in a certain period of time it is expired. As a result, when you call our API using invalid `JWTtoken` you will receive an Error `Unauthorized 401`.
**Error 401** indicates that the user's `JWTtoken` has been expired. If so, as the first step, you have to update the `JWToken`.

To update the `JWTtoken`, you are required to provide the latest `JWTtoken` & `refreshToken` to the method below.

Objective-C

    [[LoginAuthCore sharedManager] refreshJWTokenForUserWith:@"jwToken"
                                                refreshToken:@"refreshToken"
                                                      result:^(NSString *newJWToken, NSString *newRefreshToken) {

        NSLog(@"NEW jwToken %@", newJWToken);
        NSLog(@"NEW refreshToken %@", newRefreshToken);
    }];

Swift

    LoginAuthCore.sharedManager()?.refreshJWTokenForUser(with: "jwToken",
                                                             refreshToken: "refreshToken",
                                                             result: { (newJWToken, newRefreshToken) in
            print("Success Refresh jwToken & refreshToken")
    })
In response you will receive new `JWTtokens`.


### Get JWT for existing SDK users

During the app usage, there may be several scenarios when the app loses `JWTtoken`, for example if the a user changes a smartphone or logs out. BTW, that is a reason why we strongly recommend you to store the `deviceToken` on your backend side. `deviceToken` cannot be restored if it is lost!

We provide you with a simple re-authorization, a method that you can use to get a valid `JWTtoken` for a particular user throught providing `DeviceToken`
To use this mehod, you need `deviceToken`, `instanceId`, and `instanceKey` of which group the user belongs. in this case, `Devicetoken` works as a login, `instancekey` as a password. Then you can re-login the user and get a valid `JWTtoken` & `refreshToken`.

Objective-C

    [[LoginAuthCore sharedManager] getJWTokenForUserWithDeviceToken:@"deviceToken"
                                                         instanceId:@"instanceId"
                                                        instanceKey:@"instanceKey"
                                                             result:^(NSString *jwToken, NSString *refreshToken) {
        NSLog(@"NEW JWT by DEVICETOKEN %@", jwToken);
        NSLog(@"NEW REFRESHTOKEN by DEVICETOKEN %@", refreshToken);
    }];

Swift

    LoginAuthCore.sharedManager()?.getJWTokenForUser(withDeviceToken: "deviceToken",
                                                         instanceId: "instanceId",
                                                         instanceKey: "instanceKey",
                                                         result: { (jwToken, refreshToken) in
            print("Success Getting New jwToken & refreshToken by DeviceToken")
    })

In response, you will receive a new `jwToken` and `refreshToken`.

## Additional methods
### Create DeviceToken with Parameters

Additionally, you can create a user's `deviceToken` and get the necessary keys (`JWTtoken`, `refreshToken` ) with additional parameters. This is not a required method, it just allows you to store the user profile in a different way. You can specify the below given parameters when creating a user's deviceToken:
- userEmail
- userPhone
- firstName
- lastName
- address
- birthday
- gender
- maritalStatus
- childrenCount
- clientId

Objective-C

    [[LoginAuthCore sharedManager] createDeviceTokenForUserWithParametersAndInstanceId:@"instanceId"
                                                                           instanceKey:@"instanceKey"
                                                                                 email:@"mail@mail.mail"
                                                                                 phone:@"+10000000000"
                                                                             firstName:@"TELEMATICS_USERNAME"
                                                                              lastName:@"TELEMATICS_LASTNAME"
                                                                               address:@"CITY"
                                                                              birthday:@""
                                                                                gender:@"Male"    // String Male/Female
                                                                         maritalStatus:@"1"       // String 1/2/3/4 = "Married"/"Widowed"/"Divorced"/"Single"
                                                                         childrenCount:@0         // int 1-10
                                                                              clientId:@"idOptional" result:^(NSString *deviceToken, NSString *jwToken, NSString *refreshToken) {
        NSLog(@"UserServiceResponce deviceToken %@", deviceToken);
        NSLog(@"UserServiceResponce jwToken %@", jwToken);
        NSLog(@"UserServiceResponce refreshToken %@", refreshToken);
    }];

    
    

You can always request information about the user profile anytime:

    [[LoginAuthCore sharedManager] getUserProfileWithInstanceId:@"instanceId"
                                                    instanceKey:@"instanceKey"
                                                        jwToken:@"jwToken" result:^(NSString *email, NSString *phone, NSString *firstName, NSString *lastName, NSString *address, NSString *birthday, NSString *gender, NSString *maritalStatus, NSString *childrenCount, NSString *clientId) {
        NSLog(@"Success fetch user profile");
        //
    }];
    
And also, update the user profile with the following method:

    [[LoginAuthCore sharedManager] updateUserProfileWithParametersAndInstanceId:@"instanceId"
                                                                    instanceKey:@"instanceKey"
                                                                        jwToken:@"jwToken"
                                                                          email:@"mail@mail.mail"
                                                                          phone:@"+10000000000"
                                                                      firstName:@"TELEMATICS_USERNAME"
                                                                       lastName:@"TELEMATICS_LASTNAME"
                                                                        address:@"NEWCITY"
                                                                       birthday:@""
                                                                         gender:@"Male"  // String Male/Female
                                                                  maritalStatus:@"1"  // String 1/2/3/4 = "Married"/"Widowed"/"Divorced"/"Single"
                                                                  childrenCount:@5    // int 1-10
                                                                       clientId:@"idOptionalNew" result:^(NSString *result) {
        NSLog(@"Success update user profile");
    }];
Happy coding!


## Links

[Official product Web-page](https://telematicssdk.com/)

[Official API services web-page](https://www.telematicssdk.com/api-services/)

[Official SDK and API references](https://www.telematicssdk.com/api-services/)

[Official ZenRoad web-page](https://www.telematicssdk.com/telematics-app/)

[Official ZenRoad app for iOS](https://apps.apple.com/jo/app/zenroad/id1563218393)

[Official ZenRoad app for Android](https://play.google.com/store/apps/details?id=com.telematicssdk.zenroad&hl=en&gl=US)

[Official ZenRoad app for Huawei](https://appgallery.huawei.com/#/app/C104163115)

###### Copyright © 2020-2022 DATA MOTION PTE. LTD. All rights reserved.



