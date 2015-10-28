//
//  MySearchViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/15/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MySearchViewController.h"
#import "MyEventInfo.h"
#import "MyEventTableViewCell.h"
#import "MyEventDetailViewController.h"
#import "UIViewController+RESideMenu.h"
#import "HideAndShowTabbarFunction.h"
#import "MyDataManager.h"

@interface MySearchViewController () {

}

@property NSUserDefaults *usrDefault;

@end

@implementation MySearchViewController {
    NSMutableArray *events;
    NSArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Initialize the events array

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    
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
    [HideAndShowTabbarFunction showTabBar:self.tabBarController];
//    [self reloadView];
}

- (void)reloadView {
    NSLog(@"reloadView");
//    [self extractEventArrayData];
//    events = [[NSMutableArray alloc] init];
//    events = [MyDataManager fetchEvent];
//    [self.myTableView reloadData];
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqual:@"didFinishFetchEvents"]) {
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
        return [events count];
    } else {
        return [searchResults count];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 263;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CustomTableCell";
//    MyEventTableViewCell *cell;
//    if (tableView == self.searchDisplayController.searchResultsTableView) {
//        cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    }else{
//        cell = [self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    }
    
    MyEventTableViewCell *cell = (MyEventTableViewCell *)[self.myTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.imageOfEvent.clipsToBounds = YES;
    cell.imageOfEvent.layer.cornerRadius = 50;
    cell.imageOfPoster.clipsToBounds = YES;
    cell.imageOfPoster.layer.cornerRadius = 20;
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[MyEventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Display MyEventTableViewCell in the table cell
    MyEventInfo *event = nil;
    if (tableView == self.myTableView) {
        event = [events objectAtIndex:indexPath.section];
    } else {
        event = [searchResults objectAtIndex:indexPath.section];
    }
    
    cell.nameOfEvent.text = event.nameOfEvent;
    cell.imageOfEvent.image = [UIImage imageWithData:event.imageOfEvent];
    cell.timeOfEvent.text = event.timeOfEvent;
    cell.locationOfEvent.text = event.locationOfEvent;
    cell.imageOfPoster.image = [UIImage imageWithData:event.imageOfPoster];
    cell.dateOfEvent.text = event.dateOfEvent;
    cell.posterOfEvent.text = event.posterOfEvent;
    return cell;
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
            event = [events objectAtIndex:indexPath.section];
        }
        
        MyEventDetailViewController *destViewController = segue.destinationViewController;
        destViewController.event = event;
    }
}

- (void)filterContentForSearchText:(NSString*)searchText
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"nameOfEvent contains[c] %@", searchText];
    searchResults = [events filteredArrayUsingPredicate:resultPredicate];
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
