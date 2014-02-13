//
//  UICollectionView+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 13/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface UICollectionView (XUIKit)

- (void)registerCellClass:(Class)cellClass;
- (id)dequeueReusableCell:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath;

- (void)registerHeaderClass:(Class)headerClass;
- (id)dequeueReusableHeader:(Class)headerClass forIndexPath:(NSIndexPath *)indexPath;

- (void)registerFooterClass:(Class)footerClass;
- (id)dequeueReusableFooter:(Class)footerClass forIndexPath:(NSIndexPath *)indexPath;

@end
