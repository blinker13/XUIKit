//
//  NSBundle+XUIKit.h
//  XUIKit
//
//  Created by Felix Gabel on 23/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;


@interface NSBundle (XUIKit)

+ (NSString *)mainBundleVersion;

- (UINib *)existingNibWithName:(NSString *)name;

@end
