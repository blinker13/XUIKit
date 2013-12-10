//
//  XUIScrollView.m
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewCellScrollView.h"


@implementation XUITableViewCellScrollView

- (instancetype)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self setShowsHorizontalScrollIndicator:NO];
		[self setShowsVerticalScrollIndicator:NO];
		[self setPagingEnabled:YES];
	}
	return self;
}


#pragma mark -

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (CGPointEqualToPoint(self.contentOffset, CGPointZero)) {
		[self.nextResponder touchesBegan:touches withEvent:event];
		
	} else {
		[self setContentOffset:CGPointZero animated:YES];
	}
	[super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.nextResponder touchesCancelled:touches withEvent:event];
	[super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.nextResponder touchesEnded:touches withEvent:event];
	[super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.nextResponder touchesCancelled:touches withEvent:event];
	[super touchesCancelled:touches withEvent:event];
}

@end
