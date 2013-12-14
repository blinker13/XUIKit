//
//  XUITableViewCell.h
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface XUITableViewCell : UITableViewCell

@property (nonatomic, strong) UIColor	*selectedBackgroundColor;
@property (nonatomic, readonly) UITableViewCellStyle	style;

@end
