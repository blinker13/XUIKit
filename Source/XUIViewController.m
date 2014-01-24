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
		
		NSString *identifier = NSStringFromClass(self.class);
		[self setRestorationIdentifier:identifier];
		
		if ([self conformsToProtocol:@protocol(UIViewControllerRestoration)]) {
			[self setRestorationClass:self.class];
		}
		[self setBackButtonTitle:@""];
    }
    return self;
}


#pragma mark -

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIColor *white = [UIColor whiteColor];
	[self.view setBackgroundColor:white];
}

- (NSString *)title {
	return [self.titleItemLabel text];
}

- (void)setTitle:(NSString *)title {
	[self.titleItemLabel setText:title];
}


#pragma mark -

- (XUILabel *)titleItemLabel {
	if (!_titleItemLabel) {
		UINavigationBar *navigation = [self.navigationController navigationBar];
		NSDictionary *titleAttributes = [navigation titleTextAttributes];
		UIColor *textColor = [titleAttributes objectForKey:NSForegroundColorAttributeName];
		UIFont *font = [titleAttributes objectForKey:NSFontAttributeName];
		
		_titleItemLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		if (!navigation.isTranslucent) [_titleItemLabel setBackgroundColor:navigation.barTintColor];
		[_titleItemLabel setTextAlignment:NSTextAlignmentCenter];
		[_titleItemLabel setTextColor:textColor];
		[_titleItemLabel setFont:font];
		
		[self.navigationItem setTitleView:_titleItemLabel];
		[_titleItemLabel sizeToFit];
	}
	return _titleItemLabel;
}

- (NSString *)backButtonTitle {
	return [self title];
}

- (void)setBackButtonTitle:(NSString *)backButtonTitle {
	[self setTitle:backButtonTitle];
}

- (UINavigationController *)contentNavigationController {
	return XUIIdiomIsPad() ? [self.splitViewController.viewControllers lastObject] : [self navigationController];
}

@end
