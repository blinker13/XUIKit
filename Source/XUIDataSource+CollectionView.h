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

- (void)dataSourceWillChangeContent:(XUIDataSource *)dataSource;
- (void)dataSourceDidChangeContent:(XUIDataSource *)dataSource;

- (void)dataSource:(XUIDataSource *)dataSource didInsertSection:(NSUInteger)section;
- (void)dataSource:(XUIDataSource *)dataSource didDeleteSection:(NSUInteger)section;

- (void)dataSource:(XUIDataSource *)dataSource didInsertObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(XUIDataSource *)dataSource didUpdateObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(XUIDataSource *)dataSource didDeleteObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(XUIDataSource *)dataSource didMoveObject:(NSManagedObject *)object fromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

- (UICollectionViewCell *)dataSource:(XUIDataSource *)dataSource cellForObject:(NSManagedObject *)item atIndexPath:(NSIndexPath *)indexPath;

@end
