//
//  XUIDataSourceController.h
//  XUIKit
//
//  Created by Felix Gabel on 27/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;
@import UIKit;


@protocol XUIFetchedDataSourceCell <NSObject>

- (void)loadCellWithObject:(id)object;

@end


#pragma mark -
@interface XUIDataSourceController : NSFetchedResultsController

@property (nonatomic, copy) NSString	*cellIdentifier;

@end


#pragma mark -
@interface XUIDataSourceController (UITableViewDataSource) <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -
@interface XUIDataSourceController (UICollectionViewDataSource) <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
