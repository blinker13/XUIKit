//
//  XUIFetchedDataSource.h
//  XUIKit
//
//  Created by Felix Gabel on 27/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;
@import UIKit;


//Remove as soon as Apple introduces this method
@protocol XUICollectionViewDelegate <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface XUIFetchedDataSource : NSFetchedResultsController

@property (nonatomic, copy) NSString	*cellIdentifier;

@end


#pragma mark -
@interface XUIFetchedDataSource (UITableViewDataSource) <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -
@interface XUIFetchedDataSource (UICollectionViewDataSource) <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
