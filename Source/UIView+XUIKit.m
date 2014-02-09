//
//  UIView+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 15/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "UIView+XUIKit.h"


@implementation UIView (XUIKit)

+ (instancetype)viewWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle owner:(id)owner {
	
	nibName = nibName ?: NSStringFromClass(self);
	UINib *nib = [UINib nibWithNibName:nibName bundle:bundle];
	NSArray *contents = [nib instantiateWithOwner:owner options:nil];
	UIView *view = [contents firstObject];
	
	NSAssert([view isKindOfClass:self], @"Incompatible nib '%@'\n\n%@", nibName, view);
	
	return view;
}


#pragma mark - Convenience

- (UIColor *)borderColor {
	CGColorRef cgColor = [self.layer borderColor];
	return [UIColor colorWithCGColor:cgColor];
}

- (void)setBorderColor:(UIColor *)borderColor {
	CGColorRef cgColor = [borderColor CGColor];
	[self.layer setBorderColor:cgColor];
}

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


#pragma mark - Geometry

- (CGPoint)innerCenter {
	CGFloat x = CGRectGetMidX(self.bounds);
	CGFloat y = CGRectGetMidY(self.bounds);
	return CGPointMake(x, y);
}

@end
