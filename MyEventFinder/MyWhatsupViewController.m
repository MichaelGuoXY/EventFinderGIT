//
//  MyWhatsupViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/10/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyWhatsupViewController.h"

@interface MyWhatsupViewController ()
@property (weak, nonatomic) IBOutlet UITextView *myWhatsupTextView;
@property NSUserDefaults *usrDefault;
@end

@implementation MyWhatsupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myWhatsupTextView.layer.cornerRadius = 5;
    self.myWhatsupTextView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.myWhatsupTextView.layer.borderWidth = 0.5;
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    self.myWhatsupTextView.text = [self.usrDefault objectForKey:@"whatsup"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.usrDefault setObject:self.myWhatsupTextView.text forKey:@"whatsup"];
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
