//
//  UITextField+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 09/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "UITextField+XUIKit.h"
#import "XUIInputView.h"


@implementation UITextField (XUIKit)

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

@end
