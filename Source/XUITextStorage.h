//
//  XUITextStorage.h
//  XUIKit
//
//  Created by Felix Gabel on 01/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface XUITextStorage : NSTextStorage

@property (nonatomic, strong) UIColor	*textColor;
@property (nonatomic, readonly) NSArray	*allPatterns;

- (void)setHighlightingColor:(UIColor *)color forPattern:(NSString *)pattern;
- (void)removeHighlightingColorForPattern:(NSString *)pattern;
- (UIColor *)highlightingColorForPattern:(NSString *)pattern;

@end
