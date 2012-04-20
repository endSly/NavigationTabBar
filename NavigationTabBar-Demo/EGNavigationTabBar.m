//
//  EGNavigationTabBar.m
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGNavigationTabBar.h"

#import <QuartzCore/QuartzCore.h>

@interface EGNavigationTabBar (Private)

- (UIButton *)buttonForTabHeaderWithTitle:(NSString *)title;

@end

@implementation EGNavigationTabBar

@synthesize parentViewController = _parentViewController;
@synthesize delegate = _tabBarDelegate;
@synthesize dataSource = _dataSource;
@synthesize selectedTabIndex = _selectedTabIndex;
@synthesize navigationBarBackgroundImage = _navigationBarBackgroundImage;
@synthesize navigationController = _navigationController;
@synthesize gestureRecognizer = _gestureRecognizer;

- (void)initialize
{
    self.backgroundColor = [UIColor redColor];
    
    _buttonsContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 9999, self.frame.size.height)];
    _buttonsContainerView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavBarBackground"]]];
    [self addSubview:_buttonsContainerView];
    
    _tabButtons = [NSMutableArray array];
    _tabButtonsOffset = [NSMutableArray array];
    _tabViewControllers = [NSMutableArray array];
    
    _gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    _gestureRecognizer.delegate = self;
    [_buttonsContainerView addGestureRecognizer:_gestureRecognizer];
    
    _selectedTabIndex = -1;
}

- (UIImage *)backgroundImage
{
    return _navigationBarBackgroundImage.image;
}

-(void)setBackgroundImage:(UIImage*)backgroundImage
{
    if (_navigationBarBackgroundImage) {
        [_navigationBarBackgroundImage removeFromSuperview];
    }
    
    self.navigationBarBackgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
    _navigationBarBackgroundImage.image = backgroundImage;
}

- (UIButton *)buttonForTabHeaderWithTitle:(NSString *)title
{
    // Create a custom button
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = [title sizeWithFont:button.titleLabel.font].width;
    
    button.frame = CGRectMake(0, 0, width + 44 , 44);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    button.titleLabel.textColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    button.titleLabel.shadowColor = [UIColor colorWithWhite:0.85 alpha:0.3];
    button.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
    
    [button setBackgroundImage:[UIImage imageNamed:@"SelectedBackground"] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"SelectedBackground"] forState:UIControlStateApplication];
    [button setBackgroundImage:[UIImage imageNamed:@"SelectedBackground"] forState:UIControlStateHighlighted];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 6.0, 0, 3.0);
    
    return button;
}

- (void)setSelectedTabIndex:(NSUInteger)selectedTabIndex
{
    if (_selectedTabIndex == selectedTabIndex)
        return;
    
    NSUInteger lastSelected = _selectedTabIndex;
    _selectedTabIndex = selectedTabIndex;
    
    for (UIButton *button in _tabButtons) {
        button.selected = NO;
    }
    
    UIButton *button = (UIButton *) [_tabButtons objectAtIndex:selectedTabIndex];
    button.selected = YES;
    
    UIViewController *contentController = [self.dataSource navigationTabBar:self viewControllerForTabIndex:_selectedTabIndex];
    contentController.view.frame = CGRectMake((lastSelected < _selectedTabIndex) ? 320 : -320, 
                                              44, 
                                              self.parentViewController.view.frame.size.width, 
                                              self.parentViewController.view.frame.size.height - 44);
    
    contentController.view.layer.shadowOpacity = 1;
    contentController.view.layer.shadowOffset = CGSizeZero;
    contentController.view.layer.shadowRadius = 12;
    
    [self addSubview:contentController.view];
    
    [UIView animateWithDuration:0.35f animations:^{
        for (UIButton *otherButton in _tabButtons) {
            otherButton.titleLabel.layer.opacity = 0.6;
        }
        button.titleLabel.layer.opacity = 1;
        
        if ([self.dataSource respondsToSelector:@selector(navigationTabBar:colorForTabIndex:)]) {
            self.backgroundColor = [self.dataSource navigationTabBar:self colorForTabIndex:selectedTabIndex];
        }
        
        CGFloat offset = ((NSNumber *) [_tabButtonsOffset objectAtIndex:selectedTabIndex]).floatValue 
        + (((UIButton *) [_tabButtons objectAtIndex:0]).frame.size.width + 6) / 2.0;
        _buttonsContainerView.frame = CGRectMake(offset, 0, 
                                                 _buttonsContainerView.frame.size.width,
                                                 _buttonsContainerView.frame.size.height);
        
        
        _onScreenViewController.view.frame = CGRectMake((lastSelected < _selectedTabIndex) ? -320 : 320, 
                                                  44, 
                                                  self.parentViewController.view.frame.size.width, 
                                                  self.parentViewController.view.frame.size.height - 44);
        
        contentController.view.frame = CGRectMake(0, 
                                                  44, 
                                                  self.parentViewController.view.frame.size.width, 
                                                  self.parentViewController.view.frame.size.height - 44);
        
        
        
    } completion:^(BOOL finished) {
        [_onScreenViewController.view removeFromSuperview];
        _onScreenViewController = contentController;
    }];
}

