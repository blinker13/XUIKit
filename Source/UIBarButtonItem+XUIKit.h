//
//  UIBarButtonItem+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface UIBarButtonItem (XUIKit)

+ (instancetype)addItemWithTarget:(id)target action:(SEL)action;
+ (instancetype)composeItemWithTarget:(id)target action:(SEL)action;

+ (instancetype)fixedSpaceItemWithWidth:(CGFloat)width;
+ (instancetype)flexibleSpaceItem;

@end
