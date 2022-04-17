//
//  Reachability.h
//  Damoov DashboardModule
//
//  Created by pp@datamotion.ai on 09.02.21.
//  Copyright © 2022 DATA MOTION PTE. LTD. All rights reserved.
//

@import Foundation;
#import <SystemConfiguration/SystemConfiguration.h>
#import <netinet/in.h>

typedef enum {
	NotReachable = 0,
	ReachableViaWiFi,
	ReachableViaWWAN
} NetworkStatus;

#define kReachabilityChangedNotification @"kNetworkReachabilityChangedNotification"

@interface Reachability: NSObject
{
	BOOL localWiFiRef;
	SCNetworkReachabilityRef reachabilityRef;
}

+ (Reachability*)reachabilityWithHostName:(NSString*)hostName;

+ (Reachability*)reachabilityWithAddress:(const struct sockaddr_in*)hostAddress;

+ (Reachability*)reachabilityForInternetConnection;

+ (Reachability*)reachabilityForLocalWiFi;

- (BOOL)startNotifier;
- (void)stopNotifier;

- (NetworkStatus)currentReachabilityStatus;

- (BOOL)connectionRequired;

@end


