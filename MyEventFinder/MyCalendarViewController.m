//
//  MyCalendarViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/14/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyCalendarViewController.h"
#import "CLWeeklyCalendarView.h"
#import "MyDataManager.h"
#import "HideAndShowTabbarFunction.h"
#import "MyEventTableViewCell.h"
#import "MyHelpFunction.h"
#import "MyEventTableViewAddCell.h"
#import "MyCalendarEventDetailViewController.h"

@interface MyCalendarViewController ()<CLWeeklyCalendarViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *viewContainCalendar;
@property (nonatomic, strong) CLWeeklyCalendarView* calendarView;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property NSDate *date;
@end

static CGFloat CALENDER_VIEW_HEIGHT = 150.f;

@implementation MyCalendarViewController {
    NSArray *events;
    NSArray *dateEvents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.calendarView];
//    [[NSNotificationCenter defaultCenter]
//     addObserver:self
//     selector:@selector(useNotificationWithString:)
//     name:@"didFinishFetchEvents"
//     object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //    [self reloadView];
//    events = [MyDataManager fetchEvent];
    events = [[NSArray alloc] init];
    events = [MyDataManager extractEventsFromUsrDefaults];
    [self dailyCalendarViewDidSelect:self.date];
    [self.myTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Initialize
-(CLWeeklyCalendarView *)calendarView
{
    if(!_calendarView){
        _calendarView = [[CLWeeklyCalendarView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, CALENDER_VIEW_HEIGHT)];
        _calendarView.delegate = self;
    }
    return _calendarView;
}

//- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
//{
//    if ([notification.name isEqual:@"didFinishFetchEvents"]) {
//        [self dailyCalendarViewDidSelect:self.date];
//        [self.myTableView reloadData];
//    }
//}

#pragma mark - CLWeeklyCalendarViewDelegate
-(NSDictionary *)CLCalendarBehaviorAttributes
{
    return @{
             CLCalendarWeekStartDay : @2,                 //Start Day of the week, from 1-7 Mon-Sun -- default 1
             //             CLCalendarDayTitleTextColor : [UIColor yellowColor],
             //             CLCalendarSelectedDatePrintColor : [UIColor greenColor],
             };
}

- (void)filterEvensToDate: (NSString *)dateNumber{
    NSPredicate *startingTimePredicate = [NSPredicate predicateWithFormat:@"startingTimeString CONTAINS[c] %@", dateNumber];
    NSPredicate *endingTimePredicate = [NSPredicate predicateWithFormat:@"endingTimeString CONTAINS[c] %@", dateNumber];
    NSArray *subPredicates = @[startingTimePredicate,endingTimePredicate];
    NSCompoundPredicate *resultPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:subPredicates];
    dateEvents = [events filteredArrayUsingPredicate:resultPredicate];
    [self.myTableView reloadData];
}

-(void)dailyCalendarViewDidSelect:(NSDate *)date
{
    //You can do any logic after the view select the date
    self.date = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    [self filterEvensToDate:dateString];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dateEvents count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 342;
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
        event = [dateEvents objectAtIndex:indexPath.section];
        
        cell.nameOfEvent.text = event.nameOfEvent;
        cell.timeOfPost.text = [MyHelpFunction parseTimeFromOrigin:event.postTime];
        if (event.imageOfEvent != nil)
            cell.imgviewOfEvent.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:[event.imageOfEvent objectAtIndex:0] options:NSDataBase64DecodingIgnoreUnknownCharacters]];
        cell.timeOfEvent.text = [[MyHelpFunction parseTimeFromOrigin:event.startingTime] stringByAppendingFormat:@" ~ %@",[MyHelpFunction parseTimeFromOrigin:event.endingTime]];
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
        event = [dateEvents objectAtIndex:indexPath.section];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyCalendarEventDetailViewController *myEDVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CalendarEventDetailVC"];
    myEDVC.event = [dateEvents objectAtIndex:indexPath.section];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [MyHelpFunction segueModalWithRandomTransition:self viewController:myEDVC];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
