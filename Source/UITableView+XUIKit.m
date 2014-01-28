//
//  UITableView+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 27/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "UITableView+XUIKit.h"


NSString *const XUITableViewCellNibType	=	@"nib";


@implementation UITableView (XUIKit)

- (void)registerCellClass:(Class)cellClass {
	NSString *identifier = NSStringFromClass(cellClass);
	NSBundle *mainBundle = [NSBundle mainBundle];
	
	if ([mainBundle pathForResource:identifier ofType:XUITableViewCellNibType]) {
		UINib *nib = [UINib nibWithNibName:identifier bundle:mainBundle];
		[self registerNib:nib forCellReuseIdentifier:identifier];
		
	} else {
		[self registerClass:cellClass forCellReuseIdentifier:identifier];
	}
}

- (id)dequeueReusableCell:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = NSStringFromClass(cellClass);
	return [self dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

@end
