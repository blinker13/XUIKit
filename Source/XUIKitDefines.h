//
//  XUIKitDefines.h
//  XUIKit
//
//  Created by Felix Gabel on 24/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;


#define XUIIdiomIsPhone()	(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define XUIIdiomIsPad()		(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define XUIViewFlexibleSize				(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
#define XUIViewFlexibleHorizontalMargin	(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin)
#define XUIViewFlexibleVerticalMargin	(UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin)
#define XUIViewFlexibleMargin			(XUIViewAutoresizingFlexibleHorizontalMargin | XUIViewAutoresizingFlexibleVerticalMargin)
