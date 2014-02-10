//
//  XUIViewController.m
//  XUIKit
//
//  Created by Felix Gabel on 24/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

#import "XUIViewController.h"
#import "XUIKitDefines.h"
#import "XUILabel.h"


@interface XUIViewController ()

@property (nonatomic, strong) IBOutlet UIBarButtonItem	*leftBarButtonItem;
@property (nonatomic, strong) IBOutlet UIBarButtonItem	*rightBarButtonItem;
@property (nonatomic, strong) IBOutlet UIView			*titleItemView;

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

- (void)loadView {
	NSString *name = self.nibName ?: NSStringFromClass([self class]);
	NSBundle *bundle = self.nibBundle ?: [NSBundle mainBundle];
	
	if ([bundle pathForResource:name ofType:@"nib"]) {
		UINib *nib = [UINib nibWithNibName:name bundle:bundle];
		[nib instantiateWithOwner:self options:nil];
	}
	
	if (!self.titleItemView) {
		UINavigationBar *navigation = [self.navigationController navigationBar];
		NSDictionary *titleAttributes = [navigation titleTextAttributes];
		UIColor *textColor = [titleAttributes objectForKey:NSForegroundColorAttributeName];
		UIFont *font = [titleAttributes objectForKey:NSFontAttributeName];
		
		XUILabel *titleLabel = [[XUILabel alloc] initWithFrame:CGRectZero];
		if (!navigation.isTranslucent) [titleLabel setBackgroundColor:navigation.barTintColor];
		[titleLabel setTextAlignment:NSTextAlignmentCenter];
		[titleLabel setTextColor:textColor];
		[titleLabel setFont:font];
		
		[self setTitleItemView:titleLabel];
	}
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.navigationItem setLeftBarButtonItem:self.leftBarButtonItem];
	[self.navigationItem setRightBarButtonItem:self.rightBarButtonItem];
	[self.navigationItem setTitleView:self.titleItemView];
	
	UIColor *white = [UIColor whiteColor];
	[self.view setBackgroundColor:white];
	[self setBackButtonTitle:nil];
}

- (NSString *)title {
	return [self.titleItemView performSelector:@selector(text)];
}

- (void)setTitle:(NSString *)title {
	[(UILabel *)self.titleItemView setText:title];
	[self.titleItemView sizeToFit];
}


#pragma mark -

- (NSString *)backButtonTitle {
	return [super title];
}

- (void)setBackButtonTitle:(NSString *)backButtonTitle {
	backButtonTitle = (backButtonTitle.length > 0) ? backButtonTitle : @"";
	[self.navigationItem setTitle:backButtonTitle];
	[super setTitle:backButtonTitle];
}

- (UINavigationController *)contentNavigationController {
	return XUIIdiomIsPad() ? [self.splitViewController.viewControllers lastObject] : [self navigationController];
}

@end
