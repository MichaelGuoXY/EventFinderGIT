//
//  NameOfEventViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "NameOfEventViewController.h"

@interface NameOfEventViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameOfEventTextField;

@end

@implementation NameOfEventViewController {
    NSUserDefaults *usrDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    usrDefault = [NSUserDefaults standardUserDefaults];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if ([usrDefault objectForKey:@"nameOfEvent"]) {
        self.nameOfEventTextField.text = [usrDefault objectForKey:@"nameOfEvent"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [usrDefault setObject:self.nameOfEventTextField.text forKey:@"nameOfEvent"];
    
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
