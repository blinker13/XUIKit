//
//  XUITableViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUITableViewController.h"


const CGFloat XUITableViewCellDeSelectionDuration	=	0.35;
const CGFloat XUITableViewCellDeSelectionDelay		=	0.30;


@interface XUITableViewController ()

@property (nonatomic) BOOL	shouldClearSelection;

@end


#pragma mark -
@implementation XUITableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
	if ((self = [super initWithStyle:style])) {
		_shouldClearSelection = YES;
	}
	return self;
}

//- (void)loadView {
//	//TODO: XUITableView
//}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	//we need to disable automatic deselection for our custom deselection behavior
	[super setClearsSelectionOnViewWillAppear:NO];
	
	//my prefered seperator style
	[self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.tableView setBackgroundColor:[UIColor whiteColor]];
}
	

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (![self isMovingToParentViewController] && [self clearsSelectionOnViewWillAppear]) {
		id<UIViewControllerTransitionCoordinator> coordinator = [self transitionCoordinator];
		NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
		
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
			}];
			
			dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(XUITableViewCellDeSelectionDelay * NSEC_PER_SEC));
			dispatch_after(time, dispatch_get_main_queue(), ^(void){
				[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
			});
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


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return UITableViewAutomaticDimension;
}

@end
