//
//  XUITableViewCell.h
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;

@class XUITableViewCellScrollView;


@interface XUITableViewCell : UITableViewCell

@property (nonatomic, readonly) XUITableViewCellScrollView	*contentScrollView;

@property (nonatomic, strong) UIColor	*selectedBackgroundColor;

@end
