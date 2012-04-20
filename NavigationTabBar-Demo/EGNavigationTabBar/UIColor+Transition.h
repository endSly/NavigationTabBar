//
//  UIColor+UIColor_Transition.h
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Transition)

+ (UIColor *)colorWithTransitionFromColor:(UIColor *)from toColor:(UIColor *)to progress:(CGFloat)progress;

@end
