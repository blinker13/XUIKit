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
	return [object.objectID.URIRepresentation absoluteString];
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view {
	
	NSURL *uri = [[NSURL alloc] initWithString:identifier];
	NSPersistentStoreCoordinator *coordinator = [self.context persistentStoreCoordinator];
	NSManagedObjectID *objectID = [coordinator managedObjectIDForURIRepresentation:uri];
	NSManagedObject *object = [self.context existingObjectWithID:objectID error:nil];
	return [self indexPathForObject:object];
}

@end
