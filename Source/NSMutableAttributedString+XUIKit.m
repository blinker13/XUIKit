//
//  NSMutableAttributedString+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 01/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "NSMutableAttributedString+XUIKit.h"


@implementation NSMutableAttributedString (XUIKit)

- (void)addHighlighting:(UIColor *)color usingRegex:(NSRegularExpression *)regex {
	NSRange range = NSMakeRange(0, self.string.length);
	
	[regex enumerateMatchesInString:self.string options:0 range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
		[self addAttribute:NSForegroundColorAttributeName value:color range:result.range];
	}];
}

@end
