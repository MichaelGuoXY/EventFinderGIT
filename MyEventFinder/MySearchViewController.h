//
//  MySearchViewController.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/15/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (void)reloadView;

@end
