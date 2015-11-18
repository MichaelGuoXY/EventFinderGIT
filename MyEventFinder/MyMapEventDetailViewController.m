//
//  MyMapEventDetailViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/27/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyMapEventDetailViewController.h"
#import "HideAndShowTabbarFunction.h"
#import "MyHelpFunction.h"

@interface MyMapEventDetailViewController ()

@property (weak, nonatomic) IBOutlet UINavigationItem *myNI;

@end

@implementation MyMapEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.myNI.title = self.event.nameOfEvent;
    self.authorOfEvent.text = self.event.authorName;
    self.nameOfEvent.text = self.event.nameOfEvent;
    self.startingTime.text = [MyHelpFunction parseTimeFromOrigin:self.event.startingTime];
    self.endingTime.text = [MyHelpFunction parseTimeFromOrigin:self.event.endingTime];
    self.locationOfEvent.text = self.event.locationOfEvent;
    self.introOfEvent.text = self.event.introOfEvent;
    self.timeOfPost.text = [MyHelpFunction parseTimeFromOrigin:self.event.postTime];
    NSString *string = self.event.primaryTag;
    for (NSString *str in self.event.secondaryTag) {
        string = [string stringByAppendingFormat:@", %@", str];
    }
    self.tagOfEvent.text = string;
    self.imgviewOfEvent.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:[self.event.imageOfEvent objectAtIndex:0] options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    self.authorProfileImg.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:self.event.authorProfileImg options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    self.authorProfileImg.clipsToBounds = YES;
    self.authorProfileImg.layer.cornerRadius = 27;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    
    self.myNI.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"< Map" style:UIBarButtonItemStylePlain target:self action:@selector(returnMap:)];
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
