//
//  XUITableView.m
//  XUIKit
//
//  Created by Felix Gabel on 25/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUITableView.h"
#import "XUIKitDefines.h"
#import "XUILabel.h"


const CGFloat XUITableViewPlaceholderInset		=	10.0;
const CGFloat XUITableViewDeSelectionDuration	=	0.4;


@interface XUITableView ()

@property (nonatomic, strong) IBOutlet XUILabel	*placeholderLabel;

@end


#pragma mark -
@implementation XUITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	if ((self = [super initWithFrame:frame style:style])) {
		UIColor *backgroundColor = [UIColor whiteColor];
		
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[self setAutoresizingMask:XUIViewFlexibleSize];
		[self setBackgroundColor:backgroundColor];
		[self setRowHeight:40.0];
		
		_hidesTableHeaderWhenEmpty = YES;
		_hidesTableFooterWhenEmpty = YES;
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

- (void)layoutSubviews {
	[super layoutSubviews];
	
	//TODO: animate visibility
	BOOL shouldHidePlaceholder = [self shouldHidePlaceholder];
	[self.tableHeaderView setHidden:(!shouldHidePlaceholder && self.hidesTableHeaderWhenEmpty)];
	[self.tableFooterView setHidden:(!shouldHidePlaceholder && self.hidesTableFooterWhenEmpty)];
	[self.placeholderLabel setHidden:shouldHidePlaceholder];
}

#pragma mark -

- (XUILabel *)placeholderLabel {
	if (!_placeholderLabel) {
		CGRect bounds = [self bounds];
		CGRect rect = CGRectInset(bounds, XUITableViewPlaceholderInset, XUITableViewPlaceholderInset);
		
		UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
		UIColor *backgroundColor = [UIColor whiteColor];
		UIColor *textColor = [UIColor grayColor];
		
		_placeholderLabel = [[XUILabel alloc] initWithFrame:rect];
		[_placeholderLabel setAutoresizingMask:XUIViewFlexibleSize];
		[_placeholderLabel setTextAlignment:NSTextAlignmentCenter];
		[_placeholderLabel setBackgroundColor:backgroundColor];
		[_placeholderLabel setTextColor:textColor];
		[_placeholderLabel setNumberOfLines:0];
		[_placeholderLabel setFont:font];
		
		[self setBackgroundView:_placeholderLabel];
	}
	return _placeholderLabel;
}


#pragma mark - private methods

- (BOOL)shouldHidePlaceholder {
	NSUInteger numberOfSections = [self numberOfSections];
	for (NSUInteger section = 0; section < numberOfSections; section++) {
		if ([self numberOfRowsInSection:section] > 0) return YES;
	}
	return NO;
}

@end
