//
//  UITableViewCell+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "UITableViewCell+XUIKit.h"


@implementation UITableViewCell (XUI)

- (UIColor *)selectedBackgroundColor {
	return [self.selectedBackgroundView backgroundColor];
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
	UIView *selectionView = [self selectedBackgroundView];
	
	if (!selectionView) {
		selectionView = [[UIView alloc] initWithFrame:CGRectZero];
	}
	[selectionView setBackgroundColor:selectedBackgroundColor];
}

@end
