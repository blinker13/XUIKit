//
//  XUITextViewController.h
//  XUIKit
//
//  Created by Felix Gabel on 23/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUIViewController.h"
#import "XUITextView.h"

@class XUITextStorage;


@interface XUITextViewController : XUIViewController <UITextViewDelegate>

@property (nonatomic, strong) NSTextContainer	*textContainer;
@property (nonatomic, strong) XUITextStorage	*textStorage;
@property (nonatomic, readonly) XUITextView		*textView;

//!!!: Manipulating the textView directly might interfer with keyboard insets
@property (nonatomic) UIEdgeInsets	textViewScrollIndicatorInsets;
@property (nonatomic) UIEdgeInsets	textViewContentInsets;


// This is where subclasses should create their textStorage, layoutManager and textContainer instances.
//!!!: Should never be called directly.
- (void)loadTextStack;

@end
