//
//  MyProfileViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyProfileViewController.h"
#import "HideAndShowTabbarFunction.h"
#import "MyDataManager.h"
#import "MyUserInfo.h"

@interface MyProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextField *myNicknameTextField;
@property (weak, nonatomic) IBOutlet UITextField *myAgeTextField;
@property (weak, nonatomic) IBOutlet UITextField *myGenderTextField;
@property (weak, nonatomic) IBOutlet UITextField *myRegionTextField;
@property (weak, nonatomic) IBOutlet UITextField *myWhatsUpTextField;
@property NSUserDefaults *usrDefault;
@property MyUserInfo *user;

@end

@implementation MyProfileViewController {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    // init and set the genderPicker
    UIPickerView *genderPicker = [[UIPickerView alloc] init];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonPressed)];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-genderPicker.frame.size.height-50, 320, 50)];
    NSArray *toolbarItems = [NSArray arrayWithObjects:doneButton,nil];
    [toolbar setItems:toolbarItems];
    self.myGenderTextField.inputAccessoryView = toolbar;
    
    genderPicker.dataSource = self;
    genderPicker.delegate = self;
    [genderPicker setShowsSelectionIndicator:YES];
    [self.myGenderTextField setInputView:genderPicker];
    myGenderArray = @[@"Male",@"Female",@"Transgender"];
    
    
//    // init swipe
//    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
//    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
//    [self.view addGestureRecognizer:swipeLeft];
//    
//    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self  action:@selector(didSwipe:)];
//    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:swipeRight];
//    
//    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]  initWithTarget:self action:@selector(didSwipe:)];
//    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
//    [self.view addGestureRecognizer:swipeUp];
//    
//    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
//    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//    [self.view addGestureRecognizer:swipeDown];
    
//    self.usrDefault = [NSUserDefaults standardUserDefaults];
//    self.myNicknameTextField.text = [self.usrDefault objectForKey:@"Nickname"];
//    self.myAgeTextField.text = [self.usrDefault objectForKey:@"Age"];
//    self.myGenderTextField.text = [self.usrDefault objectForKey:@"Gender"];
//    self.myRegionTextField.text = [self.usrDefault objectForKey:@"Region"];
//    self.myWhatsUpTextField.text = [self.usrDefault objectForKey:@"WhatsUp"];
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"didFinishFetchUserInfo"
     object:nil];
    
    self.user = [MyDataManager fetchUser:[self.usrDefault objectForKey:@"Usrname"]];
    
    
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqual:@"didFinishFetchUserInfo"]) {
        self.myNicknameTextField.text = self.user.nickname;
        self.myAgeTextField.text = self.user.age;
        self.myGenderTextField.text = self.user.gender;
        self.myRegionTextField.text = self.user.region;
        self.myWhatsUpTextField.text = self.user.whatsup;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction hideTabBar:self.tabBarController];
}

-(void)doneButtonPressed{
    [self.view endEditing:YES];
}

- (IBAction)mySaveButtonPressed:(id)sender {
    
//    [self.usrDefault setObject:self.myNicknameTextField.text forKey:@"Nickname"];
//    [self.usrDefault setObject:self.myAgeTextField.text forKey:@"Age"];
//    [self.usrDefault setObject:self.myGenderTextField.text forKey:@"Gender"];
//    [self.usrDefault setObject:self.myRegionTextField.text forKey:@"Region"];
//    [self.usrDefault setObject:self.myWhatsUpTextField.text forKey:@"WhatsUp"];
    self.user.nickname = self.myNicknameTextField.text;
    self.user.age = self.myAgeTextField.text;
    self.user.gender = self.myGenderTextField.text;
    self.user.region = self.myRegionTextField.text;
    self.user.whatsup = self.myWhatsUpTextField.text;
    [MyDataManager saveUser:self.user];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [myGenderArray count];
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [myGenderArray objectAtIndex:row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // This method is triggered whenever the user makes a change to the picker selection.
    // The parameter named row and component represents what was selected.
    self.myGenderTextField.text = [myGenderArray objectAtIndex:row];
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
