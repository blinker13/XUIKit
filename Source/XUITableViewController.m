//
//  XUITableViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewController.h"
#import "XUIKitDefines.h"
#import "XUILabel.h"


NSString *const XUITableViewRestorationKey		=	@"XUITableViewRestorationKey";
NSString *const XUITableViewClearsSelectionKey	=	@"XUITableViewClearsSelectionKey";


@interface XUITableViewController ()

@property (nonatomic, strong) IBOutlet XUITableView	*tableView;
@property (nonatomic) UITableViewStyle	style;

@end


#pragma mark -
@implementation XUITableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		_clearsSelectionOnViewWillAppear = YES;
		_style = style;
	}
	return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	return [self initWithStyle:UITableViewStylePlain];
}


#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	if (!self.tableView) {
		CGRect bounds = [self.view bounds];
		
		XUITableView *tableView = [[XUITableView alloc] initWithFrame:bounds style:self.style];
		[tableView setRestorationIdentifier:XUITableViewRestorationKey];
		[tableView setDataSource:self];
		[tableView setDelegate:self];
		
		[self.view addSubview:tableView];
		[self setTableView:tableView];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	
	if (indexPath && self.clearsSelectionOnViewWillAppear) {
		id<UIViewControllerTransitionCoordinator> coordinator = [self transitionCoordinator];
		
		if ([coordinator initiallyInteractive]) {
			[coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
				[cell.selectedBackgroundView setAlpha:0.0];
			} completion:nil];
			
			[coordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				if (![context isCancelled]) {
					[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
				}
			}];
			
		} else {
			[self.tableView deselectRowAtIndexPath:indexPath animated:animated];
		}
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[self.tableView setEditing:editing animated:animated];
	[super setEditing:editing animated:animated];
}


#pragma mark -

- (NSString *)placeholder {
	return [self.tableView.placeholderLabel text];
}

- (void)setPlaceholder:(NSString *)placeholder {
	XUILabel *label = [self.tableView placeholderLabel];
	[label setText:placeholder];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


#pragma mark - UIStateRestoring

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
	[super encodeRestorableStateWithCoder:coder];
	
	BOOL value = [self clearsSelectionOnViewWillAppear];
	[coder encodeBool:value forKey:XUITableViewClearsSelectionKey];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
	[super decodeRestorableStateWithCoder:coder];
	
	BOOL value = [coder decodeBoolForKey:XUITableViewClearsSelectionKey];
	[self setClearsSelectionOnViewWillAppear:value];
}


#pragma mark - private methods

- (void)keyboardWillShow:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];
	CGRect rect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	rect = [self.tableView.window convertRect:rect toView:self.tableView];
	rect = CGRectIntersection(rect, self.tableView.bounds);
	
	if (!CGRectIsEmpty(rect)) {
		CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
		NSUInteger curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
		UIViewAnimationOptions options = (curve << 16);
		
		CGFloat height = CGRectGetHeight(rect);
		UIEdgeInsets scrollIndicatorInsets = [self.tableView scrollIndicatorInsets];
		scrollIndicatorInsets.bottom = (scrollIndicatorInsets.bottom + height);
		UIEdgeInsets insets = [self.tableView contentInset];
		insets.bottom = (insets.bottom + height);
		
		[UIView animateWithDuration:duration delay:0.0 options:options animations:^{
			[self.tableView setScrollIndicatorInsets:scrollIndicatorInsets];
			[self.tableView setContentInset:insets];
		} completion:nil];
	}
}

- (void)keyboardWillHide:(NSNotification *)notification {
	NSDictionary *userInfo = [notification userInfo];
	CGRect rect = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
	rect = [self.tableView.window convertRect:rect toView:self.tableView];
	rect = CGRectIntersection(rect, self.tableView.bounds);
	
	if (!CGRectIsEmpty(rect)) {
		CGFloat duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
		NSUInteger curve = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] unsignedIntegerValue];
		UIViewAnimationOptions options = (curve << 16);
		
		CGFloat height = CGRectGetHeight(rect);
		UIEdgeInsets scrollIndicatorInsets = [self.tableView scrollIndicatorInsets];
		scrollIndicatorInsets.bottom = (scrollIndicatorInsets.bottom - height);
		UIEdgeInsets insets = [self.tableView contentInset];
		insets.bottom = (insets.bottom - height);
		
		[UIView animateWithDuration:duration delay:0.0 options:options animations:^{
			[self.tableView setScrollIndicatorInsets:scrollIndicatorInsets];
			[self.tableView setContentInset:insets];
		} completion:nil];
	}
}

@end
