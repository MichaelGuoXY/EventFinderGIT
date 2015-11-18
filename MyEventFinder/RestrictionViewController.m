//
//  RestrictionViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "RestrictionViewController.h"

@interface RestrictionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *myRestrictionTextField;

@end

@implementation RestrictionViewController {
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
    if ([usrDefault objectForKey:@"restrictionOfEvent"]) {
        self.myRestrictionTextField.text = [usrDefault objectForKey:@"restrictionOfEvent"];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [usrDefault setObject:self.myRestrictionTextField.text forKey:@"restrictionOfEvent"];
    
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
