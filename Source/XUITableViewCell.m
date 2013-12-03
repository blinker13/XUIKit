//
//  XUITableViewCell.m
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewCell.h"
#import "XUITableViewCellScrollView.h"


@interface XUITableViewCell ()

@property (nonatomic, strong) IBOutlet XUIScrollView	*contentScrollView;
//@property (nonatomic, strong) UIImageView	*accessoryImageView;

@end


#pragma mark -
@implementation XUITableViewCell


- (UILabel *)textLabel {
	UILabel *textLabel = [super textLabel];
	if (textLabel.superview != self.contentScrollView) {
		[self.contentScrollView addSubview:textLabel];
	}
	return textLabel;
}

- (UILabel *)detailTextLabel {
	UILabel *detailTextLabel = [super detailTextLabel];
	if (detailTextLabel.superview != self.contentScrollView) {
		[self.contentScrollView addSubview:detailTextLabel];
	}
	return detailTextLabel;
}

- (void)setAccessoryView:(UIView *)accessoryView {
	[super setAccessoryView:accessoryView];
	[self.contentScrollView addSubview:accessoryView];
}

- (UIScrollView *)contentScrollView {
	if (!_contentScrollView) {
		CGRect rect = [self.contentView bounds];
		
		_contentScrollView = [[XUITableViewCellScrollView alloc] initWithFrame:rect];
		[_contentScrollView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
		[_contentScrollView setShowsHorizontalScrollIndicator:NO];
		[_contentScrollView setShowsVerticalScrollIndicator:NO];
		[_contentScrollView setPagingEnabled:YES];
		
		[_contentScrollView setContentSize:CGSizeMake(rect.size.width + 50.0, rect.size.height)];
		[self.contentView addSubview:_contentScrollView];
	}
	return _contentScrollView;
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
