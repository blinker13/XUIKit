//
//  XUIApplication.m
//  XUIKit
//
//  Created by Felix Gabel on 23/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIApplication.h"


NSString *const XUIApplicationClass	=	@"ApplicationClass";
NSString *const XUIAppDelegateClass	=	@"AppDelegateClass";


int main(int argc, char * argv[]) {
	
	@autoreleasepool {
		NSBundle *mainBundle = [NSBundle mainBundle];
		NSDictionary *bundleInfo = [mainBundle infoDictionary];
		NSString *principalClassName = [bundleInfo objectForKey:XUIApplicationClass];
		NSString *delegateClassName = [bundleInfo objectForKey:XUIAppDelegateClass];
		return UIApplicationMain(argc, argv, principalClassName, delegateClassName);
	}
}
