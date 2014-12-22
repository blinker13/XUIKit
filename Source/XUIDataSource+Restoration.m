//
//  XUIDataSource+Restoration.m
//  XUIKit
//
//  Created by Felix Gabel on 14/11/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIDataSource+Restoration.h"


@implementation XUIDataSource (Restoration)

- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)indexPath inView:(UIView *)view {
	NSManagedObject *object = [self objectAtIndexPath:indexPath];
	return [object.objectURI absoluteString];
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view {
	
	NSURL *uri = [[NSURL alloc] initWithString:identifier];
	NSManagedObject *object = [self.context managedObjectForObjectURI:uri];
	
	if (object) {
		return [self indexPathForObject:object];
	}
	
	return nil;
}

@end
