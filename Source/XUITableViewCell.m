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
	[self setContentViewsHighlighted:highlighted];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	[self setContentViewsHighlighted:selected];
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

- (void)setContentViewsHighlighted:(BOOL)highlight {
	if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
		
		for (id view in self.contentView.subviews) {
			if ([view respondsToSelector:@selector(setHighlighted:)]) {
				[view setHighlighted:highlight];
			}
		}
	}
}

@end
