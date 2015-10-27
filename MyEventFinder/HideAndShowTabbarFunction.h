//
//  HideAndShowTabbarFunction.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/19/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface HideAndShowTabbarFunction : NSObject

+ (void)showTabBar:(UITabBarController*) tabbarController;
+ (void)hideTabBar:(UITabBarController*) tabbarController;

@end
