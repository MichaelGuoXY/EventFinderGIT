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
    bool isSignIn;
    MyEventInfo *event1;
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
    
//    [MyDataManager downloadDataCompleted:^(NSString *output, NSNumber *count) {
//        NSLog(@"String downloaded is %@, number downloaded is %@", output, count);
//    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.myUsrnameTextField.text = @"";
    self.myPasswordTextField.text = @"";
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqualToString:@"didFinishSignUp"]) {
        UIAlertController* alertDidFinishSignUp = [UIAlertController alertControllerWithTitle:@"Cool!" message:@"Sign Up Successfully!!!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
        [alertDidFinishSignUp addAction:alertAction];
        [self presentViewController:alertDidFinishSignUp animated:YES completion:nil];
    }
    if ([notification.name isEqualToString:@"didFinishFetchUserInfo"]) {
        if (isSignIn) {
            NSLog(@"password text: %@, mem addr: %p",self.myPasswordTextField.text,self.myPasswordTextField.text);
            NSLog(@"password from database: %@, mem addr: %p", self.user.password,self.user.password);
            if ([self.myPasswordTextField.text isEqualToString:self.user.password]) {
                [self.usrDefault setObject:self.user.username forKey:@"username"];
                self.myTRC = [self.storyboard instantiateViewControllerWithIdentifier:@"tabbarRootViewController"];
                [self presentViewController:self.myTRC animated:YES completion:nil];
            }
            else {
                UIAlertController* alertIncorrectPassword = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"incorrect password !!!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
                [alertIncorrectPassword addAction:alertAction];
                [self presentViewController:alertIncorrectPassword animated:YES completion:nil];
            }
        }
        else {
            UIAlertController* alertUsernameDuplicate = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"username already exits !!!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
            [alertUsernameDuplicate addAction:alertAction];
            [self presentViewController:alertUsernameDuplicate animated:YES completion:nil];
        }
    }
    if ([notification.name isEqualToString:@"usernameNotFound"]) {
        if (isSignIn) {
            UIAlertController* alertUsernameNotFound = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"username not found !!!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
            [alertUsernameNotFound addAction:alertAction];
            [self presentViewController:alertUsernameNotFound animated:YES completion:nil];
        }
        else {
            MyUserInfo *user = [MyUserInfo new];
            user.username = self.myUsrnameTextField.text;
            user.password = self.myPasswordTextField.text;
            user.nickname = @"";
            user.age = @0;
            user.gender = @"";
            user.whatsup = @"";
            user.myPostsNumber = @0;
            user.myAttendanceNumber = @0;
            user.interests = @[@"None"];
            user.usrProfileImage = [[[NSData alloc] initWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"], 1)] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            
            [MyDataManager saveUser:user];
        }
    }
}

- (void)loadData {
    
    event1 = [MyEventInfo new];
    event1.nameOfEvent = @"Go Big Red";
    event1.startingTime = @201511201200;
    event1.endingTime = @201511201200;
    event1.latOfEvent = @42.444782;
    event1.lngOfEvent = @(-76.484174);
    event1.locationOfEvent = @"Olin";
    event1.primaryTag = @"Professional";
    event1.secondaryTag = @[@"Free Food", @"Seminar"];
    event1.introOfEvent = @"GO GO GO GO GO GO GO BIG BIG BIG BIG BIG BIG RED RED RED RED RED !!!";
    event1.restricttionOfEvent = @"restriction";
    event1.imageOfEvent = @[[UIImageJPEGRepresentation([UIImage imageNamed:@"bigRed.jpg"],1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    event1.postTime = @1212;
    event1.authorName = @"Yuxin";
    event1.authorProfileImg = [UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

//    mutableDataArray = [[NSMutableArray alloc] init];
//    [self saveEventArrayData:event1];
//    [self saveEventArrayData:event2];
//    [self saveEventArrayData:event3];
//    [self saveEventArrayData:event4];
//    [self saveEventArrayData:event5];
    
    [MyDataManager saveEvent:event1 withUIViewController:self];
}

- (IBAction)mySignInButtonPressed:(id)sender {
    isSignIn = true;
    if ([MyCheckString isReadyForStore:self.myUsrnameTextField.text fromViewController:self]) {
        NSString *username = self.myUsrnameTextField.text;

        self.user = [MyDataManager fetchUser:username];
    }
}

- (IBAction)mySignUpButtonPressed:(id)sender {
    isSignIn = false;
    if ([MyCheckString isReadyForStore:self.myUsrnameTextField.text fromViewController:self] && [MyCheckString isReadyForStore:self.myPasswordTextField.text fromViewController:self]) {
        NSString *username = self.myUsrnameTextField.text;
        
        [MyDataManager fetchUser:username];
    }
//    NSData *usrDefaultProfileImage = [[NSData alloc] initWithData:UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"], 0.5)];
//    [self.usrDefault setObject:usrDefaultProfileImage forKey:@"usrProfileImage"];
//    NSInteger numberOfPost = 0;
//    [self.usrDefault setObject:numberOfPost forKey:@"numberOfPost"];
//    NSInteger numberOfAttendance = 0;
//    [self.usrDefault setObject:numberOfAttendance forKey:@"numberOfAttendance"];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
