//
//  MyProfileViewController.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSArray *myGenderArray;
}

@property (weak, nonatomic) IBOutlet UITabBar  *myTB;

@end
