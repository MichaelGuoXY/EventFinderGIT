//
//  HideAndShowTabbarFunction.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/19/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "HideAndShowTabbarFunction.h"

@implementation HideAndShowTabbarFunction

+ (void)showTabBar:(UITabBarController*) tabbarController{
    if (tabbarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[tabbarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [tabbarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [tabbarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - tabbarController.tabBar.frame.size.height);
    tabbarController.tabBar.hidden = NO;
    
}


+ (void)hideTabBar:(UITabBarController*) tabbarController {
    if (tabbarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[tabbarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [tabbarController.view.subviews objectAtIndex:1];
    else
        contentView = [tabbarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + tabbarController.tabBar.frame.size.height);
    tabbarController.tabBar.hidden = YES;
    
}

@end
