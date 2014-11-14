//
//  UITableView+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 27/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "UITableView+XUIKit.h"
#import "NSBundle+XUIKit.h"


@implementation UITableView (XUIKit)

- (void)registerCellClass:(Class)cellClass {
	NSString *identifier = NSStringFromClass(cellClass);
	UINib *nib = [[NSBundle mainBundle] existingNibWithName:identifier];
	
	if (nib) [self registerNib:nib forCellReuseIdentifier:identifier];
	else [self registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (id)dequeueReusableCell:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = NSStringFromClass(cellClass);
	return [self dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

@end
