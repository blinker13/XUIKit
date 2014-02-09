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

@property (nonatomic, strong) XUILabel	*titleItemLabel;

@end


#pragma mark -
@implementation XUIViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		
		if ([self conformsToProtocol:@protocol(UIViewControllerRestoration)]) {
			[self setRestorationClass:self.class];
		}
		NSString *identifier = NSStringFromClass(self.class);
		[self setRestorationIdentifier:identifier];
    }
    return self;
}


#pragma mark -

- (void)loadView {
	NSString *nibName = self.nibName ?: NSStringFromClass([self class]);
	UINib *nib = [UINib nibWithNibName:nibName bundle:self.nibBundle];
	[nib instantiateWithOwner:self options:nil];
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.navigationItem setTitleView:self.titleItemLabel];
	
	UIColor *white = [UIColor whiteColor];
	[self.view setBackgroundColor:white];
	
	[self setBackButtonTitle:nil];
	[self loadTitleItemLabel];
}

- (NSString *)title {
	return [self.titleItemLabel text];
}

- (void)setTitle:(NSString *)title {
	[self.titleItemLabel setText:title];
	[self.titleItemLabel sizeToFit];
}


#pragma mark -

- (XUILabel *)titleItemLabel {
	if (!_titleItemLabel) {
		_titleItemLabel = [[XUILabel alloc] initWithFrame:CGRectZero];
		[_titleItemLabel setTextAlignment:NSTextAlignmentCenter];
	}
	return _titleItemLabel;
}

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


#pragma mark - private methods

- (void)loadTitleItemLabel {
	UINavigationBar *navigation = [self.navigationController navigationBar];
	NSDictionary *titleAttributes = [navigation titleTextAttributes];
	UIColor *textColor = [titleAttributes objectForKey:NSForegroundColorAttributeName];
	UIFont *font = [titleAttributes objectForKey:NSFontAttributeName];
	
	if (!navigation.isTranslucent) [self.titleItemLabel setBackgroundColor:navigation.barTintColor];
	[self.titleItemLabel setTextColor:textColor];
	[self.titleItemLabel setFont:font];
}

@end
