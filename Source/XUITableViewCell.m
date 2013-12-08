//
//  XUITableViewCell.m
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewCell.h"


@interface XUITableViewCell ()

@property (nonatomic, strong) IBOutlet XUILabel	*titleLabel;
@property (nonatomic, strong) IBOutlet XUILabel	*subtitleLabel;

@property (nonatomic, strong) NSAttributedString	*attributedDetailedTextBackup;
@property (nonatomic, strong) NSAttributedString	*attributedTextBackup;

@end


#pragma mark -
@implementation XUITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
		[self.contentView setBackgroundColor:[UIColor whiteColor]];
		[self setBackgroundColor:[UIColor whiteColor]];
		_style = style;
	}
	return self;
}

- (UILabel *)textLabel {
	return self.titleLabel;
}

- (UILabel *)detailTextLabel {
	return self.subtitleLabel;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	[_subtitleLabel setHighlighted:highlighted];
	[_titleLabel setHighlighted:highlighted];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	[_subtitleLabel setHighlighted:selected];
	[_titleLabel setHighlighted:selected];
}


#pragma mark -

- (XUILabel *)titleLabel {
	if (!_titleLabel) {
		UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 15.0, 0.0, 0.0);
		CGRect rect = UIEdgeInsetsInsetRect(self.contentView.bounds, insets);
		
		_titleLabel = [[XUILabel alloc] initWithFrame:rect];
		[_titleLabel setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
		[_titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
		[_titleLabel setBackgroundColor:[UIColor whiteColor]];
		[self.contentView addSubview:_titleLabel];
	}
	return _titleLabel;
}

- (XUILabel *)subtitleLabel {
	if (!_subtitleLabel) {
		_subtitleLabel = [[XUILabel alloc] initWithFrame:CGRectZero];
		[_subtitleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
		[self.contentView addSubview:_subtitleLabel];
	}
	return _subtitleLabel;
}

- (UIColor *)selectedBackgroundColor {
	return [self.selectedBackgroundView backgroundColor];
}

- (void)setSelectedBackgroundColor:(UIColor *)selectedBackgroundColor {
	UIView *selectionView = [[UIView alloc] initWithFrame:CGRectZero];
	[selectionView setBackgroundColor:selectedBackgroundColor];
	[self setSelectedBackgroundView:selectionView];
}


#pragma mark - private methods

- (NSAttributedString *)highlightedStringFromLabel:(UILabel *)label {
	NSRange range = NSMakeRange(0, label.text.length);
	NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
	[string addAttribute:NSForegroundColorAttributeName value:label.highlightedTextColor range:range];
	return string;
}

@end
