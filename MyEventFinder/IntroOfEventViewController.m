//
//  IntroOfEventViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "IntroOfEventViewController.h"

@interface IntroOfEventViewController ()
@property NSUserDefaults *usrDefault;
@property (weak, nonatomic) IBOutlet UITextView *introOfEventTextField;

@end

@implementation IntroOfEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.introOfEventTextField.layer.cornerRadius = 5;
    self.introOfEventTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.introOfEventTextField.layer.borderWidth = 0.5;
    self.usrDefault = [NSUserDefaults standardUserDefaults];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if ([self.usrDefault objectForKey:@"introOfEvent"]) {
        self.introOfEventTextField.text = [self.usrDefault objectForKey:@"introOfEvent"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.usrDefault setObject:self.introOfEventTextField.text forKey:@"introOfEvent"];
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
