//
//  UIApplication+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 27/06/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "UIApplication+XUIKit.h"
#import "NSBundle+XUIKit.h"


@implementation UIApplication (XUIKit)

- (BOOL)canRestoreApplicationStateWithCoder:(NSCoder *)coder {
	NSNumber *stateIdiomValue = [coder decodeObjectForKey:UIApplicationStateRestorationUserInterfaceIdiomKey];
	UIUserInterfaceIdiom currentIdiom = [[UIDevice currentDevice] userInterfaceIdiom];
	UIUserInterfaceIdiom stateIdiom = [stateIdiomValue integerValue];
	if (currentIdiom != stateIdiom) return NO;
	
	NSString *stateVersion = [coder decodeObjectForKey:UIApplicationStateRestorationBundleVersionKey];
	NSString *bundleVersion = [NSBundle mainBundleVersion];
	return [stateVersion isEqualToString:bundleVersion];
}

@end
