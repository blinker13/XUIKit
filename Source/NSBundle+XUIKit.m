//
//  NSBundle+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 23/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSBundle+XUIKit.h"


NSString *const XUINibSuffix	=	@"nib";


@implementation NSBundle (XUIKit)

+ (NSString *)mainBundleVersion {
	NSBundle *mainBundle = [self mainBundle];
	NSDictionary *info = [mainBundle infoDictionary];
	return [info objectForKey:@"CFBundleVersion"];
}

- (UINib *)nibWithName:(NSString *)name {
	if ([self pathForResource:name ofType:XUINibSuffix]) {
		return [UINib nibWithNibName:name bundle:self];
	}
	return nil;
}

@end
