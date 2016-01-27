//
//  MyPostTableViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/20/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyPostTableViewController.h"
#import "MyPostTableViewCell.h"
#import "MyEventInfo.h"
#import "HideAndShowTabbarFunction.h"
#import "MyDataManager.h"
#import "MyHelpFunction.h"

@interface MyPostTableViewController ()

@property NSUserDefaults *usrDefault;

@end

@implementation MyPostTableViewController {
    NSMutableArray *events;
    NSArray *myPosts;
    NSArray *searchResults;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    self.tableView.separatorColor = [UIColor clearColor];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    self.searchDisplayController.searchResultsTableView.separatorColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"didFinishFetchEvents"
     object:nil];

    // Initialize the refresh control.
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor whiteColor];
    self.refreshControl.tintColor = [UIColor blackColor];
    [self.refreshControl addTarget:self
                  action:@selector(reloadView)
        forControlEvents:UIControlEventValueChanged];
}

- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqualToString:@"didFinishFetchEvents"]) {
        myPosts = [[NSArray alloc] init];
        [self filterEvensToMyPosts];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction hideTabBar:self.tabBarController];
    [self reloadView];
}

- (void)reloadView {
    events = [[NSMutableArray alloc] init];
    events = [MyDataManager fetchEvent];
}

//- (void)extractEventArrayData {
//    NSArray *dataArray = [[NSArray alloc] initWithArray:[self.usrDefault objectForKey:@"eventDataArray"]];
//    
//    for (NSData *dataObject in dataArray) {
//        MyEventInfo *eventDecodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:dataObject];
//        [events addObject:eventDecodedObject];
//    }
//}

- (void)filterEvensToMyPosts {
    NSString *searchText = [self.usrDefault objectForKey:@"username"];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"authorName == %@", searchText];
    myPosts = [events filteredArrayUsingPredicate:resultPredicate];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [myPosts count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 375;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MyPostTableCell";
    MyPostTableViewCell *cell;// = (MyPostTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[MyPostTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    // Display MyEventTableViewCell in the table cell
    MyEventInfo *event = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        event = [searchResults objectAtIndex:indexPath.row];
    } else {
        event = [myPosts objectAtIndex:indexPath.row];
    }
    
//    MyUserInfo *usr;
//    if ([event.participantsOfEvent count] != 0) {
//        usr = [event.participantsOfEvent objectAtIndex:0];
//    }
    
    cell.lNameOfEvent.text = event.nameOfEvent;
    cell.imageOfEvent.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:[event.imageOfEvent objectAtIndex:0] options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    cell.lTimeOfEvent.text = [MyHelpFunction parseTimeFromOrigin:event.startingTime];
    cell.lLocationOfEvent.text = event.locationOfEvent;
    cell.lDateOfEvent.text = [MyHelpFunction parseTimeFromOrigin:event.endingTime];
//    
//    if (usr != nil) {
//        cell.imageOfParticipants.image = [UIImage imageWithData:usr.usrProfileImage];
//    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(98.0, 0.0)];
    [path addLineToPoint:CGPointMake(98.0, 98.0)];
    [path moveToPoint:CGPointMake(98.0, 278.0)];
    [path addLineToPoint:CGPointMake(98.0, 375.0)];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    
    [cell.layer addSublayer:shapeLayer];
    return cell;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    if ([segue.identifier isEqualToString:@"showEventDetail"]) {
//        NSIndexPath *indexPath = nil;
//        MyEventInfo *event = nil;
//        
//        if (self.searchDisplayController.active) {
//            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
//            event = [searchResults objectAtIndex:indexPath.row];
//        } else {
//            indexPath = [self.tableView indexPathForSelectedRow];
//            event = [myEvents objectAtIndex:indexPath.row];
//        }
//        
//        MyEventDetailViewController *destViewController = segue.destinationViewController;
//        destViewController.event = event;
//    }
//}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"nameOfEvent contains[c] %@", searchText];
    searchResults = [myPosts filteredArrayUsingPredicate:resultPredicate];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
