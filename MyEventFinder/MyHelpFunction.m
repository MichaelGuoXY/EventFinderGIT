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

+ (NSString *)parseTimeFromOrigin: (NSNumber *) inputTime{
    NSInteger time = [inputTime integerValue];
    NSString *minutes = [NSString stringWithFormat:@"%ld",(time % 100)];
    minutes = [self forceToBe2Digits:minutes];
    time /= 100;
    NSInteger _hours = time % 100;
    NSString *AM_PM;
    if (_hours > 12) {
        AM_PM = @"PM";
        _hours -= 12;
    }
    else {
        AM_PM = @"AM";
    }
    NSString *hours = [NSString stringWithFormat:@"%ld",(long)_hours];
    hours = [self forceToBe2Digits:hours];
    time /= 100;
    NSString *day = [NSString stringWithFormat:@"%ld",time % 100];
    day = [self forceToBe2Digits:day];
    time /= 100;
    NSString *month = [NSString stringWithFormat:@"%ld",time % 100];
    month = [self forceToBe2Digits:month];
    time /= 100;
    NSString *year = [NSString stringWithFormat:@"%ld",(long)time];
    NSString *result = [month stringByAppendingFormat:@"/%@/%@ %@:%@ %@", day,year,hours,minutes,AM_PM];
    return result;
}

+ (NSString *)forceToBe2Digits: (NSString *) inputString{
    if ([inputString integerValue] < 10) {
        return [NSString stringWithFormat:@"0%@",inputString];
    }
    else {
        return inputString;
    }
}

+ (void)presentAlertViewWithoutAction: (UIViewController *)thisVC withTitle: (NSString *)title withMessage: (NSString *)message withActionTitle: (NSString *)actionTitle {
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* alertAction = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
    [alertController addAction:alertAction];
    [thisVC presentViewController:alertController animated:YES completion:nil];
}

@end
