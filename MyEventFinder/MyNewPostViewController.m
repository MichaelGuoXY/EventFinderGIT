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
#import "MyDataManager.h"
#import "MyCheckString.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MyNewPostViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameOfEvent;
@property (weak, nonatomic) IBOutlet UITextField *timeOfEvent;
@property (weak, nonatomic) IBOutlet UITextField *dateOfEvent;
@property (weak, nonatomic) IBOutlet UITextField *locationOfEvent;
@property (weak, nonatomic) IBOutlet UITextView *introOfEvent;
//@property (weak, nonatomic) IBOutlet UILabel *lImageOfEvent;
@property (weak, nonatomic) IBOutlet UITextField *tagOfEvent;
@property (weak, nonatomic) IBOutlet UIImageView *imageOfEventSelected;
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
@property (weak, nonatomic) IBOutlet UIView *mapViewContainer;
@property (weak, nonatomic) IBOutlet UIButton *selectPictureButton;
@property (nonatomic, strong) GMSMapView *mapView;

@property NSUserDefaults *usrDefault;
@property MyUserInfo *user;
@end

@implementation MyNewPostViewController {
    NSMutableArray *events;
    NSData *imageOfEvent;
    double longtitude;
    double latitude;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    longtitude = 0;
    latitude = 0;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    events = [[NSMutableArray alloc] init];
//    [self extractEventArrayData];
    
    imageOfEvent = [[NSData alloc] init];
    
    self.user = [MyDataManager fetchUser:[self.usrDefault objectForKey:@"Usrname"]];
    [self.scroller setScrollEnabled:YES];
    [self.scroller setContentSize:CGSizeMake(320, 920)];
    
    self.introOfEvent.frame = CGRectMake(17, 351, self.scroller.frame.size.width-34, 86);
    self.imageOfEventSelected.frame = CGRectMake(17, 483, self.scroller.frame.size.width-34, 169);
    self.mapViewContainer.frame = CGRectMake(17, 660, self.scroller.frame.size.width-34, 214);
    self.selectPictureButton.frame = CGRectMake(40, 445, 285, 30);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:42.444782
                                                            longitude:-76.484174
                                                                 zoom:16
                                                              bearing:0
                                                         viewingAngle:0];
    
    self.mapView = [GMSMapView mapWithFrame:self.mapViewContainer.bounds camera:camera];
    self.mapView.delegate = self;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10 maxZoom:30];
    
    [self.mapViewContainer addSubview:self.mapView];
    
    // init and set the genderPicker
    UIPickerView *tagPicker = [[UIPickerView alloc] init];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-tagPicker.frame.size.height-50, 320, 50)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbar setItems:toolbarItems];
    self.tagOfEvent.inputAccessoryView = toolbar;
    
    tagPicker.dataSource = self;
    tagPicker.delegate = self;
    [tagPicker setShowsSelectionIndicator:YES];
    [self.tagOfEvent setInputView:tagPicker];
    myTagOfEventArray = @[@"Free Food", @"Professional", @"Athletic", @"Social", @"Political", @"Seminar", @"Cornell Sponsored"];
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate {
    GMSMarker *marker = [[GMSMarker alloc] init];
    [self.mapView clear];
    marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    marker.title = self.nameOfEvent.text;
    marker.snippet = self.locationOfEvent.text;
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = self.mapView;
    longtitude = coordinate.longitude;
    latitude = coordinate.latitude;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [HideAndShowTabbarFunction hideTabBar:self.tabBarController];
}

-(void)doneButtonPressed{
    [self.view endEditing:YES];
}

- (IBAction)myClearButtonPressed:(id)sender {
    self.nameOfEvent.text = @"";
    self.timeOfEvent.text = @"";
    self.dateOfEvent.text = @"";
    self.locationOfEvent.text = @"";
    self.introOfEvent.text = @"";
    self.tagOfEvent.text = @"";
    [self.mapView clear];
    imageOfEvent = [[NSData alloc] init];
    self.imageOfEventSelected.image = [UIImage imageWithData:imageOfEvent];
}

- (IBAction)myPostButtonPressed:(id)sender {
    
    MyEventInfo *event = [MyEventInfo new];
    if ([MyCheckString isReadyForStore:self.nameOfEvent.text fromViewController:self]) {
        event.nameOfEvent = self.nameOfEvent.text;
        event.timeOfEvent = self.timeOfEvent.text;
        event.dateOfEvent = self.dateOfEvent.text;
        //event.imageOfEvent = imageOfEvent;
        if (imageOfEvent.bytes == 0) {
            event.imageOfEvent = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"],0.5);
        }
        else {
            event.imageOfEvent = imageOfEvent;
        }
        event.imageOfPoster = self.user.usrProfileImage;
        event.locationOfEvent = self.locationOfEvent.text;
        event.posterOfEvent = self.user.username;
        event.introOfEvent = self.introOfEvent.text;
        event.tagOfEvent = self.tagOfEvent.text;
        if (longtitude == 0 && latitude == 0) {
            UIAlertController* alertNoLocation = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"Please long press in the map to mark a location!!!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
            [alertNoLocation addAction:alertAction];
            [self presentViewController:alertNoLocation animated:YES completion:nil];
        }
        else {
            event.lngOfEvent = [NSNumber numberWithDouble:longtitude];
            event.latOfEvent = [NSNumber numberWithDouble:latitude];
            self.user.myPostsNumber = self.user.myPostsNumber + 1;
            [MyDataManager saveUser:self.user];
            [MyDataManager saveEvent:event];
            UIAlertController* alertEventPostedSuccess = [UIAlertController alertControllerWithTitle:@"Congratulations!" message:@"New Event Has Been Posted Successfully!!!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"Cool" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
            [alertEventPostedSuccess addAction:alertAction];
            [self presentViewController:alertEventPostedSuccess animated:YES completion:nil];
        }
    }
//    [self saveEventArrayData:event];
//    NSLog(@"numberOfEvents : %lu",(unsigned long)events.count);
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [myTagOfEventArray count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [myTagOfEventArray objectAtIndex:row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    self.tagOfEvent.text = [myTagOfEventArray objectAtIndex:row];
}


//- (void)extractEventArrayData {
//    NSArray *dataArray = [[NSArray alloc] initWithArray:[self.usrDefault objectForKey:@"eventDataArray"]];
//    
//    for (NSData *dataObject in dataArray) {
//        MyEventInfo *eventDecodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:dataObject];
//        [events addObject:eventDecodedObject];
//    }
//}

//- (void)saveEventArrayData:(MyEventInfo *)eventObject {
//    
//    [events addObject:eventObject];
//    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:events.count];
//    for (MyEventInfo *eventObject in events) {
//        NSData *eventEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:eventObject];
//        [archiveArray addObject:eventEncodedObject];
//    }
//    
//    [self.usrDefault setObject:archiveArray forKey:@"eventDataArray"];
//}

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
    imageOfEvent = UIImageJPEGRepresentation(chosenImage,0.5);
    self.imageOfEventSelected.image = [UIImage imageWithData:imageOfEvent];
    
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
