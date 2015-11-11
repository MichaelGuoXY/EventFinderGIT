//
//  MyTabbarRootViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/13/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyTabbarRootViewController.h"

@interface MyTabbarRootViewController ()

@end

@implementation MyTabbarRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (id) init
//{
//    NSLog(@"init TabBarController");
//    self = [super init];
//    if (self)
//    {
//        self.delegate = self;
//    }
//    return self;
//}
//
//- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
//{
//    NSLog(@"didSeclectViewController");
//    // Is this the view controller type you are interested in?
//    if ([viewController isKindOfClass:[MySearchTableTableViewController class]])
//    {
//        // call appropriate method on the class, e.g. updateView or reloadView
//        [(MySearchTableTableViewController *) viewController reloadView];
//    }
//}


////禁止tab多次点击
//-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    UIViewController *tbselect=tabBarController.selectedViewController;
//    if([tbselect isEqual:viewController]){
//        return NO;
//    }
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
