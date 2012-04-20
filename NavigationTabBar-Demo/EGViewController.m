//
//  EGViewController.m
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "EGViewController.h"

@interface EGViewController ()

@end

@implementation EGViewController

@synthesize tabBar;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tabBar.dataSource = self;
    self.tabBar.delegate = self;
    
    self.tabBar.clipsToBounds = NO;
    self.tabBar.layer.shadowOpacity = 0.8;
    self.tabBar.layer.shadowOffset = CGSizeZero;
    
    [self.tabBar reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSUInteger)navigationTabBarTabsCount:(EGNavigationTabBar *)tabBar
{
    return 4;
}

- (NSString *)navigationTabBar:(EGNavigationTabBar *)tabBar titleForTabIndex:(NSUInteger)tabIndex
{
    switch (tabIndex) {
        case 0:
            return @"Que ver";
        case 1:
            return @"Que hacer";
        case 2:
            return @"Donde comer";
        case 3:
            return @"Donde dormir";
            
    }
    return @"";
}

- (UIViewController *)navigationTabBar:(EGNavigationTabBar *)tabBar viewControllerForTabIndex:(NSUInteger)tabIndex
{
    return nil;
}

@end
