//
//  UITextView+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 25/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "UITextView+XUIKit.h"
#import "XUIInputView.h"


const CGFloat XUITextViewScrollDuration	=	0.13;


@implementation UITextView (XUIKit)

- (UIColor *)keyboardBlendColor {
	if ([self.inputAccessoryView isKindOfClass:[XUIInputView class]]) {
		return [(XUIInputView *)self.inputAccessoryView blendColor];
	}
	return nil;
}

- (void)setKeyboardBlendColor:(UIColor *)keyboardBlendColor {
	if ([self.inputAccessoryView isKindOfClass:[XUIInputView class]]) {
		[(XUIInputView *)self.inputAccessoryView setBlendColor:keyboardBlendColor];
		
	} else {
		XUIInputView *inputView = [[XUIInputView alloc] init];
		[inputView setBlendColor:keyboardBlendColor];
		[self setInputAccessoryView:inputView];
	}
}

#pragma mark - Content Inset

- (UIEdgeInsets)textContentInsets {
	UIEdgeInsets contentInsets = [self contentInset];
	UIEdgeInsets containerInsets = [self textContainerInset];
	return UIEdgeInsetsMake(contentInsets.top, containerInsets.left, contentInsets.bottom, containerInsets.right);
}

- (void)setTextContentInsets:(UIEdgeInsets)textContentInsets {
	UIEdgeInsets contentInsets = UIEdgeInsetsZero;
	contentInsets.bottom = textContentInsets.bottom;
	contentInsets.top = textContentInsets.top;
	[self setContentInset:contentInsets];
	
	UIEdgeInsets containerInsets = UIEdgeInsetsZero;
	containerInsets.right = textContentInsets.right;
	containerInsets.left = textContentInsets.left;
	[self setTextContainerInset:containerInsets];
}


#pragma mark - Cursor

- (void)makeCursorVisibleAnimated:(BOOL)animated {
	CGRect visibleRect = [self visibleContentRect];
	CGRect cursorRect = [self currentCurserRect];
	
	if (!CGRectContainsRect(visibleRect, cursorRect)) {
		CGFloat duration = animated ? XUITextViewScrollDuration : 0.0;
		
		[UIView animateWithDuration:duration delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
			[self scrollRectToVisible:cursorRect animated:NO];
		} completion:nil];
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
