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

@synthesize navigationTabBar = _navigationTabBar;

- (void)viewDidLoad
{
    [super viewDidLoad];

    EGNavigationTabBar *navigationTabBar = [[EGNavigationTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    
    
    self.navigationTabBar = navigationTabBar;
    
    [self.view addSubview:navigationTabBar];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"Table"];
    controller.view.frame = CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:controller.view];
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


@end
