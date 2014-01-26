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


const CGFloat XUITableViewPlaceholderInset	=	10.0;


@interface XUITableView ()

@property (nonatomic, strong) IBOutlet XUILabel	*placeholderLabel;

@end


#pragma mark -
@implementation XUITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
	if ((self = [super initWithFrame:frame style:style])) {
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[self setBackgroundColor:[UIColor whiteColor]];
		
		_hidesTableHeaderWhenEmpty = YES;
		_hidesTableFooterWhenEmpty = YES;
	}
	return self;
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

- (void)layoutSubviews {
	[super layoutSubviews];
	
	//TODO: animate visibility
	BOOL isEmpty = (self.indexPathsForVisibleRows == nil);
	[self.tableHeaderView setHidden:(isEmpty && self.hidesTableHeaderWhenEmpty)];
	[self.tableFooterView setHidden:(isEmpty && self.hidesTableFooterWhenEmpty)];
	[self.placeholderLabel setHidden:!isEmpty];
}

@end
