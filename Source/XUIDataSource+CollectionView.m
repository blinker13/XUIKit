//
//  XUIDataSource+CollectionView.m
//  XUIKit
//
//  Created by Felix Gabel on 14/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIDataSource+CollectionView.h"


@implementation XUIDataSource (CollectionView)

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return [self numberOfSections];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [self numberOfObjectsInSection:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	return (UICollectionViewCell *)[self.delegate dataSource:self cellForObject:self[indexPath] atIndexPath:indexPath];
}

@end


#pragma mark -

@implementation UICollectionViewController (DataSource)

- (void)dataSourceWillChangeContent:(XUIDataSource *)dataSource {
//	[self.collectionView ]
}

- (void)dataSourceDidChangeContent:(XUIDataSource *)dataSource {
	
}

- (void)dataSource:(XUIDataSource *)dataSource didInsertSection:(NSUInteger)section {
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:section];
	[self.collectionView insertSections:indexes];
}

- (void)dataSource:(XUIDataSource *)dataSource didDeleteSection:(NSUInteger)section {
	NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:section];
	[self.collectionView deleteSections:indexes];
}

- (void)dataSource:(XUIDataSource *)dataSource didInsertObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
	[self.collectionView insertItemsAtIndexPaths:@[indexPath]];
}

- (void)dataSource:(XUIDataSource *)dataSource didUpdateObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
	[self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)dataSource:(XUIDataSource *)dataSource didDeleteObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath {
	[self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)dataSource:(XUIDataSource *)dataSource didMoveObject:(NSManagedObject *)object fromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath {
	[self.collectionView moveItemAtIndexPath:indexPath toIndexPath:toIndexPath];
}

- (UICollectionViewCell *)dataSource:(XUIDataSource *)dataSource cellForObject:(NSManagedObject *)item atIndexPath:(NSIndexPath *)indexPath {
	[self doesNotRecognizeSelector:_cmd];
	return nil;
}


@end
