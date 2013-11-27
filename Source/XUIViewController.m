//
//  XUIViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 22/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUIViewController.h"


@interface XUIViewController ()

@property (nonatomic) BOOL	implementsViewChangedContentHeight;
@property (nonatomic) BOOL	keyboardIsDisappearing;

@end


@implementation XUIViewController

@synthesize addButtonItem	=	_addButtonItem;
@synthesize titleLabel		=	_titleLabel;


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		
		SEL action = @selector(viewChangedContentHeight:);
		IMP selfMethod = [[self class] instanceMethodForSelector:action];
		IMP rootMethod = [UIViewController instanceMethodForSelector:action];
		_implementsViewChangedContentHeight = (selfMethod != rootMethod);
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle:nil];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (self.implementsViewChangedContentHeight) {
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
		[center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	if (self.implementsViewChangedContentHeight) {
		NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
		[center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
		[center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	}
}

- (void)setTitle:(NSString *)title {
	[self.titleLabel setText:title];
	[self.titleLabel sizeToFit];
	[super setTitle:@""];
}


#pragma mark -

- (UIBarButtonItem *)addButtonItem {
	if (!_addButtonItem) {
		_addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
	}
	return _addButtonItem;
}

- (UILabel *)titleLabel {
	if (!_titleLabel) {
		UINavigationBar *navigation = [self.navigationController navigationBar];
		NSDictionary *titleAttributes = [navigation titleTextAttributes];
		UIColor *textColor = [titleAttributes objectForKey:NSForegroundColorAttributeName];
		UIFont *font = [titleAttributes objectForKey:NSFontAttributeName];
		
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		[_titleLabel setTextAlignment:NSTextAlignmentCenter];
		[_titleLabel setTextColor:textColor];
		[_titleLabel setFont:font];
		
		[self.navigationItem setTitleView:_titleLabel];
	}
	return _titleLabel;
}

- (void)viewChangedContentHeight:(CGFloat)height {
	//abstract method
}

- (void)add:(id)sender {
	[self doesNotRecognizeSelector:_cmd];
}


#pragma mark - private methods

- (void)keyboardWillShow:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];
	CGRect rect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	rect = [self.view.window convertRect:rect toView:self.view];
	rect = CGRectIntersection(rect, self.view.bounds);
	
	if (!CGRectIsEmpty(rect)) {
		CGFloat height = CGRectGetHeight(rect);
		[self viewChangedContentHeight:height];
		[self setKeyboardIsDisappearing:NO];
	}
}

- (void)keyboardWillHide:(NSNotification *)notification {
	[self setKeyboardIsDisappearing:YES];
	
	dispatch_async(dispatch_get_main_queue(), ^{
		if (self.keyboardIsDisappearing) {
			[self viewChangedContentHeight:0.0];
		}
	});
}

@end
