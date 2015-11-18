//
//  TimeOfEventViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "TimeOfEventViewController.h"

@interface TimeOfEventViewController ()
@property (weak, nonatomic) IBOutlet UILabel *myStartingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *myEndingTimeLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *myStartingTimePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *myEndingTimePicker;

@end

@implementation TimeOfEventViewController {
    NSString *startingTime;
    NSString *endingTime;
    NSUserDefaults *usrDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    usrDefault = [NSUserDefaults standardUserDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    if (startingTime && endingTime) {
        [usrDefault setObject:[NSNumber numberWithInteger:[startingTime integerValue]] forKey:@"startingTime"];
        [usrDefault setObject:[NSNumber numberWithInteger:[endingTime integerValue]] forKey:@"endingTime"];
    }
}

- (IBAction)startingTimePickerAction:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatter24 = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    [dateFormatter24 setDateFormat:@"yyyyMMddHHmm"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:self.myStartingTimePicker.date];
    startingTime = [dateFormatter24 stringFromDate:self.myStartingTimePicker.date];
    
    self.myStartingTimeLabel.text = [NSString stringWithFormat:@"Start at %@",formatedDate];;
}

- (IBAction)endingTimePickerAction:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatter24 = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm a"];
    [dateFormatter24 setDateFormat:@"yyyyMMddHHmm"];
    
    NSString *formatedDate = [dateFormatter stringFromDate:self.myEndingTimePicker.date];
    endingTime = [dateFormatter24 stringFromDate:self.myEndingTimePicker.date];
    
    self.myEndingTimeLabel.text = [NSString stringWithFormat:@"End at %@",formatedDate];
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
