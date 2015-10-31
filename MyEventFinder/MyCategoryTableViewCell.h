//
//  MyCategoryTableViewCell.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/29/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCategoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageOfCategory;
@property (weak, nonatomic) IBOutlet UILabel *nameOfCategory;

@end
