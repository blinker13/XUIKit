//
//  UIViewController+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 07/01/15.
//  Copyright (c) 2015 Felix Gabel. All rights reserved.
//

#import "UIViewController+XUIKit.h"


@implementation UIViewController (XUIKit)

- (NSString *)navigationTitle {
	if ([self.navigationItem.titleView respondsToSelector:@selector(text)]) {
		return [self.navigationItem.titleView performSelector:@selector(text)];
	}
	
	return [self title];
}

- (void)setNavigationTitle:(NSString *)navigationTitle {
	UINavigationBar *navigation = [self.navigationController navigationBar];
	NSDictionary *titleAttributes = [navigation titleTextAttributes];
	UIColor *textColor = [titleAttributes objectForKey:NSForegroundColorAttributeName];
	UIFont *font = [titleAttributes objectForKey:NSFontAttributeName];
	
	UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	if (!navigation.isTranslucent) [titleLabel setBackgroundColor:navigation.barTintColor];
	[titleLabel setTextAlignment:NSTextAlignmentCenter];
	[titleLabel setText:navigationTitle];
	[titleLabel setTextColor:textColor];
	[titleLabel setFont:font];
	
	[self.navigationItem setTitleView:titleLabel];
	[titleLabel sizeToFit];
	
	[self setTitle:@""];
}

@end
