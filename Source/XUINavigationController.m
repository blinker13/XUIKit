//
//  XUINavigationController.m
//  XUIKit
//
//  Created by Felix Gabel on 18/06/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUINavigationController.h"


@implementation XUINavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
	if ((self = [super initWithRootViewController:rootViewController])) {
		NSString *identifier = NSStringFromClass(self.class);
		[self setRestorationIdentifier:identifier];
	}
	return self;
}

@end
