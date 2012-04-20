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

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationTabBar.clipsToBounds = NO;
    self.navigationTabBar.layer.shadowOpacity = 0.8;
    self.navigationTabBar.layer.shadowOffset = CGSizeZero;
    
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

- (UIColor *)navigationTabBar:(EGNavigationTabBar *)tabBar colorForTabIndex:(NSUInteger)tabIndex
{
    switch (tabIndex) {
        case 0:
            return [UIColor redColor];
        case 1:
            return [UIColor colorWithRed:0.2 green:0.7 blue:0.1 alpha:1];
        case 2:
            return [UIColor colorWithRed:0.4 green:0.4 blue:0.9 alpha:1];
        case 3:
            return [UIColor grayColor];
            
    }
    return nil;
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
    return nil;
}

- (UIViewController *)navigationTabBar:(EGNavigationTabBar *)tabBar viewControllerForTabIndex:(NSUInteger)tabIndex
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:@"Table"];
}

@end
