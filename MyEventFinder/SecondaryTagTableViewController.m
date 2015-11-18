//
//  SecondaryTagTableViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "SecondaryTagTableViewController.h"
#import "EventTagCell.h"

@interface SecondaryTagTableViewController ()
@property NSUserDefaults *usrDefault;
@end

@implementation SecondaryTagTableViewController {
    NSMutableArray *secondaryTagArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    secondaryTagArray = [[NSMutableArray alloc] initWithArray:[self.usrDefault objectForKey:@"secondaryTag"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    if ([secondaryTagArray count] > 1) {
        if ([secondaryTagArray containsObject:@"None"]) {
            [secondaryTagArray removeObject:@"None"];
        }
    }
    if ([secondaryTagArray count] == 0) {
        [secondaryTagArray addObject:@"None"];
    }
    [self.usrDefault setObject:secondaryTagArray forKey:@"secondaryTag"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SecondaryTagCell";
    EventTagCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[EventTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.tagLabelOfEvent.text = @"Free Food";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"Free Food.jpg"];
            break;
        case 1:
            cell.tagLabelOfEvent.text = @"No Charge";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"No Charge.jpg"];
            break;
        case 2:
            cell.tagLabelOfEvent.text = @"Cornell Sponsored";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"Cornell Sponsored.jpg"];
            break;
        default:
            break;
    }
    
    if ([secondaryTagArray containsObject:cell.tagLabelOfEvent.text]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            if ([secondaryTagArray containsObject:@"Free Food"]) {
                [secondaryTagArray removeObject:@"Free Food"];
            }
            else {
                [secondaryTagArray addObject:@"Free Food"];
            }
            break;
        case 1:
            if ([secondaryTagArray containsObject:@"No Charge"]) {
                [secondaryTagArray removeObject:@"No Charge"];
            }
            else {
                [secondaryTagArray addObject:@"No Charge"];
            }
            break;
        case 2:
            if ([secondaryTagArray containsObject:@"Cornell Sponsored"]) {
                [secondaryTagArray removeObject:@"Cornell Sponsored"];
            }
            else {
                [secondaryTagArray addObject:@"Cornell Sponsored"];
            }
            break;
        default:
            break;
    }
    [tableView reloadData];
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
