//
//  EGNavigationTabBarController.h
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGNavigationTabBar.h"

@interface EGNavigationTabBarController : UIViewController <EGNavigationTabBarDataSource, EGNavigationTabBarDelegate>

@property (nonatomic, readonly) EGNavigationTabBar * navigationTabBar;

@end
