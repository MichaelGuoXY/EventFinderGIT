//
//  MyHelpFunction.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 11/4/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyHelpFunction : NSObject

+ (void) segueModalWithRandomTransition:(UIViewController *) thisVC viewController:(UIViewController *) nextVC;
+ (NSString *)parseTimeFromOrigin: (NSNumber *) inputTime;
+ (void)presentAlertViewWithoutAction: (UIViewController *)thisVC withTitle: (NSString *)title withMessage: (NSString *)message withActionTitle: (NSString *)actionTitle;

@end
