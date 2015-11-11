//
//  MyNicknameViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/10/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyNicknameViewController.h"

@interface MyNicknameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myNicknameTextField;
@property NSUserDefaults *usrDefault;
@end

@implementation MyNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    self.myNicknameTextField.text = [self.usrDefault objectForKey:@"nickname"];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.usrDefault setObject:self.myNicknameTextField.text forKey:@"nickname"];
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
