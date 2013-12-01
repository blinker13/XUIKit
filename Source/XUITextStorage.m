//
//  XUITextStorage.m
//  XUIKit
//
//  Created by Felix Gabel on 01/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITextStorage.h"


@interface XUITextStorage ()

@property (nonatomic, strong) NSMutableAttributedString	*storage;

@property (nonatomic, strong) NSMutableDictionary	*highlightingColors;
@property (nonatomic, strong) NSMutableDictionary	*regularExpressions;

@end


#pragma mark -
@implementation XUITextStorage

- (instancetype)init {
	if ((self = [super init])) {
		_storage = [[NSMutableAttributedString alloc] init];
		_highlightingColors = [[NSMutableDictionary alloc] init];
		_regularExpressions = [[NSMutableDictionary alloc] init];
		_textColor = [UIColor blackColor];
	}
	return self;
}


#pragma mark -

- (NSString *)string {
	return [self.storage string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range {
	return [self.storage attributesAtIndex:location effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str {
	[self.storage replaceCharactersInRange:range withString:str];
	
	NSInteger delta = [str length] - range.length;
	[self edited:NSTextStorageEditedCharacters range:range changeInLength:delta];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range {
	[self.storage setAttributes:attrs range:range];
	[self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
}

- (void)processEditing {
	[super processEditing];
	
	NSRange range = [self editedParagraphsRange];
	[self addAttribute:NSForegroundColorAttributeName value:self.textColor range:range];
	[self processHighlighting:self.string range:range];
}


#pragma mark -

- (NSArray *)allPatterns {
	return [self.regularExpressions allKeys];
}

- (void)setHighlightingColor:(UIColor *)color forPattern:(NSString *)pattern {
	if (![self.allPatterns containsObject:pattern]) {
		NSRegularExpression *regex = [self regularExpressionForPattern:pattern];
		[self.regularExpressions setObject:regex forKey:pattern];
	}
	[self.highlightingColors setObject:color forKey:pattern];
}

- (void)removeHighlightingColorForPattern:(NSString *)pattern {
	[self.regularExpressions removeObjectForKey:pattern];
	[self.highlightingColors removeObjectForKey:pattern];
}

- (UIColor *)highlightingColorForPattern:(NSString *)pattern {
	return [self.highlightingColors objectForKey:pattern];
}


#pragma mark - private methods

- (NSRange)editedParagraphsRange {
	NSRange editedRange = [self editedRange];
	editedRange.length = (editedRange.length + 1);
	NSRange stringRange = NSMakeRange(0, [self.string length]);
	NSRange range = NSIntersectionRange(stringRange, editedRange);
	return [self.string paragraphRangeForRange:range];
}

- (void)processHighlighting:(NSString *)string range:(NSRange)range {
	for (NSString *pattern in self.allPatterns) {
		NSRegularExpression *regex = [self.regularExpressions objectForKey:pattern];
		UIColor *color = [self.highlightingColors objectForKey:pattern];
		
		[regex enumerateMatchesInString:string options:0 range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
			[self addAttribute:NSForegroundColorAttributeName value:color range:result.range];
		}];
	}
}

- (NSRegularExpression *)regularExpressionForPattern:(NSString *)pattern {
	NSError *error = nil;
	NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:&error];
	NSAssert(!error, [error localizedDescription]);
	return regex;
}

@end
