//
//  XUITextView.m
//  XUIKit
//
//  Created by Felix Gabel on 01/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITextView.h"


@interface XUITextView ()

@property (nonatomic, strong) NSMutableDictionary	*highlightingColors;
@property (nonatomic, strong) NSMutableDictionary	*regularExpressions;

@property (nonatomic, strong) UIColor	*defaultTextColor;

@end


@implementation XUITextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
	if ((self = [super initWithFrame:frame textContainer:textContainer])) {
		_highlightingColors = [[NSMutableDictionary alloc] init];
		_regularExpressions = [[NSMutableDictionary alloc] init];
		_defaultTextColor = [UIColor blackColor];
		
		SEL action = @selector(processEditing:);
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center addObserver:self selector:action name:NSTextStorageDidProcessEditingNotification object:self.textStorage];
	}
	return self;
}

- (void)dealloc {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:NSTextStorageDidProcessEditingNotification object:self.textStorage];
}


#pragma mark -

- (void)setTextColor:(UIColor *)textColor {
	[self setDefaultTextColor:textColor];
	[super setTextColor:textColor];
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

- (void)processEditing:(NSNotification *)notification {
	NSString *string = [self.textStorage string];
	NSRange range = NSMakeRange(0, [string length]);
	
	[self.textStorage addAttribute:NSForegroundColorAttributeName value:self.defaultTextColor range:range];
	
	for (NSString *pattern in self.allPatterns) {
		NSRegularExpression *regex = [self.regularExpressions objectForKey:pattern];
		UIColor *color = [self.highlightingColors objectForKey:pattern];
		
		//TODO: performance decreases with increasing string size
		[regex enumerateMatchesInString:string options:0 range:range usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
			[self.textStorage addAttribute:NSForegroundColorAttributeName value:color range:result.range];
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
