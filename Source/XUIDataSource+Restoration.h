//
//  XUIDataSource+Restoration.h
//  XUIKit
//
//  Created by Felix Gabel on 14/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIDataSource.h"


@interface XUIDataSource (Restoration) <UIDataSourceModelAssociation>

- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)indexPath inView:(UIView *)view;
- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view;

@end
