//
//  XUIViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 24/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIViewController.h"
#import "XUILabel.h"


@interface XUIViewController ()

@property (nonatomic, strong) IBOutlet UIView			*navigationTitleView;
@property (nonatomic, strong) IBOutlet UIBarButtonItem	*rightBarButtonItem;
@property (nonatomic, strong) IBOutlet UIBarButtonItem	*leftBarButtonItem;

@end


#pragma mark -
@implementation XUIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		
		if ([self conformsToProtocol:@protocol(UIViewControllerRestoration)]) {
			[self setRestorationClass:self.class];
		}
		
		if (!self.restorationIdentifier) {
			NSString *identifier = NSStringFromClass(self.class);
			[self setRestorationIdentifier:identifier];
		}
    }
    return self;
}


#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setTitle:@""];
	
	if (!self.navigationTitleView) {
		UINavigationBar *navigation = [self.navigationController navigationBar];
		NSDictionary *titleAttributes = [navigation titleTextAttributes];
		UIColor *textColor = [titleAttributes objectForKey:NSForegroundColorAttributeName];
		UIFont *font = [titleAttributes objectForKey:NSFontAttributeName];
		
		XUILabel *titleLabel = [[XUILabel alloc] initWithFrame:CGRectZero];
		if (!navigation.isTranslucent) [titleLabel setBackgroundColor:navigation.barTintColor];
		[titleLabel setTextAlignment:NSTextAlignmentCenter];
		[titleLabel setTextColor:textColor];
		[titleLabel setFont:font];
		
		[self setNavigationTitleView:titleLabel];
	}
	[self.navigationItem setRightBarButtonItem:self.rightBarButtonItem];
	[self.navigationItem setLeftBarButtonItem:self.leftBarButtonItem];
	[self.navigationItem setTitleView:self.navigationTitleView];
}

- (NSString *)navigationTitle {
	if ([self.navigationTitleView respondsToSelector:@selector(text)]) {
		return [self.navigationTitleView performSelector:@selector(text)];
	}
	return nil;
}

- (void)setNavigationTitle:(NSString *)navigationTitle {
	if ([self.navigationTitleView respondsToSelector:@selector(setText:)]) {
		[self.navigationTitleView performSelector:@selector(setText:) withObject:navigationTitle];
		[self.navigationTitleView sizeToFit];
	}
}

@end
