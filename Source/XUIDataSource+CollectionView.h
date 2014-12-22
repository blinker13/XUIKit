//
//  XUIDataSource+CollectionView.h
//  XUIKit
//
//  Created by Felix Gabel on 14/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIDataSource.h"


@interface XUIDataSource (CollectionView) <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -

@interface UICollectionViewController (DataSource) <XUIDataSourceDelegate>

- (void)dataSourceWillChangeContent:(CDKDataSource *)dataSource;
- (void)dataSourceDidChangeContent:(CDKDataSource *)dataSource;

- (void)dataSource:(CDKDataSource *)dataSource didInsertSection:(NSUInteger)section;
- (void)dataSource:(CDKDataSource *)dataSource didDeleteSection:(NSUInteger)section;

- (void)dataSource:(CDKDataSource *)dataSource didInsertObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CDKDataSource *)dataSource didUpdateObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CDKDataSource *)dataSource didDeleteObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(CDKDataSource *)dataSource didMoveObject:(NSManagedObject *)object fromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

- (UICollectionViewCell *)dataSource:(XUIDataSource *)dataSource cellForObject:(NSManagedObject *)item atIndexPath:(NSIndexPath *)indexPath;

@end
