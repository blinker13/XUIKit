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

@property (nonatomic) UIColor	*borderColor;
@property (nonatomic) CGFloat	cornerRadius;
@property (nonatomic) CGFloat	borderWidth;


+ (instancetype)viewWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;

- (CGPoint)innerCenter;

@end
