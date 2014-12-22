//
//  XUIDataSource+TableView.m
//  XUIKit
//
//  Created by Felix Gabel on 14/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIDataSource+TableView.h"


@implementation XUIDataSource (TableView)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self numberOfObjectsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	return (UITableViewCell *)[self.delegate dataSource:self cellForObject:self[indexPath] atIndexPath:indexPath];
}

@end


#pragma mark -

@implementation UITableViewController (DataSource)

- (void)dataSourceWillChangeContent:(CDKDataSource *)dataSource {
	[self.tableView beginUpdates];
}

- (void)dataSourceDidChangeContent:(CDKDataSource *)dataSource {
	[self.tableView endUpdates];
}

- (void)dataSource:(CDKDataSource *)dataSource didInsertSection:(NSUInteger)section {
	NSIndexSet *sections = [[NSIndexSet alloc] initWithIndex:section];
	[self.tableView insertSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)dataSource:(CDKDataSource *)dataSource didDeleteSection:(NSUInteger)section {
	NSIndexSet *sections = [[NSIndexSet alloc] initWithIndex:section];
	[self.tableView deleteSections:sections withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)dataSource:(CDKDataSource *)dataSource didInsertObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)dataSource:(CDKDataSource *)dataSource didUpdateObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
	[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)dataSource:(CDKDataSource *)dataSource didDeleteObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)dataSource:(CDKDataSource *)dataSource didMoveObject:(NSManagedObject *)object fromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath {
	[self.tableView moveRowAtIndexPath:indexPath toIndexPath:toIndexPath];
}

- (UITableViewCell *)dataSource:(XUIDataSource *)dataSource cellForObject:(NSManagedObject *)item atIndexPath:(NSIndexPath *)indexPath {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}

@end
