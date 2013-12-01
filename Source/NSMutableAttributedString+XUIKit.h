//
//  NSMutableAttributedString+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 01/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;
//TODO: add AppKit support


@interface NSMutableAttributedString (XUIKit)

- (void)addHighlighting:(UIColor *)color usingRegex:(NSRegularExpression *)regex;

@end
