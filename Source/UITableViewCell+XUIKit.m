//
//  UITableViewCell+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "UITableViewCell+XUIKit.h"


@implementation UITableViewCell (XUIKit)

+ (void)registerForTableView:(UITableView *)tableView {
	NSString *identifier = NSStringFromClass(self);
	[tableView registerClass:self forCellReuseIdentifier:identifier];
}

+ (instancetype)dequeueForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
	NSString *identifier = NSStringFromClass(self);
	return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}


#pragma mark -

- (UIColor *)selectedBackgroundColor {
	return [self.selectedBackgroundView backgroundColor];
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
	UIView *selectionView = [[UIView alloc] initWithFrame:CGRectZero];
	[selectionView setBackgroundColor:selectedBackgroundColor];
	[self setSelectedBackgroundView:selectionView];
}

@end
