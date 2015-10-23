//
//  MyEventDetailViewController.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/12/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEventInfo.h"

@interface MyEventDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imageOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *posterOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *nameOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *timeOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *dateOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *locationOfEvent;
@property (weak, nonatomic) IBOutlet UITextView *infoOfEvent;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfPoster;




@property (nonatomic, strong) MyEventInfo *event;

@end
