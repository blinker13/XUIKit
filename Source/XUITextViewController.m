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

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		_textViewContentInsets = UIEdgeInsetsMake(6.0, 0.0, 6.0, 0.0);
		_textViewScrollIndicatorInsets = UIEdgeInsetsZero;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.view addSubview:self.textView];
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
	[center removeObserver:self name:UITextViewTextDidBeginEditingNotification object:nil];
	[center removeObserver:self name:UITextViewTextDidEndEditingNotification object:nil];
	[center removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
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
	
	UIEdgeInsets contentInsets = [self textViewContentInsets];
	contentInsets.bottom = (contentInsets.bottom + height);
	[self.textView setContentInset:contentInsets];
	
	[self.textView setTextContainerInset:UIEdgeInsetsZero];
}


#pragma mark -

- (NSTextContainer *)textContainer {
	return nil;
}

- (UITextView *)textView {
	if (!_textView) {
		CGRect bounds = [self.view bounds];
		_textView = [[UITextView alloc] initWithFrame:bounds textContainer:self.textContainer];
		[_textView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
		[_textView setScrollIndicatorInsets:self.textViewScrollIndicatorInsets];
		[_textView setContentInset:self.textViewContentInsets];
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
	if ([notification object] == self.textView) {
		[super setEditing:YES animated:YES];
	}
}

- (void)endEditingText:(NSNotification *)notification {
	if ([notification object] == self.textView) {
		id<UIViewControllerTransitionCoordinator> coordinator = [self transitionCoordinator];
		
		BOOL shouldReselect = [coordinator isAnimated];
		[self setShouldReselectTextView:shouldReselect];
		
		if (!shouldReselect) {
			[super setEditing:NO animated:YES];
		}
	}
}

- (void)updateCursorVisibility:(NSNotification *)notification {
	if ([notification object] == self.textView) {
		CGRect caretRect = [self.textView currentCurserRect];
		[self.textView scrollRectToVisible:caretRect animated:NO];
	}
}

- (void)makeCursorVisible:(NSNotification *)notification {
	
	if ([self.textView isFirstResponder]) {
		[self.textView makeCursorVisibleAnimated:NO];
	}
}

@end
