//
//  XUILabel.m
//  XUIKit
//
//  Created by Felix Gabel on 08/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUILabel.h"


@interface XUILabel ()

@property (nonatomic, copy) NSAttributedString	*attributtedTextBackup;

@end


#pragma mark -
@implementation XUILabel

- (void)setAttributedText:(NSAttributedString *)attributedText {
	[super setAttributedText:attributedText];
	
	if (self.isHighlighted) {
		[self setAttributtedTextBackup:attributedText];
		[super setAttributedText:self.highlightedAttributedText];
	}
}

- (void)setHighlighted:(BOOL)highlighted {
	if (highlighted != self.highlighted) {
		[super setHighlighted:highlighted];
		
		if (highlighted && self.attributedText) {
			[self setAttributtedTextBackup:self.attributedText];
			[super setAttributedText:self.highlightedAttributedText];
		}
		
		if (!highlighted && self.attributtedTextBackup) {
			[super setAttributedText:self.attributtedTextBackup];
			[self setAttributtedTextBackup:nil];
		}
	}
}

- (NSAttributedString *)highlightedAttributedText {
	if (!_highlightedAttributedText) {
		NSAttributedString *text = [self attributedText];
		NSRange highlightingRange = NSMakeRange(0, text.length);
		UIColor *color = self.highlightedTextColor ?: self.textColor;
		NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:text];
		if (color) [string addAttribute:NSForegroundColorAttributeName value:color range:highlightingRange];
		return string;
	}
	return _highlightedAttributedText;
}

@end
