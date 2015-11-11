//
//  MyAgeViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/10/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyAgeViewController.h"

@interface MyAgeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myAgeTextField;
@property NSUserDefaults *usrDefault;
@end

@implementation MyAgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    self.myAgeTextField.text = [[self.usrDefault objectForKey:@"age"] stringValue];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    NSInteger age = [self.myAgeTextField.text integerValue];
    [self.usrDefault setObject:[NSNumber numberWithInteger:age] forKey:@"age"];
}

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
