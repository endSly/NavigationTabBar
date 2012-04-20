//
//  EGViewController.h
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EGNavigationTabBar.h"

@interface EGViewController : UIViewController <EGNavigationTabBarDataSource, EGNavigationTabBarDelegate> 

@property (nonatomic, assign) IBOutlet EGNavigationTabBar * tabBar;

@end
