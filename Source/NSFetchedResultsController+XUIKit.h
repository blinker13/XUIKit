//
//  NSFetchedResultsController+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 06/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;
@import UIKit;


@protocol NSFetchedDataSourceDelegate <NSFetchedResultsControllerDelegate, NSObject>

- (id)controller:(NSFetchedResultsController *)controller cellForIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -
@protocol XUIFetchedDataSource <NSObject>

@property (nonatomic, weak) id<NSFetchedDataSourceDelegate>	delegate;

@end


#pragma mark -
@interface NSFetchedResultsController (UITableViewDataSource) <UITableViewDataSource, XUIFetchedDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

@end


#pragma mark -
@interface NSFetchedResultsController (UICollectionViewDataSource) <UICollectionViewDataSource, XUIFetchedDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView;

@end
