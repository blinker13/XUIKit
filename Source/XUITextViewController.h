//
//  XUITextViewController.h
//  XUIKit
//
//  Created by Felix Gabel on 23/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface XUITextViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, readonly) NSTextContainer	*textContainer;
@property (nonatomic, readonly) UITextView		*textView;

@property (nonatomic) UIEdgeInsets	textViewScrollIndicatorInsets;
@property (nonatomic) UIEdgeInsets	textViewContentInsets;


- (instancetype)initWithTextContainer:(NSTextContainer *)textContainer;

@end
