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


@implementation XUILabel

- (void)setHighlighted:(BOOL)highlighted {
	if (highlighted != self.highlighted) {
		[super setHighlighted:highlighted];
		
		if (highlighted && self.attributedText) {
			[self setAttributtedTextBackup:self.attributedText];
			[self setAttributedText:self.highlightedAttributedText];
		}
		
		if (!highlighted && self.attributtedTextBackup) {
			[self setAttributedText:self.attributtedTextBackup];
			[self setAttributtedTextBackup:nil];
		}
	}
}

- (NSAttributedString *)highlightedAttributedText {
	if (!_highlightedAttributedText) {
		NSAttributedString *text = [self attributedText];
		NSRange highlightingRange = NSMakeRange(0, text.length);
		NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithAttributedString:text];
		[string addAttribute:NSForegroundColorAttributeName value:self.highlightedTextColor range:highlightingRange];
		return string;
	}
	return _highlightedAttributedText;
}

@end
