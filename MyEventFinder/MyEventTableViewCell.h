//
//  MyEventTableViewCell.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/12/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyEventTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *authorProfileImgView;
@property (weak, nonatomic) IBOutlet UILabel *authorOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *timeOfPost;
@property (weak, nonatomic) IBOutlet UILabel *nameOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *timeOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *tagOfEvent;
@property (weak, nonatomic) IBOutlet UILabel *locationOfEvent;
@property (weak, nonatomic) IBOutlet UIImageView *imgviewOfEvent;


@end
