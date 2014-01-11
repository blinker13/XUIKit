//
//  XUIButton.h
//  XUIKit
//
//  Created by Felix Gabel on 11/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;
@import QuartzCore;


extern const CGFloat XUIButtonDefaultCornerRadius;
extern const CGFloat XUIButtonDefaultBorderWidth;


@interface XUIButton : UIButton

@property (nonatomic) CGFloat	cornerRadius;
@property (nonatomic) CGFloat	borderWidth;

@end
