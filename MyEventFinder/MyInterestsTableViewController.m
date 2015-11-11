//
//  MyInterestsTableViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/10/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyInterestsTableViewController.h"

@interface MyInterestsTableViewController ()
@property NSUserDefaults *usrDefault;
@end

@implementation MyInterestsTableViewController {
    NSMutableArray *interestsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.usrDefault = [NSUserDefaults standardUserDefaults];
    interestsArray = [[NSMutableArray alloc] initWithArray:[self.usrDefault objectForKey:@"interests"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    if ([interestsArray count] > 1) {
        if ([interestsArray containsObject:@"None"]) {
            [interestsArray removeObject:@"None"];
        }
    }
    if ([interestsArray count] == 0) {
        [interestsArray addObject:@"None"];
    }
    [self.usrDefault setObject:interestsArray forKey:@"interests"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"InterestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Free Food";
            break;
        case 1:
            cell.textLabel.text = @"Professional";
            break;
        case 2:
            cell.textLabel.text = @"Athletic";
            break;
        case 3:
            cell.textLabel.text = @"Social";
            break;
        case 4:
            cell.textLabel.text = @"Political";
            break;
        case 5:
            cell.textLabel.text = @"Seminar";
            break;
        case 6:
            cell.textLabel.text = @"Cornell Sponsored";
            break;
        default:
            break;
    }
    
    if ([interestsArray containsObject:cell.textLabel.text]) {
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
            if ([interestsArray containsObject:@"Free Food"]) {
                [interestsArray removeObject:@"Free Food"];
            }
            else {
                [interestsArray addObject:@"Free Food"];
            }
            break;
        case 1:
            if ([interestsArray containsObject:@"Professional"]) {
                [interestsArray removeObject:@"Professional"];
            }
            else {
                [interestsArray addObject:@"Professional"];
            }
            break;
        case 2:
            if ([interestsArray containsObject:@"Athletic"]) {
                [interestsArray removeObject:@"Athletic"];
            }
            else {
                [interestsArray addObject:@"Athletic"];
            }
            break;
        case 3:
            if ([interestsArray containsObject:@"Social"]) {
                [interestsArray removeObject:@"Social"];
            }
            else {
                [interestsArray addObject:@"Social"];
            }
            break;
        case 4:
            if ([interestsArray containsObject:@"Political"]) {
                [interestsArray removeObject:@"Political"];
            }
            else {
                [interestsArray addObject:@"Political"];
            }
            break;
        case 5:
            if ([interestsArray containsObject:@"Seminar"]) {
                [interestsArray removeObject:@"Seminar"];
            }
            else {
                [interestsArray addObject:@"Seminar"];
            }
            break;
        case 6:
            if ([interestsArray containsObject:@"Cornell Sponsored"]) {
                [interestsArray removeObject:@"Cornell Sponsored"];
            }
            else {
                [interestsArray addObject:@"Cornell Sponsored"];
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
