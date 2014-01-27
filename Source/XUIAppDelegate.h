//
//  XUIAppDelegate.h
//  XUIKit
//
//  Created by Felix Gabel on 23/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface XUIAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow	*window;


- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder;
- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder;

@end
