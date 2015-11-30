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
#import "MyNicknameViewController.h"
#import "MyAgeViewController.h"
#import "MyGenderTableViewController.h"
#import "MyWhatsupViewController.h"
#import "MyInterestsTableViewController.h"

@interface MyProfileViewController ()

@property NSUserDefaults *usrDefault;
@property MyUserInfo *user;

@end

@implementation MyProfileViewController {
    MyNicknameViewController *myNVC;
    MyAgeViewController *myAVC;
    MyGenderTableViewController *myGTVC;
    MyWhatsupViewController *myWVC;
    MyInterestsTableViewController *myITVC;
    BOOL didFetchUser;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    didFetchUser = NO;
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"didFinishFetchUserInfo"
     object:nil];
    self.user = [MyDataManager fetchUser:[self.usrDefault objectForKey:@"username"]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction hideTabBar:self.tabBarController];
    [self.myTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqualToString:@"didFinishFetchUserInfo"]) {
        [self.usrDefault setObject:self.user.nickname forKey:@"nickname"];
        [self.usrDefault setObject:self.user.age forKey:@"age"];
        [self.usrDefault setObject:self.user.gender forKey:@"gender"];
        [self.usrDefault setObject:self.user.whatsup forKey:@"whatsup"];
        [self.usrDefault setObject:self.user.interests forKey:@"interests"];
        didFetchUser = YES;
        [self.myTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    else if(section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ProfileCell";
        UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Nickname";
                if ([self.usrDefault objectForKey:@"nickname"])
                    cell.detailTextLabel.text = [self.usrDefault objectForKey:@"nickname"];
                break;
            case 1:
                cell.textLabel.text = @"Age";
                if ([self.usrDefault objectForKey:@"age"])
                    cell.detailTextLabel.text = [[self.usrDefault objectForKey:@"age"] stringValue];
                break;
            case 2:
                cell.textLabel.text = @"Gender";
                if ([self.usrDefault objectForKey:@"gender"])
                    cell.detailTextLabel.text = [self.usrDefault objectForKey:@"gender"];
                break;
            case 3:
                cell.textLabel.text = @"Whatsup";
                if ([self.usrDefault objectForKey:@"whatsup"])
                    cell.detailTextLabel.text = [self.usrDefault objectForKey:@"whatsup"];
                break;
            case 4:
                cell.textLabel.text = @"Interests";
                NSString *interests = @"";
                for (NSString *interest in [self.usrDefault objectForKey:@"interests"]) {
                    interests = [interests stringByAppendingFormat:@" %@",interest];
                }
                cell.detailTextLabel.text = [interests stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                break;
        }
        return cell;
    }
    else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"SaveProfileCell";
        UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                myNVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NicknameVC"];
                [self.navigationController pushViewController:myNVC animated:YES];
                break;
            case 1:
                myAVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AgeVC"];
                [self.navigationController pushViewController:myAVC animated:YES];
                break;
            case 2:
                myGTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"GenderTVC"];
                [self.navigationController pushViewController:myGTVC animated:YES];
                break;
            case 3:
                myWVC = [self.storyboard instantiateViewControllerWithIdentifier:@"WhatsupVC"];
                [self.navigationController pushViewController:myWVC animated:YES];
                break;
            case 4:
                myITVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InterestsTVC"];
                [self.navigationController pushViewController:myITVC animated:YES];
                break;
            default:
                break;
        }
    }
    else if(indexPath.section == 1) {
        self.user.nickname = [self.usrDefault objectForKey:@"nickname"];
        self.user.age = [self.usrDefault objectForKey:@"age"];
        self.user.gender = [self.usrDefault objectForKey:@"gender"];
        self.user.whatsup = [self.usrDefault objectForKey:@"whatsup"];
        self.user.interests = [self.usrDefault objectForKey:@"interests"];
        
        if (didFetchUser) {
            [MyDataManager updateUser:self.user];
        }
    }
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
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
