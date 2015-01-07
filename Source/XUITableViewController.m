//
//  XUITableViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewController.h"


@implementation XUITableViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self deselectTableViewRowsAnimated:animated];
}


#pragma mark - private

- (void)deselectTableViewRowsAnimated:(BOOL)animated {
	NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
	
	if (indexPath && self.clearsSelectionOnViewWillAppear) {
		id<UIViewControllerTransitionCoordinator> coordinator = [self transitionCoordinator];
		
		if ([coordinator initiallyInteractive]) {
			UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
			
			[coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				[cell.selectedBackgroundView setAlpha:0.0];
				
			} completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				if (![context isCancelled]) {
					[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
				}
			}];
			
			[coordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
				if (![context isCancelled]) {
					[cell setHighlighted:NO animated:NO];
				}
			}];
			
		} else {
			[self.tableView deselectRowAtIndexPath:indexPath animated:animated];
		}
	}
}

@end
