//
//  UIColor+UIColor_Transition.m
//  NavigationTabBar-Demo
//
//  Created by Endika Gutiérrez Salas on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIColor+Transition.h"

@implementation UIColor (Transition)

+ (UIColor *)colorWithTransitionFromColor:(UIColor *)from toColor:(UIColor *)to progress:(CGFloat)progress
{
    CGFloat r0, g0, b0, a0, r1, g1, b1, a1;
    [from getRed:&r0 green:&g0 blue:&b0 alpha:&a0];
    [to getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    
    const CGFloat p_1 = 1 - progress, p = progress;
    return [UIColor colorWithRed:r1 * p + r0 * p_1 
                           green:g1 * p + g0 * p_1 
                            blue:b1 * p + b0 * p_1 
                           alpha:a1 * p + a0 * p_1];
}

@end
