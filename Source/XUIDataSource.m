//
//  XUIDataSource.m
//  XUIKit
//
//  Created by Felix Gabel on 17/07/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIDataSource.h"


@interface XUIDataSource () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController	*results;

@end


@implementation XUIDataSource

- (instancetype)initWithContext:(NSManagedObjectContext *)context request:(NSFetchRequest *)request {
	NSAssert(context, @"XUIDataSource needs a valid context: %@", context);
	NSAssert(request, @"XUIDataSource needs a valid request: %@", request);
	
	if ((self = [super init])) {
		_results = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
		[_results setDelegate:self];
	}
	return self;
}

- (instancetype)init {
	return [self initWithContext:nil request:nil];
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	if ([self.delegate respondsToSelector:@selector(dataSourceWillChangeContent:)]) {
		[self.delegate dataSourceWillChangeContent:self];
	}
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

	
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	if ([self.delegate respondsToSelector:@selector(dataSourceDidChangeContent:)]) {
		[self.delegate dataSourceDidChangeContent:self];
	}
}

@end
