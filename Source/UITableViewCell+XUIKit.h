//
//  UITableViewCell+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface UITableViewCell (XUIKit)


@property (nonatomic, strong) UIColor	*selectedBackgroundColor;


+ (void)registerForTableView:(UITableView *)tableView;
+ (instancetype)dequeueForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