- (void)tabSelected:(UITapGestureRecognizer *)recognizer
{
    UIButton *button = (UIButton *) recognizer.view;
    self.selectedTabIndex = button.tag;
}

- (void)setSelectedWithOffset:(CGFloat)offset
{
    int buttonIndex;
    for (int i = 0; i < _tabButtonsOffset.count; ++i) {
        if (((NSNumber *)[_tabButtonsOffset objectAtIndex:i]).floatValue < offset) {
            buttonIndex = i;
            break;
        }
    }
    
    self.selectedTabIndex = buttonIndex;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            _originPosition = _buttonsContainerView.frame.origin.x;
            break;
            
        case UIGestureRecognizerStateChanged:
            _buttonsContainerView.frame = CGRectMake(_originPosition + [recognizer translationInView:self].x, 
                                                     0, 
                                                     _buttonsContainerView.frame.size.width,
                                                     _buttonsContainerView.frame.size.height);
            break;
            
        case UIGestureRecognizerStateEnded:
            
            [self setSelectedWithOffset:_originPosition + [recognizer translationInView:self].x];
            
            
            break;
        default:
            break;
    }
    
    
}

- (void)reloadData
{
    // Clear button in tab bar
    for (UIButton *tabButton in _tabButtons) {
        [tabButton removeFromSuperview];
    }
    [_tabButtons removeAllObjects];
    [_tabButtonsOffset removeAllObjects];
    
    // Clear view controllers
    for (UIButton *tab in _tabViewControllers) {
        [tab removeFromSuperview];
    }
    [_tabViewControllers removeAllObjects];
    
    // Put buttons in correct location
    NSUInteger tabsCount = [self.dataSource navigationTabBarTabsCount:self];
    CGFloat tableOffset = 0, buttonOffset = 0;
    
    for (NSUInteger i = 0; i < tabsCount; ++i) {
        NSString *tabTitle = [self.dataSource navigationTabBar:self titleForTabIndex:i];
        UIButton *tabButton = [self buttonForTabHeaderWithTitle:tabTitle];
        if (!tableOffset) {
            tableOffset = (self.frame.size.width - tabButton.frame.size.width) / 2.0;
            buttonOffset = -(tabButton.frame.size.width + 6) / 2.0;
        }
        
        tabButton.frame = CGRectMake(tableOffset, 0, tabButton.frame.size.width, self.frame.size.height);
        tabButton.tag = i;
        
        tableOffset += tabButton.frame.size.width;
        
        [tabButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabSelected:)]];

        [_tabButtons addObject:tabButton];
        
        [_buttonsContainerView addSubview:tabButton];
        
        [_tabButtonsOffset addObject:[NSNumber numberWithFloat:buttonOffset]];
        buttonOffset -= tabButton.frame.size.width + 6;
    }
    
    // Update selected
    self.selectedTabIndex = 0;
}


@end
