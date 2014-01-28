//
//  UITableView+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 27/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface UITableView (XUIKit)

- (void)registerCellClass:(Class)cellClass;

- (id)dequeueReusableCell:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

@end
