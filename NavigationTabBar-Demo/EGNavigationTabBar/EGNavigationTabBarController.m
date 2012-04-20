//
//  EGNavigationTabBarController.m
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGNavigationTabBarController.h"

@interface EGNavigationTabBarController ()

@end

@implementation EGNavigationTabBarController

@synthesize navigationTabBar = _navigationTabBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _navigationTabBar = [[EGNavigationTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    _navigationTabBar.delegate = self;
    _navigationTabBar.dataSource = self;
    _navigationTabBar.parentViewController = self;
    [_navigationTabBar initialize];
    [_navigationTabBar reloadData];
    
    [self.view addSubview:_navigationTabBar];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [_navigationTabBar removeFromSuperview];
    _navigationTabBar = nil;
}

@end
