//
//  UIView+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 15/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "UIView+XUIKit.h"


@implementation UIView (XUIKit)

- (CGFloat)cornerRadius {
	return [self.layer cornerRadius];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
	[self.layer setCornerRadius:cornerRadius];
}

- (CGFloat)borderWidth {
	return [self.layer borderWidth];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
	[self.layer setBorderWidth:borderWidth];
}

- (CGPoint)innerCenter {
	CGFloat x = CGRectGetMidX(self.bounds);
	CGFloat y = CGRectGetMidY(self.bounds);
	return CGPointMake(x, y);
}

@end