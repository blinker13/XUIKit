//
//  NSFetchedResultsController+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 06/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "NSFetchedResultsController+XUIKit.h"


@implementation NSFetchedResultsController (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> info = [self.sections objectAtIndex:section];
	return [info numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	id<NSFetchedDataSourceDelegate> delegate = (id<NSFetchedDataSourceDelegate>)[self delegate];
	id item = [self objectAtIndexPath:indexPath];
	
	return [delegate controller:self cellForItem:item atIndexPath:indexPath];
}

@end


#pragma mark -
@implementation NSFetchedResultsController (UICollectionViewDataSource)

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> info = [self.sections objectAtIndex:section];
	return [info numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	id<NSFetchedDataSourceDelegate> delegate = (id<NSFetchedDataSourceDelegate>)[self delegate];
	id item = [self objectAtIndexPath:indexPath];
	
	return [delegate controller:self cellForItem:item atIndexPath:indexPath];
}

@end
