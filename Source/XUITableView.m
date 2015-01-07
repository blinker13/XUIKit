//
//  XUITableView.m
//  XUIKit
//
//  Created by Felix Gabel on 25/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUITableView.h"


const CGFloat XUITableViewDeSelectionDuration	=	0.4;


#pragma mark -
@implementation XUITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	if ((self = [super initWithFrame:frame style:style])) {
		UIColor *backgroundColor = [UIColor whiteColor];
		
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[self setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
		[self setBackgroundColor:backgroundColor];
	}
	return self;
}


#pragma mark -

- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	
	if (animated) {
		UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
		
		[UIView animateWithDuration:XUITableViewDeSelectionDuration animations:^{
			[cell.selectedBackgroundView setAlpha:0.0];
			[cell setHighlighted:NO animated:NO];
			
		} completion:^(BOOL finished) {
			[super deselectRowAtIndexPath:indexPath animated:NO];
		}];
		
	} else {
		[super deselectRowAtIndexPath:indexPath animated:animated];
	}
}

@end
