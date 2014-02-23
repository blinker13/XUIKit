//
//  XUITableViewCell.m
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewCell.h"


@implementation XUITableViewCell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	
	for (id view in self.contentView.subviews) {
		if ([view respondsToSelector:@selector(setHighlighted:)]) {
			[view setHighlighted:highlighted];
		}
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	
	for (id view in self.contentView.subviews) {
		if ([view respondsToSelector:@selector(setHighlighted:)]) {
			[view setHighlighted:selected];
		}
	}
}


#pragma mark -

- (UIColor *)selectedBackgroundColor {
	return [self.selectedBackgroundView backgroundColor];
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
	UIView *selectionView = [[UIView alloc] initWithFrame:CGRectZero];
	[selectionView setBackgroundColor:selectedBackgroundColor];
	[self setSelectedBackgroundView:selectionView];
}

@end
