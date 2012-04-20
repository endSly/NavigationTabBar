//
//  EGTableController.h
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGNavigationTabBar.h"

@interface EGTableController : UIViewController <UITableViewDataSource, UITableViewDelegate, EGNavigationTabBarDataSource, EGNavigationTabBarDelegate>

@property (nonatomic, weak) IBOutlet UITableView * tableView;
@property (nonatomic, weak) IBOutlet EGNavigationTabBar * navigationTabBar;

@end
