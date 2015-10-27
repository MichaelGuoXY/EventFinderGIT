//
//  MyCheckString.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/27/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyCheckString.h"

@implementation MyCheckString

+ (BOOL)isReadyForStore:(NSString *)string fromViewController:(UIViewController *)viewController {
    if ([string isEqualToString:@""] || [string containsString:@"."] || [string containsString:@"#"] || [string containsString:@"$"] || [string containsString:@"["] || [string containsString:@"]"] ) {
        
        UIAlertController* alertStringWrongFormat = [UIAlertController alertControllerWithTitle:@"Alert!" message:[NSString stringWithFormat:@"String \"%@\" Wrong Format!!!", string] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
        [alertStringWrongFormat addAction:alertAction];
        [viewController presentViewController:alertStringWrongFormat animated:YES completion:nil];
        return false;
        
    }
    return true;
}

@end
