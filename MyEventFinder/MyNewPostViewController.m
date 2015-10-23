//
//  MyNewPostViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyNewPostViewController.h"
#import "MyEventInfo.h"
#import "HideAndShowTabbarFunction.h"

@interface MyNewPostViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameOfEvent;
@property (weak, nonatomic) IBOutlet UITextField *timeOfEvent;
@property (weak, nonatomic) IBOutlet UITextField *dateOfEvent;
@property (weak, nonatomic) IBOutlet UITextField *locationOfEvent;
@property (weak, nonatomic) IBOutlet UITextView *introOfEvent;
//@property (weak, nonatomic) IBOutlet UILabel *lImageOfEvent;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfEventSelected;


@property NSUserDefaults *usrDefault;

@end

@implementation MyNewPostViewController {
    NSMutableArray *events;
    HideAndShowTabbarFunction *hideAndShowTabbarFunc;
    NSData *imageData;
    NSString *imageOfEvent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    events = [[NSMutableArray alloc] init];
    [self extractEventArrayData];
    NSLog(@"numberOfEvents : %lu",(unsigned long)events.count);
    // init hideAndSHowTabbarFunc
    hideAndShowTabbarFunc = [[HideAndShowTabbarFunction alloc] init];
    imageData = [[NSData alloc] init];
    imageOfEvent = [[NSString alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
//    self.lImageOfEvent.text = imageOfEvent;
    [hideAndShowTabbarFunc hideTabBar:self.tabBarController];
}

- (IBAction)myPostButtonPressed:(id)sender {
    
    MyEventInfo *event = [MyEventInfo new];
    event.nameOfEvent = self.nameOfEvent.text;
    event.timeOfEvent = self.timeOfEvent.text;
    event.dateOfEvent = self.dateOfEvent.text;
    //event.imageOfEvent = imageOfEvent;
    if (imageData.bytes == 0) {
        imageOfEvent = @"usrDefault.jpg";
        imageData = UIImageJPEGRepresentation([UIImage imageNamed:imageOfEvent],0.5);
    }
    event.imageData = imageData;
    event.imageOfPoster = [self.usrDefault objectForKey:@"usrProfileImage"];
    event.locationOfEvent = self.locationOfEvent.text;
    event.posterOfEvent = [self.usrDefault objectForKey:@"Usrname"];
    event.introOfEvent = self.introOfEvent.text;
    
    [self saveEventArrayData:event];
    NSLog(@"numberOfEvents : %lu",(unsigned long)events.count);
}


- (void)extractEventArrayData {
    NSArray *dataArray = [[NSArray alloc] initWithArray:[self.usrDefault objectForKey:@"eventDataArray"]];
    
    for (NSData *dataObject in dataArray) {
        MyEventInfo *eventDecodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:dataObject];
        [events addObject:eventDecodedObject];
    }
}

- (void)saveEventArrayData:(MyEventInfo *)eventObject {
    
    [events addObject:eventObject];
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:events.count];
    for (MyEventInfo *eventObject in events) {
        NSData *eventEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:eventObject];
        [archiveArray addObject:eventEncodedObject];
    }
    
    [self.usrDefault setObject:archiveArray forKey:@"eventDataArray"];
}

- (IBAction)selectPictureButtonPressed:(id)sender {
    NSLog(@"Button Pressed");
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Change Your Event Photo?"
                                                                   message:@"Please Choose a Way"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* takeNewPhotoAction = [UIAlertAction actionWithTitle:@"Take a New Photo" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {
                                                                   @try {
                                                                       UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                                       picker.delegate = self;
                                                                       picker.allowsEditing = YES;
                                                                       picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                       
                                                                       [self presentViewController:picker animated:YES completion:nil];
                                                                   }
                                                                   @catch (NSException *exception) {
                                                                       UIAlertController* alertNoCameraDevice = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Sorry Camera Device Not Found!" preferredStyle:UIAlertControllerStyleAlert];
                                                                       UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
                                                                       [alertNoCameraDevice addAction:alertAction];
                                                                       [self presentViewController:alertNoCameraDevice animated:YES completion:nil];
                                                                   }
                                                               }];
    UIAlertAction* chooseFromMyPhotos = [UIAlertAction actionWithTitle:@"Choose From My Photos" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction* action) {
                                                                   UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                                   picker.delegate = self;
                                                                   picker.allowsEditing = YES;
                                                                   picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                                   
                                                                   [self presentViewController:picker animated:YES completion:nil];
                                                               }];
    
    UIAlertAction* cancelAlert = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                        handler:^(UIAlertAction* action) {}];
    
    [alert addAction:takeNewPhotoAction];
    [alert addAction:chooseFromMyPhotos];
    [alert addAction:cancelAlert];
    [self presentViewController:alert animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    imageData = UIImageJPEGRepresentation(chosenImage,0.5);
    self.imageOfEventSelected.image = [UIImage imageWithData:imageData];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
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
