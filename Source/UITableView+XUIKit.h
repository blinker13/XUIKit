//
//  UITableView+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 20/01/15.
//  Copyright (c) 2015 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface UITableView (XUIKit)

- (void)registerCell:(Class)cellClass;
- (id)dequeueReusableCell:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

@end
