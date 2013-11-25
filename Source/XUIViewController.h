//
//  XUIViewController.h
//  XUIKit
//
//  Created by Felix Gabel on 22/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface XUIViewController : UIViewController

@property (nonatomic, readonly) UIBarButtonItem	*addButtonItem;

- (void)viewChangedContentHeight:(CGFloat)height;
- (void)add:(id)sender;

@end
