//
//  MyNewPostViewContoller.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyNewPostViewContoller.h"
#import "HideAndShowTabbarFunction.h"
#import "NameOfEventViewController.h"
#import "LocationOfEventViewController.h"
#import "TimeOfEventViewController.h"
#import "PrimaryTagTableViewController.h"
#import "SecondaryTagTableViewController.h"
#import "RestrictionViewController.h"
#import "IntroOfEventViewController.h"
#import "ImgOfEventViewController.h"
#import "MyHelpFunction.h"
#import "MyEventInfo.h"
#import "MyDataManager.h"

@interface MyNewPostViewContoller ()
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property NSUserDefaults *usrDefault;
@property (weak, nonatomic) IBOutlet UILabel *postThisEventLabel;
@property MyUserInfo *user;
@end

@implementation MyNewPostViewContoller {
    NameOfEventViewController *myNOEVC;
    LocationOfEventViewController *myLOEVC;
    TimeOfEventViewController *myTOEVC;
    PrimaryTagTableViewController *myPTTVC;
    SecondaryTagTableViewController *mySTTVC;
    RestrictionViewController *myRVC;
    IntroOfEventViewController *myIOEVC;
    ImgOfEventViewController *myISOEVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
//    self.user = [MyDataManager fetchUser:[self.usrDefault objectForKey:@"username"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction hideTabBar:self.tabBarController];
    [self.myTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 8;
    }
    else if (section == 1) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.clipsToBounds = YES;
        cell.layer.cornerRadius = 20;
        cell.layer.borderColor = [[UIColor groupTableViewBackgroundColor] CGColor];
        cell.layer.borderWidth = 1.2;
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"Event Name";
                if ([self.usrDefault objectForKey:@"nameOfEvent"])
                    cell.detailTextLabel.text = [self.usrDefault objectForKey:@"nameOfEvent"];
                break;
            case 1:
                cell.textLabel.text = @"Location";
                if ([self.usrDefault objectForKey:@"locationOfEvent"])
                    cell.detailTextLabel.text = [self.usrDefault objectForKey:@"locationOfEvent"];
                break;
            case 2:
                cell.textLabel.text = @"Time";
                if ([self.usrDefault objectForKey:@"startingTime"] && [self.usrDefault objectForKey:@"endingTime"])
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ ~ %@",[MyHelpFunction parseTimeFromOrigin:[self.usrDefault objectForKey:@"startingTime"]],[MyHelpFunction parseTimeFromOrigin:[self.usrDefault objectForKey:@"endingTime"]]];
                break;
            case 3:
                cell.textLabel.text = @"Restriction";
                if ([self.usrDefault objectForKey:@"restrictionOfEvent"])
                    cell.detailTextLabel.text = [self.usrDefault objectForKey:@"restrictionOfEvent"];
                break;
            case 4:
                cell.textLabel.text = @"Introduction";
                if ([self.usrDefault objectForKey:@"introOfEvent"])
                    cell.detailTextLabel.text = [self.usrDefault objectForKey:@"introOfEvent"];
                break;
                break;
            case 5:
                cell.textLabel.text = @"Primary Tag";
                if ([self.usrDefault objectForKey:@"primaryTag"])
                    cell.detailTextLabel.text = [self.usrDefault objectForKey:@"primaryTag"];
                break;
            case 7:
                cell.textLabel.text = @"Images";
                if ([self.usrDefault objectForKey:@"imagesOfEvent"])
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu images",[[self.usrDefault objectForKey:@"imagesOfEvent"] count]];
                break;
            case 6:
                cell.textLabel.text = @"Secondary Tag";
                NSString *secondaryTags = @"";
                for (NSString *secondaryTag in [self.usrDefault objectForKey:@"secondaryTag"]) {
                    secondaryTags = [secondaryTags stringByAppendingFormat:@" %@",secondaryTag];
                }
                cell.detailTextLabel.text = [secondaryTags stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                break;
        }
        return cell;
    }
    else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"PostThisEventCell";
        UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        
        cell.contentView.subviews[0].clipsToBounds = YES;
        cell.contentView.subviews[0].layer.cornerRadius = 20;
        
        return cell;
    }
    return nil;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                myNOEVC = [self.storyboard instantiateViewControllerWithIdentifier:@"NameOfEventVC"];
                [self.navigationController pushViewController:myNOEVC animated:YES];
                break;
            case 1:
                myLOEVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationOfEventVC"];
                [self.navigationController pushViewController:myLOEVC animated:YES];
                break;
            case 2:
                myTOEVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TimeOfEventVC"];
                [self.navigationController pushViewController:myTOEVC animated:YES];
                break;
            case 3:
                myRVC = [self.storyboard instantiateViewControllerWithIdentifier:@"RestrictionVC"];
                [self.navigationController pushViewController:myRVC animated:YES];
                break;
            case 4:
                myIOEVC = [self.storyboard instantiateViewControllerWithIdentifier:@"IntroOfEventVC"];
                [self.navigationController pushViewController:myIOEVC animated:YES];
                break;
            case 5:
                myPTTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PrimaryTagTVC"];
                [self.navigationController pushViewController:myPTTVC animated:YES];
                break;
            case 6:
                mySTTVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondaryTagTVC"];
                [self.navigationController pushViewController:mySTTVC animated:YES];
                break;
            case 7:
                myISOEVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ImgOfEventVC"];
                [self.navigationController pushViewController:myISOEVC animated:YES];
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            // Post This Event to database on Internet;
            BOOL b1 = ([self.usrDefault objectForKey:@"nameOfEvent"] != nil);
            BOOL b2 = ([self.usrDefault objectForKey:@"locationOfEvent"] != nil);
            BOOL b3 = ([self.usrDefault objectForKey:@"introOfEvent"] != nil);
            BOOL b4 = ([self.usrDefault objectForKey:@"startingTime"] != nil);
            BOOL b5 = ([self.usrDefault objectForKey:@"endingTime"] != nil);
            BOOL b6 = ([self.usrDefault objectForKey:@"restrictionOfEvent"] != nil);
            BOOL b7 = ([self.usrDefault objectForKey:@"primaryTag"] != nil);
            BOOL b8 = ([self.usrDefault objectForKey:@"secondaryTag"] != nil);
            BOOL b9 = ([self.usrDefault objectForKey:@"imagesOfEvent"] != nil);
            BOOL b10 = ([self.usrDefault objectForKey:@"longtitude"] != nil);
            BOOL b11 = ([self.usrDefault objectForKey:@"latitude"] != nil);
            if (!b1) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the title of the event?" withActionTitle:@"Got it"];
            }
            else if (!b2 || !b10 || !b11) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the location of the event?" withActionTitle:@"Got it"];
            }
            else if (!b3) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the introduction of the event?" withActionTitle:@"Got it"];
            }
            else if (!b4) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the starting time of the event?" withActionTitle:@"Got it"];
            }
            else if (!b5) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the ending time of the event?" withActionTitle:@"Got it"];
            }
            else if (!b6) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the restriction of the event?" withActionTitle:@"Got it"];
            }
            else if (!b7) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the primary tag of the event?" withActionTitle:@"Got it"];
            }
            else if (!b8) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the secondary tag of the event?" withActionTitle:@"Got it"];
            }
            else if (!b9) {
                [MyHelpFunction presentAlertViewWithoutAction:self withTitle:@"Alert !!!" withMessage:@"What is the image of the event?" withActionTitle:@"Got it"];
            }
            else {
                MyEventInfo *event = [MyEventInfo new];
                event.nameOfEvent = [self.usrDefault objectForKey:@"nameOfEvent"];
                event.locationOfEvent = [self.usrDefault objectForKey:@"locationOfEvent"];
                event.startingTime = [self.usrDefault objectForKey:@"startingTime"];
                event.endingTime = [self.usrDefault objectForKey:@"endingTime"];
                event.introOfEvent = [self.usrDefault objectForKey:@"introOfEvent"];
                event.restricttionOfEvent = [self.usrDefault objectForKey:@"restrictionOfEvent"];
                event.imageOfEvent = [self.usrDefault objectForKey:@"imagesOfEvent"];
                event.primaryTag = [self.usrDefault objectForKey:@"primaryTag"];
                event.secondaryTag = [self.usrDefault objectForKey:@"secondaryTag"];
                event.lngOfEvent = [self.usrDefault objectForKey:@"longtitude"];
                event.latOfEvent = [self.usrDefault objectForKey:@"latitude"];
                event.authorName = [self.usrDefault objectForKey:@"username"];
                event.authorProfileImg = [self.usrDefault objectForKey:@"usrProfileImage"];
                // get current time on device
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyyMMddHHmm"];
                NSNumber *postTime = [NSNumber numberWithInteger:[[formatter stringFromDate:[NSDate date]] integerValue]];
                event.postTime = postTime;
                // update this new event to the database
                [MyDataManager saveEvent:event withUIViewController:self];
                
                [self.usrDefault removeObjectForKey:@"nameOfEvent"];
                [self.usrDefault removeObjectForKey:@"locationOfEvent"];
                [self.usrDefault removeObjectForKey:@"startingTime"];
                [self.usrDefault removeObjectForKey:@"endingTime"];
                [self.usrDefault removeObjectForKey:@"introOfEvent"];
                [self.usrDefault removeObjectForKey:@"restrictionOfEvent"];
                [self.usrDefault removeObjectForKey:@"imagesOfEvent"];
                [self.usrDefault removeObjectForKey:@"primaryTag"];
                [self.usrDefault removeObjectForKey:@"secondaryTag"];
                [self.usrDefault removeObjectForKey:@"longtitude"];
                [self.usrDefault removeObjectForKey:@"latitude"];
                [self.myTableView reloadData];
                // update post number of the current user to database
                int i = [[self.usrDefault objectForKey:@"myPostNumber"] intValue];
                [self.usrDefault setObject:[NSNumber numberWithInt:i+1] forKey:@"myPostNumber"];
                [MyDataManager updateUser:[self.usrDefault objectForKey:@"username"] postsNumber:[NSNumber numberWithInt:i+1]];
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
