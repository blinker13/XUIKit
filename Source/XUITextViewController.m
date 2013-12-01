//
//  XUITextViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 23/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITextViewController.h"
#import "UITextView+XUIKit.h"
#import "XUITextStorage.h"


@interface XUITextViewController ()

@property (nonatomic, readwrite) IBOutlet XUITextView	*textView;

@property (nonatomic) BOOL	shouldReselectTextView;
@property (nonatomic) BOOL	keyboardIsDisappearing;

@end


#pragma mark -
@implementation XUITextViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		_textViewContentInsets = UIEdgeInsetsMake(15.0, 10.0, 15.0, 10.0);
		_textViewScrollIndicatorInsets = UIEdgeInsetsZero;
	}
	return self;
}


#pragma mark -

- (void)loadView {
	[self loadTextStack];
	[self loadTextView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self.textView];
	[center addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self.textView];
	[center addObserver:self selector:@selector(updateCursor:) name:UITextViewTextDidChangeNotification object:self.textView];
	[center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[center addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
	[center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
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
	[center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[center removeObserver:self name:UIKeyboardDidShowNotification object:nil];
	[center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	
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

#pragma mark -

- (void)loadTextStack {
	//overwrite
}

- (void)loadTextView {
	CGRect bounds = [[UIScreen mainScreen] bounds];
	
	XUITextView *textView = [[XUITextView alloc] initWithFrame:bounds textContainer:self.textContainer];
	[textView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
	[textView setKeyboardDismissMode:UIScrollViewKeyboardDismissModeInteractive];
	[textView setScrollIndicatorInsets:self.textViewScrollIndicatorInsets];
	[textView setIndicatorStyle:UIScrollViewIndicatorStyleBlack];
	[textView setTextContentInsets:self.textViewContentInsets];
	[textView setBackgroundColor:[UIColor whiteColor]];
	[textView setAlwaysBounceVertical:YES];
	[textView setScrollEnabled:YES];
	[textView setDelegate:self];
	
	[self setTextView:textView];
	[self setView:textView];
}


#pragma mark - private methods

- (void)beginEditing:(NSNotification *)notification {
	[super setEditing:YES animated:YES];
}

- (void)endEditing:(NSNotification *)notification {
	id<UIViewControllerTransitionCoordinator> coordinator = [self transitionCoordinator];
	
	BOOL shouldReselect = [coordinator isAnimated];
	[self setShouldReselectTextView:shouldReselect];
	
	if (!shouldReselect) {
		[super setEditing:NO animated:YES];
	}
}

- (void)updateCursor:(NSNotification *)notification {
	CGRect caretRect = [self.textView currentCurserRect];
	[self.textView scrollRectToVisible:caretRect animated:NO];
}

- (void)keyboardWillShow:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];
	CGRect rect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	rect = [self.view.window convertRect:rect toView:self.view];
	rect = CGRectIntersection(rect, self.view.bounds);
	
	if (!CGRectIsEmpty(rect)) {
		CGFloat height = CGRectGetHeight(rect);
		UIEdgeInsets scrollIndicatorInsets = [self textViewScrollIndicatorInsets];
		scrollIndicatorInsets.bottom = (scrollIndicatorInsets.bottom + height);
		[self.textView setScrollIndicatorInsets:scrollIndicatorInsets];
		
		UIEdgeInsets insets = [self textViewContentInsets];
		insets.bottom = (insets.bottom + height);
		[self.textView setTextContentInsets:insets];
		
		[self setKeyboardIsDisappearing:NO];
	}
}

- (void)keyboardDidShow:(NSNotification *)notification {
	if ([self.textView isFirstResponder]) {
		[self.textView makeCursorVisibleAnimated:NO];
	}
}

- (void)keyboardWillHide:(NSNotification *)notification {
	[self setKeyboardIsDisappearing:YES];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		if (self.keyboardIsDisappearing) {
			[self.textView setScrollIndicatorInsets:self.textViewScrollIndicatorInsets];
			[self.textView setTextContentInsets:self.textViewContentInsets];
		}
	});
}

@end
