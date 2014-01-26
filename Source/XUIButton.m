//
//  XUIButton.m
//  XUIKit
//
//  Created by Felix Gabel on 11/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIButton.h"
#import "UIView+XUIKit.h"


const CGFloat XUIButtonCornerRadius	=	3.0;
const CGFloat XUIButtonBorderWidth	=	1.0;


@interface XUIButton ()

@property (nonatomic, strong) UIColor	*originalBackgroundColor;

@end


#pragma mark -
@implementation XUIButton

- (instancetype)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setCornerRadius:XUIButtonCornerRadius];
		[self setBorderWidth:XUIButtonBorderWidth];
	}
	return self;
}


#pragma mark -

- (void)tintColorDidChange {
	[super tintColorDidChange];
	
	UIColor *tintColor = [self tintColor];
	[self setBorderColor:tintColor];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
	
	if (self.isHighlighted) {
		[self setOriginalBackgroundColor:backgroundColor];
		
	} else {
		[super setBackgroundColor:backgroundColor];
	}
}

- (void)setHighlighted:(BOOL)highlighted {
	if (highlighted != self.highlighted) {
		[super setHighlighted:highlighted];
		
		if (highlighted) {
			[self setOriginalBackgroundColor:self.backgroundColor];
			[super setBackgroundColor:self.tintColor];
			
		} else {
			[super setBackgroundColor:self.originalBackgroundColor];
			[self setOriginalBackgroundColor:nil];
		}
	}
}

@end
