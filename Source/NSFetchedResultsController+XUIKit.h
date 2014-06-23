//
//  NSFetchedResultsController+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 06/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;
@import UIKit;


@protocol XUIDataSourceDelegate <NSFetchedResultsControllerDelegate, NSObject>

- (id)controller:(NSFetchedResultsController *)controller cellForItem:(id)item atIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -

@protocol XUIDataSource <NSObject>

@property (nonatomic, weak) id<XUIDataSourceDelegate>	delegate;

@end


#pragma mark -

@interface NSFetchedResultsController (UITableViewDataSource) <UITableViewDataSource, XUIDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -

@interface NSFetchedResultsController (UICollectionViewDataSource) <UICollectionViewDataSource, XUIDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
