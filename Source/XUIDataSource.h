//
//  XUIDataSource.h
//  XUIKit
//
//  Created by Felix Gabel on 17/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import CoreDataKit;
@import UIKit;

@class XUIDataSource;


@protocol XUIDataSourceDelegate <CDKDataSourceDelegate>

- (UIView *)dataSource:(XUIDataSource *)dataSource cellForObject:(NSManagedObject *)item atIndexPath:(NSIndexPath *)indexPath;

@end


@interface XUIDataSource : CDKDataSource

@property (nonatomic, weak) id<XUIDataSourceDelegate>	delegate;

@end
