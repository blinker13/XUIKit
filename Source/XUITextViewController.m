//
//  XUITextViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 23/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITextViewController.h"
#import "UITextView+XUIKit.h"


@interface XUITextViewController ()

@property (nonatomic, readwrite) IBOutlet UITextView	*textView;
@property (nonatomic) BOOL	shouldReselectTextView;

@end


@implementation XUITextViewController

@synthesize textContainer	=	_textContainer;


- (instancetype)initWithTextContainer:(NSTextContainer *)textContainer {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		_textViewContentInsets = UIEdgeInsetsMake(15.0, 10.0, 15.0, 10.0);
		_textViewScrollIndicatorInsets = UIEdgeInsetsZero;
		_textContainer = textContainer;
	}
	return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	return [self initWithTextContainer:nil];
}


#pragma mark -

- (void)loadView {
	[self setView:self.textView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector:@selector(beginEditingText:) name:UITextViewTextDidBeginEditingNotification object:self.textView];
	[center addObserver:self selector:@selector(endEditingText:) name:UITextViewTextDidEndEditingNotification object:self.textView];
	[center addObserver:self selector:@selector(updateCursorVisibility:) name:UITextViewTextDidChangeNotification object:self.textView];
	[center addObserver:self selector:@selector(makeCursorVisible:) name:UIKeyboardDidShowNotification object:nil];
	
	if (self.shouldReselectTextView) {
		[self.textView becomeFirstResponder];
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self.textView];
	[center removeObserver:self name:UITextViewTextDidEndEditingNotification object:self.textView];
	[center removeObserver:self name:UITextViewTextDidChangeNotification object:self.textView];
	[center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
	
	[self.textView resignFirstResponder];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	
	if (editing) {
		[self.textView becomeFirstResponder];
		
	} else {
		[self.textView resignFirstResponder];
	}
}

- (void)viewChangedContentHeight:(CGFloat)height {
	UIEdgeInsets scrollIndicatorInsets = [self textViewScrollIndicatorInsets];
	scrollIndicatorInsets.bottom = (scrollIndicatorInsets.bottom + height);
	[self.textView setScrollIndicatorInsets:scrollIndicatorInsets];
	
	UIEdgeInsets insets = [self textViewContentInsets];
	insets.bottom = (insets.bottom + height);
	[self.textView setTextContentInsets:insets];
}


#pragma mark -

- (UITextView *)textView {
	if (!_textView) {
		CGRect bounds = [[UIScreen mainScreen] bounds];
		
		_textView = [[UITextView alloc] initWithFrame:bounds textContainer:self.textContainer];
		[_textView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
		[_textView setScrollIndicatorInsets:self.textViewScrollIndicatorInsets];
		[_textView setTextContentInsets:self.textViewContentInsets];
		[_textView setBackgroundColor:[UIColor whiteColor]];
		[_textView setAlwaysBounceVertical:YES];
		[_textView setScrollEnabled:YES];
		[_textView setClipsToBounds:NO];
		[_textView setDelegate:self];
	}
	return _textView;
}


#pragma mark - private methods

- (void)beginEditingText:(NSNotification *)notification {
	[super setEditing:YES animated:YES];
}

- (void)endEditingText:(NSNotification *)notification {
	id<UIViewControllerTransitionCoordinator> coordinator = [self transitionCoordinator];
	
	BOOL shouldReselect = [coordinator isAnimated];
	[self setShouldReselectTextView:shouldReselect];
	
	if (!shouldReselect) {
		[super setEditing:NO animated:YES];
	}
}

- (void)updateCursorVisibility:(NSNotification *)notification {
	CGRect caretRect = [self.textView currentCurserRect];
	[self.textView scrollRectToVisible:caretRect animated:NO];
}

- (void)makeCursorVisible:(NSNotification *)notification {
	if ([self.textView isFirstResponder]) {
		[self.textView makeCursorVisibleAnimated:NO];
	}
}

@end
