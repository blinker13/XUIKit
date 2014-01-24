//
//  XUIAppDelegate.m
//  XUIKit
//
//  Created by Felix Gabel on 23/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIAppDelegate.h"
#import "NSBundle+XUIKit.h"


@implementation XUIAppDelegate

- (UIWindow *)window {
	if (!_window) {
		CGRect rect = [[UIScreen mainScreen] bounds];
		_window = [[UIWindow alloc] initWithFrame:rect];
	}
	return _window;
}


#pragma mark - State Preservation and Restoration

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
	return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
	
	NSNumber *stateIdiomValue = [coder decodeObjectForKey:UIApplicationStateRestorationUserInterfaceIdiomKey];
	UIUserInterfaceIdiom currentIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
	UIUserInterfaceIdiom stateIdiom = [stateIdiomValue integerValue];
	if (currentIdiom != stateIdiom) return NO;
	
	NSString *stateVersion = [coder decodeObjectForKey:UIApplicationStateRestorationBundleVersionKey];
	NSString *bundleVersion = [NSBundle mainBundleVersion];
	return [stateVersion isEqualToString:bundleVersion];
}

@end
