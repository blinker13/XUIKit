//
//  XUITableViewController.h
//  XUIKit
//
//  Created by Felix Gabel on 21/11/13.
//  Copyright (c) 2013 Felix Gabel. All rights reserved.
//

#import "XUIViewController.h"
#import "XUITableView.h"


@interface XUITableViewController : XUIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, readonly) XUITableView	*tableView;

@property (nonatomic) UITableViewStyle	style;

@property (nonatomic) BOOL	clearsSelectionOnViewWillAppear;


- (instancetype)initWithStyle:(UITableViewStyle)style;

@end
