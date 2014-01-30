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
	return [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
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
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
	id<XUICollectionViewDelegate> delegate = (id<XUICollectionViewDelegate>)[collectionView delegate];
	[delegate collectionView:collectionView willDisplayCell:cell forItemAtIndexPath:indexPath];
	return cell;
}

@end
