//
//  PrimaryTagTableViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "PrimaryTagTableViewController.h"
#import "EventTagCell.h"

@interface PrimaryTagTableViewController ()
@property NSUserDefaults *usrDefault;

@end

@implementation PrimaryTagTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.usrDefault = [NSUserDefaults standardUserDefaults];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PrimaryTagCell";
    EventTagCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[EventTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([[self.usrDefault objectForKey:@"primaryTag"] isEqualToString:@"Professional Events"]) {
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if ([[self.usrDefault objectForKey:@"primaryTag"] isEqualToString:@"Athletics"]) {
        if (indexPath.row == 1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if ([[self.usrDefault objectForKey:@"primaryTag"] isEqualToString:@"Social Events"]) {
        if (indexPath.row == 2) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if ([[self.usrDefault objectForKey:@"primaryTag"] isEqualToString:@"Political Events"]) {
        if (indexPath.row == 3) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if ([[self.usrDefault objectForKey:@"primaryTag"] isEqualToString:@"Seminars"]) {
        if (indexPath.row == 4) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else if ([[self.usrDefault objectForKey:@"primaryTag"] isEqualToString:@"Performance Events"]) {
        if (indexPath.row == 5) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    switch (indexPath.row) {
        case 0:
            cell.tagLabelOfEvent.text = @"Professional Events";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"Professional.jpg"];
            break;
        case 1:
            cell.tagLabelOfEvent.text = @"Athletics";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"Athletics.jpg"];
            break;
        case 2:
            cell.tagLabelOfEvent.text = @"Social Events";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"Social.jpg"];
            break;
        case 3:
            cell.tagLabelOfEvent.text = @"Political Events";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"Political.jpg"];
            break;
        case 4:
            cell.tagLabelOfEvent.text = @"Seminars";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"Seminars.jpg"];
            break;
        case 5:
            cell.tagLabelOfEvent.text = @"Performance Events";
            cell.imageViewOfEvent.image = [UIImage imageNamed:@"Performance.jpg"];
        default:
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
            [self.usrDefault setObject:@"Professional Events" forKey:@"primaryTag"];
            break;
        case 1:
            [self.usrDefault setObject:@"Athletics" forKey:@"primaryTag"];
            break;
        case 2:
            [self.usrDefault setObject:@"Social Events" forKey:@"primaryTag"];
            break;
        case 3:
            [self.usrDefault setObject:@"Political Events" forKey:@"primaryTag"];
            break;
        case 4:
            [self.usrDefault setObject:@"Seminars" forKey:@"primaryTag"];
            break;
        case 5:
            [self.usrDefault setObject:@"Performance Events" forKey:@"primaryTag"];
            break;
        default:
            break;
    }

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
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
