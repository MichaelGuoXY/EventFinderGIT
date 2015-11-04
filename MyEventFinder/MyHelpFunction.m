//
//  MyHelpFunction.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 11/4/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyHelpFunction.h"

@implementation MyHelpFunction

+ (void) segueModalWithRandomTransition:(UIViewController *) thisVC viewController:(UIViewController *) nextVC {
    // Random int between 0 and N - 1
    NSUInteger r = arc4random_uniform(5);
    switch (r) {
        case 1:
            nextVC.modalTransitionStyle = UIModalTransitionStylePartialCurl;
            break;
        case 2:
            nextVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            break;
        case 3:
            nextVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            break;
        case 4:
            nextVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            break;
        default:
            break;
    }
    
    [thisVC presentViewController:nextVC animated:YES completion:nil];
}


@end
