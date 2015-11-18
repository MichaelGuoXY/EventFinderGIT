//
//  MyCategoryTableViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/29/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyCategoryTableViewController.h"
#import "MyCategoryTableViewCell.h"
#import "MyCategorySearchViewController.h"
#import "HideAndShowTabbarFunction.h"

@interface MyCategoryTableViewController ()

@end

@implementation MyCategoryTableViewController {
    NSArray *titles;
    NSArray *images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    titles = @[@"Free Food", @"Professional Events", @"Athletics", @"Social Events", @"Political Events", @"Seminars", @"Performance Events", @"Cornell Sponsored"];
    images = @[@"Free Food.jpg", @"Professional.jpg", @"Athletics.jpg", @"Social.jpg", @"Political.jpg", @"Seminars.jpg", @"Performance.jpg", @"Cornell Sponsored.jpg"];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction showTabBar:self.tabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 251;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CategoryCell";
    MyCategoryTableViewCell *cell = (MyCategoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[MyCategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.nameOfCategory.text = titles[indexPath.row];
    if (indexPath.row == 1 || indexPath.row == 6 ) {
        cell.nameOfCategory.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:38];
    }
    if (indexPath.row == 7) {
        cell.nameOfCategory.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:41];
        //Helvetica Neue Bold 45.0
    }
    cell.imageOfCategory.image = [UIImage imageNamed:images[indexPath.row]];

    return cell;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showCategoryEvent"]) {
        NSIndexPath *indexPath = nil;
        
        indexPath = [self.tableView indexPathForSelectedRow];
        NSString *tagSelected = [titles objectAtIndex:indexPath.row];


        MyCategorySearchViewController *destViewController = segue.destinationViewController;
        destViewController.tag = tagSelected;
    }

}


@end
