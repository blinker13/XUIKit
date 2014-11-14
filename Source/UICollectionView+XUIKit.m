//
//  UICollectionView+XUIKit.m
//  XUIKit
//
//  Created by Felix Gabel on 13/02/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "UICollectionView+XUIKit.h"
#import "NSBundle+XUIKit.h"


@implementation UICollectionView (XUIKit)

- (void)registerCellClass:(Class)cellClass {
	NSString *identifier = NSStringFromClass(cellClass);
	UINib *nib = [[NSBundle mainBundle] existingNibWithName:identifier];
	if (nib) [self registerNib:nib forCellWithReuseIdentifier:identifier];
	else [self registerClass:cellClass forCellWithReuseIdentifier:identifier];
}

- (id)dequeueReusableCell:(Class)cellClass forIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = NSStringFromClass(cellClass);
	return [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)registerHeaderClass:(Class)headerClass {
	NSString *identifier = NSStringFromClass(headerClass);
	UINib *nib = [[NSBundle mainBundle] existingNibWithName:identifier];
	if (nib) [self registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
	else [self registerClass:headerClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
}

- (id)dequeueReusableHeader:(Class)headerClass forIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = NSStringFromClass(headerClass);
	NSString *kind = UICollectionElementKindSectionHeader;
	return [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
}

- (void)registerFooterClass:(Class)footerClass {
	NSString *identifier = NSStringFromClass(footerClass);
	UINib *nib = [[NSBundle mainBundle] existingNibWithName:identifier];
	if (nib) [self registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
	else [self registerClass:footerClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
}

- (id)dequeueReusableFooter:(Class)footerClass forIndexPath:(NSIndexPath *)indexPath {
	NSString *identifier = NSStringFromClass(footerClass);
	NSString *kind = UICollectionElementKindSectionFooter;
	return [self dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
}

@end
