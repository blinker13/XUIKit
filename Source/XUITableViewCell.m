//
//  XUITableViewCell.m
//  XUIKit
//
//  Created by Felix Gabel on 03/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewCell.h"


@interface XUITableViewCell ()

@property (nonatomic, strong) NSAttributedString	*attributedDetailedTextBackup;
@property (nonatomic, strong) NSAttributedString	*attributedTextBackup;

@end


#pragma mark -
@implementation XUITableViewCell

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	[super setHighlighted:highlighted animated:animated];
	
	if (highlighted) {
		if (self.textLabel.attributedText) {
			[self setAttributedTextBackup:self.textLabel.attributedText];
			NSAttributedString *string = [self highlightedStringFromLabel:self.textLabel];
			[self.textLabel setAttributedText:string];
		}
		
		if (self.detailTextLabel.attributedText) {
			[self setAttributedTextBackup:self.detailTextLabel.attributedText];
			NSAttributedString *string = [self highlightedStringFromLabel:self.detailTextLabel];
			[self.detailTextLabel setAttributedText:string];
		}
		
	} else {
		if (self.attributedTextBackup) {
			[self.textLabel setAttributedText:self.attributedTextBackup];
			[self setAttributedTextBackup:nil];
		}
		
		if (self.attributedDetailedTextBackup) {
			[self.textLabel setAttributedText:self.attributedDetailedTextBackup];
			[self setAttributedDetailedTextBackup:nil];
		}
	}
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
