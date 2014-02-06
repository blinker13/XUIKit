//
//  UIImage+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 06/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "UIImage+XUIKit.h"


@implementation UIImage (XUIKit)

+ (instancetype)imageWithColor:(UIColor *)color {
	CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
	
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return image;
}

@end
