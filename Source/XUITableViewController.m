//
//  XUITableViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewController.h"


@interface XUITableViewController ()

@property (nonatomic) BOOL	shouldClearSelection;

@end


@implementation XUITableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithStyle:style])) {
		_shouldClearSelection = YES;
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[super setClearsSelectionOnViewWillAppear:NO];
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setBackgroundColor:[UIColor whiteColor]];
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


#pragma mark - 

- (BOOL)clearsSelectionOnViewWillAppear {
	return self.shouldClearSelection;
}

- (void)setClearsSelectionOnViewWillAppear:(BOOL)clearsSelectionOnViewWillAppear {
	[self setShouldClearSelection:clearsSelectionOnViewWillAppear];
}

@end
