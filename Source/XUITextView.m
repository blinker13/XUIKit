//
//  XUITextView.m
//  XUIKit
//
//  Created by Felix Gabel on 01/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITextView.h"
#import "XUITextStorage.h"


@implementation XUITextView

- (void)setTextColor:(UIColor *)textColor {
	[super setTextColor:textColor];
	
	//forward textColor to this views related textStorage
	if ([self.textStorage isKindOfClass:[XUITextStorage class]]) {
		[(XUITextStorage *)self.textStorage setTextColor:textColor];
	}
}

@end
