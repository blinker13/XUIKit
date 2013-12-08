//
//  XUITableViewCell.h
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;
#import "XUILabel.h"


@interface XUITableViewCell : UITableViewCell

@property (nonatomic, readonly) XUILabel	*titleLabel;
@property (nonatomic, readonly) XUILabel	*subtitleLabel;

@property (nonatomic, strong) UIColor	*selectedBackgroundColor;

@property (nonatomic, readonly) UITableViewCellStyle	style;

@end
