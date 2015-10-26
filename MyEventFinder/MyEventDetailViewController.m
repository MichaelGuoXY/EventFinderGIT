//
//  MyEventDetailViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/12/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyEventDetailViewController.h"

@interface MyEventDetailViewController ()
@property (weak, nonatomic) IBOutlet UINavigationItem *myNGIT;

@end

@implementation MyEventDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.myNGIT.title = self.event.nameOfEvent;
    self.posterOfEvent.text = self.event.posterOfEvent;
    self.nameOfEvent.text = self.event.nameOfEvent;
    self.timeOfEvent.text = self.event.timeOfEvent;
    self.dateOfEvent.text = self.event.dateOfEvent;
    self.locationOfEvent.text = self.event.locationOfEvent;
    self.infoOfEvent.text = self.event.introOfEvent;
    self.imageOfEvent.image = [UIImage imageWithData:self.event.imageOfEvent];
    self.imageOfPoster.image = [UIImage imageWithData:self.event.imageOfPoster];
    self.imageOfPoster.clipsToBounds = YES;
    self.imageOfPoster.layer.cornerRadius = 27;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
                                 
}

- (void) returnSearch: (id) sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
