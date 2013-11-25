//
//  XUITableViewController.h
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUIViewController.h"


@interface XUITableViewController : XUIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) UITableView		*tableView;
@property (nonatomic) BOOL	clearsSelectionOnViewWillAppear;


- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
