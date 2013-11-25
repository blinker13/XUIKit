//
//  UITextView+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 25/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "UITextView+XUIKit.h"


@implementation UITextView (XUIKit)

- (void)makeCursorVisibleAnimated:(BOOL)animated {
	CGRect visibleRect = [self visibleContentRect];
	CGRect cursorRect = [self currentCurserRect];
	
	if (!CGRectContainsRect(visibleRect, cursorRect)) {
		[self scrollRectToVisible:cursorRect animated:animated];
	}
}

- (CGRect)visibleContentRect {
	CGRect rect = self.bounds;
	rect.size.height -= (self.contentInset.top + self.contentInset.bottom);
	rect.origin.y = self.contentOffset.y;
	return rect;
}

- (CGRect)currentCurserRect {
	UITextPosition *position = [self.selectedTextRange end];
	return [self caretRectForPosition:position];
}

@end
