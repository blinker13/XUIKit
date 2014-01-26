//
//  XUITableView.h
//  XUIKit
//
//  Created by Felix Gabel on 25/01/14.
//  Copyright (c) 2014 Felix Gabel. All rights reserved.
//

@import UIKit;

@class XUILabel;


@interface XUITableView : UITableView

@property (nonatomic, readonly) XUILabel	*placeholderLabel;

@property (nonatomic) BOOL	hidesTableHeaderWhenEmpty;
@property (nonatomic) BOOL	hidesTableFooterWhenEmpty;

@end
