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

const CGFloat XUITableViewCellDeSelectionDuration	=	0.4;


@interface XUITableViewController ()

@property (nonatomic, strong) IBOutlet XUITableView	*tableView;
@property (nonatomic) UITableViewStyle	style;

@end


#pragma mark -
@implementation XUITableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithNibName:nil bundle:nil])) {
		
		if (!self.restorationIdentifier) {
			NSString *identifier = NSStringFromClass(self.class);
			[self setRestorationIdentifier:identifier];
		}
		
		if ([self conformsToProtocol:@protocol(UIViewControllerRestoration)]) {
			[self setRestorationClass:self.class];
		}
		_clearsSelectionOnViewWillAppear = YES;
		_style = style;
	}
	return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	return [self initWithStyle:UITableViewStylePlain];
}


#pragma mark -

- (XUITableView *)tableView {
	return (XUITableView *)[self view];
}

- (void)setTableView:(XUITableView *)tableView {
	[self setView:tableView];
}

- (void)loadView {
	CGRect bounds = [[UIScreen mainScreen] bounds];
	UIColor *backgroundColor = [UIColor whiteColor];
	
	XUITableView *tableView = [[XUITableView alloc] initWithFrame:bounds style:self.style];
	[tableView setRestorationIdentifier:XUITableViewRestorationKey];
	[tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[tableView setAutoresizingMask:XUIViewFlexibleSize];
	[tableView setBackgroundColor:backgroundColor];
	[tableView setDataSource:self];
	[tableView setDelegate:self];
	
	[self setTableView:tableView];
	[self setView:tableView];
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
			
			//fading the out the selected cells background color because a custom selectedBackgroundView will fade out after -viewDidAppear or will never trigger when the transition is interactive
			[coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
				[cell.selectedBackgroundView setAlpha:0.0];
			} completion:nil];
			
			//-deselectRowAtIndexPath:animated: triggers unhighlighting of a cells labels with a timer when animated. To prevent unhighlighting in the middle of an interactive transaction we need to deselect the cell manually after the transaction is completed
			[coordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				if (![context isCancelled]) {
					[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
				}
			}];
			
		} else {
			
			[UIView animateWithDuration:XUITableViewCellDeSelectionDuration animations:^{
				UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
				[cell.selectedBackgroundView setAlpha:0.0];
				[cell setHighlighted:NO animated:NO];
								
			} completion:^(BOOL finished) {
				[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
			}];
		}
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
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
