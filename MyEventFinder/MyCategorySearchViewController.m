//
//  MyCategorySearchViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/29/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyCategorySearchViewController.h"
#import "MyEventInfo.h"
#import "MyEventTableViewCell.h"
#import "MyEventDetailViewController.h"
#import "UIViewController+RESideMenu.h"
#import "HideAndShowTabbarFunction.h"
#import "MyDataManager.h"
#import "MyEventTableViewAddCell.h"

@interface MyCategorySearchViewController ()

@property NSUserDefaults *usrDefault;
@property (weak, nonatomic) IBOutlet UINavigationItem *myNI;

@end

@implementation MyCategorySearchViewController {
    NSMutableArray *events;
    NSArray *searchResults;
    NSArray *tagEvents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.myNI.title = self.tag;
    // Initialize the events array
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
//    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    
    // set delegate and dataSource
    self.searchDisplayController.searchResultsTableView.delegate = self;
    self.searchDisplayController.searchResultsTableView.dataSource = self;
    
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"didFinishFetchEvents"
     object:nil];
    
    events = [[NSMutableArray alloc] init];
    events = [MyDataManager fetchEvent];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction hideTabBar:self.tabBarController];
    //    [self reloadView];
}

- (void)filterEvensToTag {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"tagOfEvent == %@", self.tag];
    tagEvents = [events filteredArrayUsingPredicate:resultPredicate];
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqual:@"didFinishFetchEvents"]) {
        tagEvents = [[NSArray alloc] init];
        [self filterEvensToTag];
        [self.myTableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)extractEventArrayData {
//    NSArray *dataArray = [[NSArray alloc] initWithArray:[self.usrDefault objectForKey:@"eventDataArray"]];
//
//    for (NSData *dataObject in dataArray) {
//        MyEventInfo *eventDecodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:dataObject];
//        [events addObject:eventDecodedObject];
//    }
//}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.myTableView) {
        return [tagEvents count];
    } else {
        return [searchResults count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 301;
    }
    else {
        return 29;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2.5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"CustomTableCell";
    static NSString *CellIdentifier2= @"CustomCellAddition";
    //    MyEventTableViewCell *cell;
    //    if (tableView == self.searchDisplayController.searchResultsTableView) {
    //        cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //    }else{
    //        cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //    }
    if (indexPath.row == 0) {
        MyEventTableViewCell *cell = (MyEventTableViewCell *)[self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier1];
        cell.imgviewOfEvent.clipsToBounds = YES;
        cell.imgviewOfEvent.layer.cornerRadius = 40;
        cell.authorProfileImgView.clipsToBounds = YES;
        cell.authorProfileImgView.layer.cornerRadius = 20;
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[MyEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        }
        
        // Display MyEventTableViewCell in the table cell
        MyEventInfo *event = nil;
        if (tableView == self.myTableView) {
            event = [tagEvents objectAtIndex:indexPath.section];
        } else {
            event = [searchResults objectAtIndex:indexPath.section];
        }
        
        cell.nameOfEvent.text = event.nameOfEvent;
        if (event.imageOfEvent != nil)
            cell.imgviewOfEvent.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:[event.imageOfEvent objectAtIndex:0] options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        cell.timeOfEvent.text = [[event.startingTime stringValue] stringByAppendingString:[event.endingTime stringValue]];
        cell.locationOfEvent.text = event.locationOfEvent;
        if (event.authorProfileImg != nil)
            cell.authorProfileImgView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:event.authorProfileImg options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        cell.authorOfEvent.text = event.authorName;
        cell.tagOfEvent.text = event.primaryTag;
        return cell;
    }
    else {
        
        MyEventTableViewAddCell *cell = (MyEventTableViewAddCell *)[self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier2];
        // Configure the cell...
        if (cell == nil) {
            cell = [[MyEventTableViewAddCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
        }
        
        cell.joinBtn.tag = indexPath.row;
        [cell.joinBtn addTarget:self action:@selector(joinBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        // Display MyEventTableViewCell in the table cell
        MyEventInfo *event = nil;
        if (tableView == self.myTableView) {
            event = [tagEvents objectAtIndex:indexPath.section];
        } else {
            event = [searchResults objectAtIndex:indexPath.section];
        }
        
        return cell;
    }
}

- (void)joinBtnPressed: (id)sender{
    UIButton *joinBtn = (UIButton *)sender;
    if (joinBtn.currentTitleColor == [UIColor redColor]) {
        [joinBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else {
        [joinBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showEventDetail"]) {
        NSIndexPath *indexPath = nil;
        MyEventInfo *event = nil;
        
        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            event = [searchResults objectAtIndex:indexPath.section];
        } else {
            indexPath = [self.myTableView indexPathForSelectedRow];
            event = [tagEvents objectAtIndex:indexPath.section];
        }
        
        MyEventDetailViewController *destViewController = segue.destinationViewController;
        destViewController.event = event;
    }
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"nameOfEvent contains[c] %@", searchText];
    searchResults = [tagEvents filteredArrayUsingPredicate:resultPredicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    return YES;
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
