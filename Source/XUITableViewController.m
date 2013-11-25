//
//  XUITableViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewController.h"


@interface XUITableViewController ()

@property (nonatomic, readwrite) IBOutlet UITableView	*tableView;
@property (nonatomic) UITableViewStyle	style;

@end


@implementation XUITableViewController


#pragma mark - initialization

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
	[self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (![self isMovingToParentViewController] && [self clearsSelectionOnViewWillAppear]) {
		id<UIViewControllerTransitionCoordinator> coordinator = [self transitionCoordinator];
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
		
		if ([coordinator initiallyInteractive]) {
			[coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				[cell.selectedBackgroundView setAlpha:0.0];
			} completion:nil];
			
			[coordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				if (![context isCancelled]) {
					[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
				}
			}];
			
		} else {
			[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
		}
	}
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[self.tableView setEditing:editing animated:animated];
	[super setEditing:editing animated:animated];
}

- (void)viewChangedContentHeight:(CGFloat)height {
	UIEdgeInsets insets = UIEdgeInsetsMake(0.0, 0.0, height, 0.0);
	[self.tableView setScrollIndicatorInsets:insets];
	[self.tableView setContentInset:insets];
}


#pragma mark -

- (UITableView *)tableView {
	if (!_tableView) {
		CGRect bounds = [self.view bounds];
		_tableView = [[UITableView alloc] initWithFrame:bounds style:self.style];
		[_tableView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
		[_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[_tableView setBackgroundColor:[UIColor whiteColor]];
		[_tableView setDataSource:self];
		[_tableView setDelegate:self];
	}
	return _tableView;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


//#pragma mark - OBUITableViewDelegate
//
//- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//	[self setEditing:YES animated:YES];
//}
//
//- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//	[self setEditing:NO animated:YES];
//}

@end
