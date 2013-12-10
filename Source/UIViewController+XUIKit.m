//
//  UIViewController+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 29/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "UIViewController+XUIKit.h"


@implementation UIViewController (XUIKit)

- (NSString *)contentTitle {
	return nil;
}

- (void)setContentTitle:(NSString *)contentTitle {
	
	if (contentTitle.length) {
		UINavigationBar *navigation = [self.navigationController navigationBar];
		NSDictionary *titleAttributes = [navigation titleTextAttributes];
		UIColor *textColor = [titleAttributes objectForKey:NSForegroundColorAttributeName];
		UIFont *font = [titleAttributes objectForKey:NSFontAttributeName];
		
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		if (!navigation.isTranslucent) [titleLabel setBackgroundColor:navigation.barTintColor];
		[titleLabel setTextAlignment:NSTextAlignmentCenter];
		[titleLabel setTextColor:textColor];
		[titleLabel setText:contentTitle];
		[titleLabel setFont:font];
		[self.navigationItem setTitleView:titleLabel];
		[titleLabel sizeToFit];
	}
	[self setTitle:@""];
}

@end
