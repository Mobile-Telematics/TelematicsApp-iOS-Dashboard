//
//  LANSUserDefaults-helper.h
//  LoginAuth
//
//  Created by DATA MOTION PTE. LTD.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

@import Foundation;

#define LAInit static inline

LAInit void __defaults_post_notification(NSString *key);
LAInit void __defaults_save(void);


LAInit NSUserDefaults *defaults() {
	return [NSUserDefaults standardUserDefaults]; 
}

LAInit void defaults_init(NSDictionary *dictionary) {
	[defaults() registerDefaults:dictionary]; 
}

LAInit id defaults_object(NSString *key) {
	return [defaults() objectForKey:key]; 
}

LAInit void defaults_set_object(NSString *key, NSObject *object) {
	[defaults() setObject:object forKey:key];
	__defaults_save();
	__defaults_post_notification(key);
}

LAInit void defaults_remove(NSString *key) {
    [defaults() removeObjectForKey:key];
	__defaults_save();
    __defaults_post_notification(key);
}

LAInit void defaults_observe(NSString *key, void (^block) (id object)) {
	[[NSNotificationCenter defaultCenter] addObserverForName:key object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *n){
		block( [n.userInfo objectForKey:@"value"] );
	}];
}

LAInit void defaults_reset(){
	NSDictionary *defaultsDictionary = [defaults() dictionaryRepresentation];
	for (NSString *key in [defaultsDictionary allKeys]) {
	    defaults_remove(key);
	}
}

LAInit void __defaults_post_notification(NSString *key) {
    id object = defaults_object(key);
	[[NSNotificationCenter defaultCenter] postNotificationName:key object:nil userInfo: object ? [NSDictionary dictionaryWithObject:object forKey:@"value"] : [NSDictionary dictionary]];
}

LAInit void __defaults_save() {
	[defaults() synchronize]; 
}
