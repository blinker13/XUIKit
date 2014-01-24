//
//  NSBundle+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 23/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSBundle+XUIKit.h"


@implementation NSBundle (XUIKit)

+ (NSString *)mainBundleVersion {
	NSBundle *mainBundle = [self mainBundle];
	NSDictionary *info = [mainBundle infoDictionary];
	return [info objectForKey:@"CFBundleVersion"];
}

@end
