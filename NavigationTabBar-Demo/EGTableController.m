//
//  EGTableController.m
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGTableController.h"

#import <QuartzCore/QuartzCore.h>

@interface EGTableController ()

@end

@implementation EGTableController

@synthesize tableView = _tableView;
@synthesize navigationTabBar = _navigationTabBar;

- (void)viewDidLoad
{
    [super viewDidLoad];

    _navigationTabBar.delegate = self;
    _navigationTabBar.dataSource = self;
    _navigationTabBar.clipsToBounds = NO;
    _navigationTabBar.layer.shadowOpacity = 0.8;
    _navigationTabBar.layer.shadowOffset = CGSizeZero;
    
    [_navigationTabBar initialize];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (!cell)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Row %i", indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
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
