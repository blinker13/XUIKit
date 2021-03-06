//
//  UITextView+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 25/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface UITextView (XUIKit)

@property (nonatomic, strong) UIColor	*keyboardBlendColor;
@property (nonatomic) UIEdgeInsets		textContentInsets;


- (void)makeCursorVisibleAnimated:(BOOL)animated;

- (CGRect)visibleContentRect;
- (CGRect)currentCurserRect;

@end
