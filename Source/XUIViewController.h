//
//  XUIViewController.h
//  XUIKit
//
//  Created by Felix Gabel on 24/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;

@class XUILabel;


@interface XUIViewController : UIViewController

@property (nonatomic, copy) NSString	*backButtonTitle;


- (UINavigationController *)contentNavigationController;

@end
