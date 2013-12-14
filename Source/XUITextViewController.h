//
//  XUITextViewController.h
//  XUIKit
//
//  Created by Felix Gabel on 23/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITextView.h"
#import "XUITextStorage.h"


@interface XUITextViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) NSTextContainer	*textContainer;
@property (nonatomic, strong) XUITextStorage	*textStorage;

@property (nonatomic, readonly) XUITextView		*textView;

//following insets should be set before -loadTextView is called. Manipulating the textView directly might interfer with keyboard insets
@property (nonatomic) UIEdgeInsets	textViewScrollIndicatorInsets;
@property (nonatomic) UIEdgeInsets	textViewContentInsets;


- (void)loadTextStack;	//this is where subclasses should create their textStorage, layoutManager and textContainer
- (void)textStackDidLoad;

- (void)loadTextView;	//this is where subclasses should create their textView

@end
