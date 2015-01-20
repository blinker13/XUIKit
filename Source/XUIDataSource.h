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

- (void)dataSourceWillChangeContent:(XUIDataSource *)dataSource;
- (void)dataSourceDidChangeContent:(XUIDataSource *)dataSource;

- (void)dataSource:(XUIDataSource *)dataSource didInsertSection:(NSUInteger)section;
- (void)dataSource:(XUIDataSource *)dataSource didDeleteSection:(NSUInteger)section;

- (void)dataSource:(XUIDataSource *)dataSource didInsertObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(XUIDataSource *)dataSource didUpdateObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(XUIDataSource *)dataSource didDeleteObject:(NSManagedObject *)object atIndexPath:(NSIndexPath *)indexPath;
- (void)dataSource:(XUIDataSource *)dataSource didMoveObject:(NSManagedObject *)object fromIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath;

- (UIView *)dataSource:(XUIDataSource *)dataSource cellForObject:(NSManagedObject *)item atIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -

@interface XUIDataSource : NSObject

@property (nonatomic, weak) id<XUIDataSourceDelegate>	delegate;

@property (nonatomic, readonly) NSManagedObjectContext	*context;
@property (nonatomic, readonly) NSFetchRequest			*request;

@property (nonatomic, readonly) NSString	*sectionKey;
@property (nonatomic, readonly) NSString	*cacheName;


- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context shouldSectionResults:(BOOL)shouldSectionResults cacheName:(NSString *)cacheName NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context shouldSectionResults:(BOOL)shouldSectionResults;
- (instancetype)initWithRequest:(NSFetchRequest *)request context:(NSManagedObjectContext *)context;


- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section;

- (NSIndexPath *)indexPathForObject:(NSManagedObject *)object;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end


#pragma mark -

@interface XUIDataSource (Subscripting)

- (id)objectForKeyedSubscript:(NSIndexPath *)key;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end
