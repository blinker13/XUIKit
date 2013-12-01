//
//  XUITextViewController.h
//  XUIKit
//
//  Created by Felix Gabel on 23/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITextView.h"


@interface XUITextViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) NSTextContainer	*textContainer;
@property (nonatomic, strong) NSTextStorage		*textStorage;

@property (nonatomic, readonly) XUITextView		*textView;

@property (nonatomic) UIEdgeInsets	textViewScrollIndicatorInsets;
@property (nonatomic) UIEdgeInsets	textViewContentInsets;


- (void)loadTextStack;

@end
