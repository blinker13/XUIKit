//
//  UITableViewCell+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "UITableViewCell+XUIKit.h"


@implementation UITableViewCell (XUIKit)

+ (void)registerNibInTableView:(UITableView *)tableView {
	NSString *identifier = NSStringFromClass(self);
	UINib *nib = [UINib nibWithNibName:identifier bundle:nil];
	[tableView registerNib:nib forCellReuseIdentifier:identifier];
}

+ (void)registerClassInTableView:(UITableView *)tableView {
	NSString *identifier = NSStringFromClass(self);
	[tableView registerClass:self forCellReuseIdentifier:identifier];
}

+ (instancetype)dequeueInTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
	NSString *identifier = NSStringFromClass(self);
	return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

@end
