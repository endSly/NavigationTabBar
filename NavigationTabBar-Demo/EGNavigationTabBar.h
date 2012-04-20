//
//  EGNavigationTabBar.h
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EGNavigationTabBarDataSource;
@protocol EGNavigationTabBarDelegate;

@interface EGNavigationTabBar : UIView <UIGestureRecognizerDelegate> {
    CGFloat _backButtonCapWidth;

    CGFloat _originPosition;
    
    UIView  *_buttonsContainerView;
    NSMutableArray *_tabButtons;
    NSMutableArray *_tabViewControllers;
    NSMutableArray *_tabButtonsOffset;
    
    UIViewController *_onScreenViewController;
}

@property (nonatomic, assign) UIViewController *parentViewController;
@property (nonatomic, assign) id <EGNavigationTabBarDelegate> delegate;
@property (nonatomic, assign) id <EGNavigationTabBarDataSource> dataSource;
@property (nonatomic) NSUInteger selectedTabIndex;
@property (nonatomic) UIImage * backgroundImage;
@property (nonatomic, retain) UIImageView * navigationBarBackgroundImage;
@property (nonatomic, retain) IBOutlet UINavigationController * navigationController;
@property (nonatomic, readonly) UIPanGestureRecognizer * gestureRecognizer;

- (void)initialize;
- (void)reloadData;

@end

@protocol EGNavigationTabBarDataSource <NSObject>

@required
- (NSUInteger)navigationTabBarTabsCount:(EGNavigationTabBar *)tabBar;
- (NSString *)navigationTabBar:(EGNavigationTabBar *)tabBar titleForTabIndex:(NSUInteger)tabIndex;
- (UIViewController *)navigationTabBar:(EGNavigationTabBar *)tabBar viewControllerForTabIndex:(NSUInteger)tabIndex;

@optional
- (UIColor *)navigationTabBar:(EGNavigationTabBar *)tabBar colorForTabIndex:(NSUInteger)tabIndex;

@end

@protocol EGNavigationTabBarDelegate <NSObject>

@optional
- (void)navigationTabBar:(EGNavigationTabBar *)tabBar didSelectTabAtIndex:(NSUInteger)tabIndex;
- (void)navigationTabBarStartDragging:(EGNavigationTabBar *)tabBar;


@end
