//
//  ViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "ViewController.h"
#import "MyTabbarRootViewController.h"
#import "MyEventInfo.h"
#import "MyDataManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myUsrnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *myPasswordTextField;
@property NSUserDefaults *usrDefault;
@property MyTabbarRootViewController *myTRC;

@end

@implementation ViewController {
    NSMutableArray *mutableDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    
    [self loadData];
    
}

- (void)loadData {
    
    MyEventInfo *event1 = [MyEventInfo new];
    event1.nameOfEvent = @"Go Big Red";
    event1.timeOfEvent = @"12:00PM";
    event1.dateOfEvent = @"11/20/2015";
    event1.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"bigRed.jpg"],0.5);
    event1.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
    event1.locationOfEvent = @"Gates Play Ground";
    event1.posterOfEvent = @"Xiaoyu Guo";
    event1.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
    MyEventInfo *event2 = [MyEventInfo new];
    event2.nameOfEvent = @"Basketball Match";
    event2.timeOfEvent = @"10:00PM";
    event2.dateOfEvent = @"10/09/2015";
    event2.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"basketball.jpg"],0.5);
    event2.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
    event2.locationOfEvent = @"Starter Hall";
    event2.posterOfEvent = @"Yuxin Cao";
    event2.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
    MyEventInfo *event3 = [MyEventInfo new];
    event3.nameOfEvent = @"Football Game";
    event3.timeOfEvent = @"12:00PM";
    event3.dateOfEvent = @"11/20/2015";
    event3.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"football.jpg"],0.5);
    event3.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
    event3.locationOfEvent = @"Gates Play Ground";
    event3.posterOfEvent = @"Xiaoyu Guo";
    event3.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
    MyEventInfo *event4 = [MyEventInfo new];
    event4.nameOfEvent = @"Free Food";
    event4.timeOfEvent = @"12:00PM";
    event4.dateOfEvent = @"11/20/2015";
    event4.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"freeFood.jpg"],0.5);
    event4.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
    event4.locationOfEvent = @"Gates Play Ground";
    event4.posterOfEvent = @"Xiaoyu Guo";
    event4.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
    MyEventInfo *event5 = [MyEventInfo new];
    event5.nameOfEvent = @"Voice of Cornell";
    event5.timeOfEvent = @"12:00PM";
    event5.dateOfEvent = @"11/20/2015";
    event5.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"voiceOfCornell.jpg"],0.5);
    event5.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
    event5.locationOfEvent = @"Gates Play Ground";
    event5.posterOfEvent = @"Xiaoyu Guo";
    event5.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
    
//    mutableDataArray = [[NSMutableArray alloc] init];
//    [self saveEventArrayData:event1];
//    [self saveEventArrayData:event2];
//    [self saveEventArrayData:event3];
//    [self saveEventArrayData:event4];
//    [self saveEventArrayData:event5];
    
    [MyDataManager saveEvent:event1];
    [MyDataManager saveEvent:event2];
    [MyDataManager saveEvent:event3];
    [MyDataManager saveEvent:event4];
    [MyDataManager saveEvent:event5];
}

//- (void)saveEventArrayData:(MyEventInfo *)eventObject {
//    
//    [mutableDataArray addObject:eventObject];
//    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:mutableDataArray.count];
//    for (MyEventInfo *eventObject in mutableDataArray) {
//        NSData *eventEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:eventObject];
//        [archiveArray addObject:eventEncodedObject];
//    }
//    
//    [self.usrDefault setObject:archiveArray forKey:@"eventDataArray"];
//}

- (IBAction)mySignInButtonPressed:(id)sender {
    NSString *usrname = self.myUsrnameTextField.text;
    NSString *password = self.myPasswordTextField.text;
    if (usrname == [self.usrDefault objectForKey:@"Usrname"] && password == [self.usrDefault objectForKey:@"Password"]) {
        self.myTRC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarRootViewController"];
        [self presentViewController:self.myTRC animated:YES completion:nil];
    }
}


- (IBAction)mySignUpButtonPressed:(id)sender {
    NSString *usrname = self.myUsrnameTextField.text;
    NSString *passwprd = self.myPasswordTextField.text;
    [self.usrDefault setObject:usrname forKey:@"Usrname"];
    [self.usrDefault setObject:passwprd forKey:@"Password"];
    NSData *usrDefaultProfileImage = [[NSData alloc] initWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"], 0.5)];
    [self.usrDefault setObject:usrDefaultProfileImage forKey:@"usrProfileImage"];
//    NSInteger numberOfPost = 0;
//    [self.usrDefault setObject:numberOfPost forKey:@"numberOfPost"];
//    NSInteger numberOfAttendance = 0;
//    [self.usrDefault setObject:numberOfAttendance forKey:@"numberOfAttendance"];
    
    NSLog([self.usrDefault objectForKey:@"Usrname"]);
    NSLog([self.usrDefault objectForKey:@"Password"]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
