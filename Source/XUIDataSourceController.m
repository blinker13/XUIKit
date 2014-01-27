//
//  XUIDataSourceController.m
//  XUIKit
//
//  Created by Felix Gabel on 27/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIDataSourceController.h"


@implementation XUIDataSourceController

@end


#pragma mark -
@implementation XUIDataSourceController (UITableViewDataSource)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> info = [self.sections objectAtIndex:section];
	return [info numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell<XUIFetchedDataSourceCell> *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
	id object = [self objectAtIndexPath:indexPath];
	[cell loadCellWithObject:object];
	return cell;
}

@end


#pragma mark -
@implementation XUIDataSourceController (UICollectionViewDataSource)

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return [self.sections count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	id<NSFetchedResultsSectionInfo> info = [self.sections objectAtIndex:section];
	return [info numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell<XUIFetchedDataSourceCell> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
	id object = [self objectAtIndexPath:indexPath];
	[cell loadCellWithObject:object];
	return cell;
}

@end
