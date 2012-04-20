//
//  EGNavigationTabBar.m
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGNavigationTabBar.h"

@interface EGNavigationTabBar (Private)

- (UIButton *)buttonForTabHeaderWithTitle:(NSString *)title;

@end

@implementation EGNavigationTabBar

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
    [button setBackgroundImage:[UIImage imageNamed:@"SelectedBackground"] forState:UIControlStateSelected];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 6.0, 0, 3.0);
    
    return button;
}

- (void)tabSelected:(UITapGestureRecognizer *)recognizer
{
    for (UIButton *button in _tabButtons) {
        [button setSelected:NO];
    }
    
    //[self.delegate navigationTabBar:self didSelectTabAtIndex:0];
    UIButton *button = (UIButton *) recognizer.view;
    [button setSelected:YES];
    
    _selectedTabIndex = button.tag;
    
    [UIView animateWithDuration:0.25f animations:^{
        _buttonsContainerView.frame = CGRectMake(((NSNumber *) [_tabButtonsOffset objectAtIndex:_selectedTabIndex]).floatValue, 
                                                 0, 
                                                 _buttonsContainerView.frame.size.width,
                                                 _buttonsContainerView.frame.size.height);
    }];
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
    
    for (UIButton *button in _tabButtons)
        button.selected = NO;
    
    _selectedTabIndex = buttonIndex;
    UIButton *button = (UIButton *) [_tabButtons objectAtIndex:buttonIndex];
    button.selected = YES;
    
    _selectedTabIndex = button.tag;
    
    [UIView animateWithDuration:0.25f animations:^{
        _buttonsContainerView.frame = CGRectMake(((NSNumber *) [_tabButtonsOffset objectAtIndex:_selectedTabIndex]).floatValue, 
                                                 0, 
                                                 _buttonsContainerView.frame.size.width,
                                                 _buttonsContainerView.frame.size.height);
    }];
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
    static bool initialized = NO;
    if (!initialized) {
        [self initialize];
        initialized = YES;
    }
    
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
        }
        [_tabButtonsOffset addObject:[NSNumber numberWithFloat:buttonOffset]];
        buttonOffset -= tabButton.frame.size.width + 6;
        
        tabButton.frame = CGRectMake(tableOffset, 0, tabButton.frame.size.width, self.frame.size.height);
        tabButton.tag = i;
        
        tableOffset += tabButton.frame.size.width;
        
        [tabButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabSelected:)]];
        
        [_tabButtons addObject:tabButton];
        
        [_buttonsContainerView addSubview:tabButton];
        
    }
    
    if (_selectedTabIndex < _tabButtons.count) {
        ((UIButton *) [_tabButtons objectAtIndex:_selectedTabIndex]).selected = YES;
    }
    
    [self setNeedsDisplay];
}


@end
