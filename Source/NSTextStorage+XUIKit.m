//
//  NSTextStorage+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 01/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "NSTextStorage+XUIKit.h"


@implementation NSTextStorage (XUIKit)

- (NSRange)editedParagraphsRange {
	NSRange editedRange = [self editedRange];
	editedRange.length = (editedRange.length + 1);
	NSRange stringRange = NSMakeRange(0, [self.string length]);
	NSRange range = NSIntersectionRange(stringRange, editedRange);
	return [self.string paragraphRangeForRange:range];
}

@end
