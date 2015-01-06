//
//  UIBarButtonItem+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "UIBarButtonItem+XUIKit.h"


@implementation UIBarButtonItem (XUIKit)

+ (instancetype)fixedSpaceItemWithWidth:(CGFloat)width {
	UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:NULL];
	[item setWidth:width];
	return item;
}

+ (instancetype)flexibleSpaceItem {
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
}

@end
