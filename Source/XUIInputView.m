//
//  XUIInputView.m
//  XUIKit
//
//  Created by Felix Gabel on 08/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIInputView.h"


@implementation XUIInputView

- (void)willMoveToWindow:(UIWindow *)newWindow {
	[super willMoveToWindow:newWindow];
	
	UIColor *blendColor = (newWindow) ? self.blendColor : nil;
	[self.superview setBackgroundColor:blendColor];
}

@end
