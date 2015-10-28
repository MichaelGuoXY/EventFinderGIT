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
#import "MyUserInfo.h"
#import "MyCheckString.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myUsrnameTextField;
@property (weak, nonatomic) IBOutlet UITextField *myPasswordTextField;
@property NSUserDefaults *usrDefault;
@property MyTabbarRootViewController *myTRC;
@property MyUserInfo *user;

@end

@implementation ViewController {
    NSMutableArray *mutableDataArray;
    bool isSignIn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    
//    [self loadData];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"didFinishSignUp"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"didFinishFetchUserInfo"
     object:nil];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"usernameNotFound"
     object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.myUsrnameTextField.text = @"";
    self.myPasswordTextField.text = @"";
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqual:@"didFinishSignUp"]) {
        UIAlertController* alertDidFinishSignUp = [UIAlertController alertControllerWithTitle:@"Cool!" message:@"Sign Up Successfully!!!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
        [alertDidFinishSignUp addAction:alertAction];
        [self presentViewController:alertDidFinishSignUp animated:YES completion:nil];
    }
    if ([notification.name isEqual:@"didFinishFetchUserInfo"]) {
        if (isSignIn) {
            if (self.myPasswordTextField.text == self.user.password) {
                [self.usrDefault setObject:self.user.username forKey:@"Usrname"];
                self.myTRC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarRootViewController"];
                [self presentViewController:self.myTRC animated:YES completion:nil];
            }
            else {
                UIAlertController* alertIncorrectPassword = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"incorrect password!!!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
                [alertIncorrectPassword addAction:alertAction];
                [self presentViewController:alertIncorrectPassword animated:YES completion:nil];
            }
        }
        else {
            UIAlertController* alertUsernameDuplicate = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"username duplicate!!!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
            [alertUsernameDuplicate addAction:alertAction];
            [self presentViewController:alertUsernameDuplicate animated:YES completion:nil];
        }
    }
    if ([notification.name isEqual:@"usernameNotFound"]) {
        if (isSignIn) {
            UIAlertController* alertUsernameNotFound = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"username not found!!!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
            [alertUsernameNotFound addAction:alertAction];
            [self presentViewController:alertUsernameNotFound animated:YES completion:nil];
        }
        else {
            MyUserInfo *user = [MyUserInfo new];
            user.username = self.myUsrnameTextField.text;
            user.password = self.myPasswordTextField.text;
            user.nickname = @"";
            user.age = @"";
            user.gender = @"";
            user.region = @"";
            user.whatsup = @"";
            user.myPostsNumber = 0;
            user.myAttendanceNumber = 0;
            user.usrProfileImage = [[NSData alloc] initWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"], 0.5)];
            [MyDataManager saveUser:user];
        }
    }
}

//- (void)loadData {
//    
//    MyEventInfo *event1 = [MyEventInfo new];
//    event1.nameOfEvent = @"Go Big Red";
//    event1.timeOfEvent = @"12:00PM";
//    event1.dateOfEvent = @"11/20/2015";
//    event1.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"bigRed.jpg"],0.5);
//    event1.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
//    event1.locationOfEvent = @"Carpentar Library";
//    event1.latOfEvent = [NSNumber numberWithDouble:42.444782];
//    event1.lngOfEvent = [NSNumber numberWithDouble:-76.484174];
//    event1.posterOfEvent = @"Xiaoyu Guo";
//    event1.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
//    MyEventInfo *event2 = [MyEventInfo new];
//    event2.nameOfEvent = @"Basketball Match";
//    event2.timeOfEvent = @"10:00PM";
//    event2.dateOfEvent = @"10/09/2015";
//    event2.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"basketball.jpg"],0.5);
//    event2.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
//    event2.locationOfEvent = @"Starter Hall";
//    event2.latOfEvent = [NSNumber numberWithDouble:42.445605];
//    event2.lngOfEvent = [NSNumber numberWithDouble:-76.482425];
//    event2.posterOfEvent = @"Yuxin Cao";
//    event2.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
//    MyEventInfo *event3 = [MyEventInfo new];
//    event3.nameOfEvent = @"Football Game";
//    event3.timeOfEvent = @"12:00PM";
//    event3.dateOfEvent = @"11/20/2015";
//    event3.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"football.jpg"],0.5);
//    event3.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
//    event3.locationOfEvent = @"Uris Library";
//    event3.latOfEvent = [NSNumber numberWithDouble:42.447782];
//    event3.lngOfEvent = [NSNumber numberWithDouble:-76.485301];
//    event3.posterOfEvent = @"Xiaoyu Guo";
//    event3.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
//    MyEventInfo *event4 = [MyEventInfo new];
//    event4.nameOfEvent = @"Free Food";
//    event4.timeOfEvent = @"12:00PM";
//    event4.dateOfEvent = @"11/20/2015";
//    event4.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"freeFood.jpg"],0.5);
//    event4.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
//    event4.locationOfEvent = @"Sage Hall";
//    event4.latOfEvent = [NSNumber numberWithDouble:42.445914];
//    event4.lngOfEvent = [NSNumber numberWithDouble:-76.483222];
//    event4.posterOfEvent = @"Xiaoyu Guo";
//    event4.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
//    MyEventInfo *event5 = [MyEventInfo new];
//    event5.nameOfEvent = @"Voice of Cornell";
//    event5.timeOfEvent = @"12:00PM";
//    event5.dateOfEvent = @"11/20/2015";
//    event5.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"voiceOfCornell.jpg"],0.5);
//    event5.imageOfPoster = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
//    event5.locationOfEvent = @"Olin Library";
//    event5.latOfEvent = [NSNumber numberWithDouble:42.447880];
//    event5.lngOfEvent = [NSNumber numberWithDouble:-76.484282];
//    event5.posterOfEvent = @"Xiaoyu Guo";
//    event5.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
//    
////    mutableDataArray = [[NSMutableArray alloc] init];
////    [self saveEventArrayData:event1];
////    [self saveEventArrayData:event2];
////    [self saveEventArrayData:event3];
////    [self saveEventArrayData:event4];
////    [self saveEventArrayData:event5];
//    
//    [MyDataManager saveEvent:event1];
//    [MyDataManager saveEvent:event2];
//    [MyDataManager saveEvent:event3];
//    [MyDataManager saveEvent:event4];
//    [MyDataManager saveEvent:event5];
//}

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
    isSignIn = true;
    NSString *username = self.myUsrnameTextField.text;

    self.user = [MyDataManager fetchUser:username];
}

- (IBAction)mySignUpButtonPressed:(id)sender {
    isSignIn = false;
    if ([MyCheckString isReadyForStore:self.myUsrnameTextField.text fromViewController:self]) {
        NSString *username = self.myUsrnameTextField.text;
        
        [MyDataManager fetchUser:username];
    }
//    NSData *usrDefaultProfileImage = [[NSData alloc] initWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"], 0.5)];
//    [self.usrDefault setObject:usrDefaultProfileImage forKey:@"usrProfileImage"];
//    NSInteger numberOfPost = 0;
//    [self.usrDefault setObject:numberOfPost forKey:@"numberOfPost"];
//    NSInteger numberOfAttendance = 0;
//    [self.usrDefault setObject:numberOfAttendance forKey:@"numberOfAttendance"];
    
    NSLog([self.usrDefault objectForKey:@"Usrname"]);
    NSLog([self.usrDefault objectForKey:@"Password"]);
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
