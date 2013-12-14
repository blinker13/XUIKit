//
//  XUITableViewCell.m
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewCell.h"
#import "XUILabel.h"


NSString * const XUITableViewCellTitleLabelKey		=	@"textLabel";
NSString * const XUITableViewCellSubtitleLabelKey	=	@"detailTextLabel";

const CGFloat XUITableViewCellOffsetX	=	2.0;


#pragma mark -
@interface XUITableViewCell ()

@property (nonatomic, weak) UILabel	*titleLabel;
@property (nonatomic, weak) UILabel	*subtitleLabel;

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
	if (!self.titleLabel) {
		XUILabel *titleLabel = [[XUILabel alloc] initWithFrame:CGRectZero];
		[titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
		[titleLabel setBackgroundColor:[UIColor whiteColor]];
		[self setValue:titleLabel forKey:XUITableViewCellTitleLabelKey];
		[self.contentView addSubview:titleLabel];
	}
	return [super textLabel];
}

- (UILabel *)detailTextLabel {
	if (!self.subtitleLabel) {
		XUILabel *subtitleLabel = [[XUILabel alloc] initWithFrame:CGRectZero];
		[subtitleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
		[subtitleLabel setBackgroundColor:[UIColor whiteColor]];
		[self setValue:subtitleLabel forKey:XUITableViewCellSubtitleLabelKey];
		[self.contentView addSubview:subtitleLabel];
	}
	return [super detailTextLabel];
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

- (void)setValue:(id)value forKey:(NSString *)key {
	if ([key isEqualToString:XUITableViewCellSubtitleLabelKey]) [self setSubtitleLabel:value];
	if ([key isEqualToString:XUITableViewCellTitleLabelKey]) [self setTitleLabel:value];
	[super setValue:value forKey:key];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	if (self.style == UITableViewCellStyleValue1 && self.subtitleLabel) {
		[self.detailTextLabel sizeToFit];
		
		CGRect bounds = [self.contentView bounds];
		
		CGRect subRect = [self.detailTextLabel frame];
		bounds.size.width -= CGRectGetWidth(subRect);
		subRect.origin.x = CGRectGetWidth(bounds);
		[self.detailTextLabel setFrame:subRect];
		
		CGRect rect = CGRectIntersection(self.textLabel.frame, bounds);
		[self.textLabel setFrame:rect];
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
