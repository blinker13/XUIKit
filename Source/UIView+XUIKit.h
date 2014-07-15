//
//  UIView+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 15/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;
@import QuartzCore;


@interface UIView (XUIKit)

@property (nonatomic) UIColor	*borderColor IB_DESIGNABLE;
@property (nonatomic) CGFloat	cornerRadius IB_DESIGNABLE;
@property (nonatomic) CGFloat	borderWidth  IB_DESIGNABLE;


+ (instancetype)viewWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle owner:(id)owner;

- (CGPoint)innerCenter;

@end
