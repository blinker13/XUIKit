//
//  XUITextView.h
//  XUIKit
//
//  Created by Felix Gabel on 01/12/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface XUITextView : UITextView

@property (nonatomic, readonly) NSArray	*allPatterns;

- (void)setHighlightingColor:(UIColor *)color forPattern:(NSString *)pattern;
- (void)removeHighlightingColorForPattern:(NSString *)pattern;
- (UIColor *)highlightingColorForPattern:(NSString *)pattern;

@end
