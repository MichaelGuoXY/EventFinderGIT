//
//  MyLeftMenuViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/17/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyLeftMenuViewController.h"
#import "MySearchViewController.h"
#import "MyProfileViewController.h"
#import "UIViewController+RESideMenu.h"
#import "MyUserInfo.h"
#import "MyDataManager.h"

@interface MyLeftMenuViewController ()
@property (strong, readwrite, nonatomic) UITableView *tableView;
@property MyUserInfo *user;
@end

@implementation MyLeftMenuViewController {
    UIButton *profileViewButton;
    NSUserDefaults *usrDefault;
    NSData *usrProfileImage;
    UILabel *LabelOfMyPostsNumber;
    UILabel *labelOfMyAttendanceNumber;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    usrDefault = [NSUserDefaults standardUserDefaults];
    usrProfileImage = [[NSData alloc] init];
    
    NSData *defaultProfileImageData = UIImageJPEGRepresentation([UIImage imageNamed:@"usrDefault.jpg"], 1);
    NSString *defaultProfileImageString = [defaultProfileImageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [usrDefault setObject:defaultProfileImageString forKey:@"usrProfileImage"];
    
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (self.view.frame.size.height - 38 * 7) / 2.0f, self.view.frame.size.width, 38 * 7) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    
    [self.view addSubview:self.tableView];
    
    profileViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [profileViewButton setImage:[UIImage imageNamed:@"usrDefault.jpg"] forState:UIControlStateNormal];
    [profileViewButton addTarget:self action:@selector(buttonDidPressed) forControlEvents:UIControlEventTouchUpInside];
    profileViewButton.frame = CGRectMake(50.0, 50.0, 80.0, 80.0);//width and height should be same value
    profileViewButton.clipsToBounds = YES;
    profileViewButton.layer.cornerRadius = 40;//half of the width
    profileViewButton.layer.borderColor=[UIColor blackColor].CGColor;
    profileViewButton.layer.borderWidth=0.5f;
    [self.view addSubview:profileViewButton];
    
    UILabel *labelOfMyPosts = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 60, 20)];
    labelOfMyPosts.text = @"Posts";
    labelOfMyPosts.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:labelOfMyPosts];
    
    LabelOfMyPostsNumber = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 60, 20)];
    
    LabelOfMyPostsNumber.text = @"0";
    LabelOfMyPostsNumber.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:LabelOfMyPostsNumber];
    
    UILabel *labelOfMyAttendance = [[UILabel alloc] initWithFrame:CGRectMake(70, 140, 100, 20)];
    labelOfMyAttendance.text = @"Attendance";
    labelOfMyAttendance.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:labelOfMyAttendance];
    
    labelOfMyAttendanceNumber = [[UILabel alloc] initWithFrame:CGRectMake(70, 160, 100, 20)];
    
    labelOfMyAttendanceNumber.text = @"0";
    labelOfMyAttendanceNumber.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:labelOfMyAttendanceNumber];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"didFinishFetchUserInfo"
     object:nil];
    
    self.user = [MyDataManager fetchUser:[usrDefault objectForKey:@"username"]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [profileViewButton setImage:[UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:[usrDefault objectForKey:@"usrProfileImage"] options:NSDataBase64DecodingIgnoreUnknownCharacters]] forState:UIControlStateNormal];
    LabelOfMyPostsNumber.text = [[usrDefault objectForKey:@"myPostNumber"] stringValue];
    labelOfMyAttendanceNumber.text = [[usrDefault objectForKey:@"myAttendanceNumber"] stringValue];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqualToString:@"didFinishFetchUserInfo"]) {
        [usrDefault setObject:self.user.myPostsNumber forKey:@"myPostNumber"];
        [usrDefault setObject:self.user.myAttendanceNumber forKey:@"myAttendanceNumber"];
        [usrDefault setObject:self.user.usrProfileImage forKey:@"usrProfileImage"];
        [self viewWillAppear:YES];
    }
}

- (void)buttonDidPressed{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Change Your Profile Photo?"
                                                                   message:@"Please Choose a Way"
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* takeNewPhotoAction = [UIAlertAction actionWithTitle:@"Take a New Profile Photo" style:UIAlertActionStyleDefault
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
    
    usrProfileImage = UIImageJPEGRepresentation(chosenImage, 1);
//    self.user.usrProfileImage = [usrProfileImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [usrDefault setObject:[usrProfileImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] forKey:@"usrProfileImage"];
    [MyDataManager updateUser:[usrDefault objectForKey:@"username"] usrProfileImg:[usrProfileImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength]];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"homeViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 1:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"profileViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 2:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"newPostViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 3:
            [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"myPostViewController"]]
                                                         animated:YES];
            [self.sideMenuViewController hideMenuViewController];
            break;
        case 6:
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.highlightedTextColor = [UIColor lightGrayColor];
        cell.selectedBackgroundView = [[UIView alloc] init];
    }
    
    NSArray *titles = @[@"Home", @"Profile", @"New Post", @"My Posts", @"My Attendance", @"Settings", @"Log Out"];
    NSArray *images = @[@"home.png", @"profile.png", @"newpost.png", @"myposts.png", @"myattendance.png", @"settings.png", @"logout.png"];
    cell.textLabel.text = titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
    
    return cell;
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
