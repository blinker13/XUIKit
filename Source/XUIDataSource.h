//
//  XUIDataSource.h
//  XUIKit
//
//  Created by Felix Gabel on 17/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreData;
@import UIKit;

@class XUIDataSource;


@protocol XUIDataSourceDelegate <NSObject>

- (UITableViewCell *)dataSource:(XUIDataSource *)dataSource cellForObject:(NSManagedObject *)item atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)dataSourceWillChangeContent:(XUIDataSource *)dataSource;

- (void)dataSource:(XUIDataSource *)dataSource didInsertObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(XUIDataSource *)dataSource didDeleteObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(XUIDataSource *)dataSource didMoveObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)destination;
- (void)dataSource:(XUIDataSource *)dataSource didUpdateObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;

- (void)dataSourceDidChangeContent:(XUIDataSource *)dataSource;

@end


@interface XUIDataSource : NSObject

@property (nonatomic, weak) id<XUIDataSourceDelegate>	delegate;


+ (NSString *)cacheName;

- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request NS_DESIGNATED_INITIALIZER;

@end
