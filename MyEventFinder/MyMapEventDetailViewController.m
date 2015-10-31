//
//  MyMapEventDetailViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/27/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyMapEventDetailViewController.h"
#import "HideAndShowTabbarFunction.h"
@interface MyMapEventDetailViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *myNI;

@end

@implementation MyMapEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.posterOfEvent.text = self.event.posterOfEvent;
    self.nameOfEvent.text = self.event.nameOfEvent;
    self.timeOfEvent.text = self.event.timeOfEvent;
    self.dateOfEvent.text = self.event.dateOfEvent;
    self.locationOfEvent.text = self.event.locationOfEvent;
    self.infoOfEvent.text = self.event.introOfEvent;
    self.tagOfEvent.text = self.event.tagOfEvent;
    self.imageOfEvent.image = [UIImage imageWithData:self.event.imageOfEvent];
    self.imageOfPoster.image = [UIImage imageWithData:self.event.imageOfPoster];
    self.imageOfPoster.clipsToBounds = YES;
    self.imageOfPoster.layer.cornerRadius = 27;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    
    self.myNI.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Map" style:UIBarButtonItemStylePlain target:self action:@selector(returnMap:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction hideTabBar:self.tabBarController];
}


- (void)returnMap: (id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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
