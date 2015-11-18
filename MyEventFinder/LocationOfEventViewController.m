//
//  LocationOfEventViewController.m
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "LocationOfEventViewController.h"
#import "ViewController.h"
#import "MVPlaceSearchTextField.h"
#import <GoogleMaps/GoogleMaps.h>

@interface LocationOfEventViewController ()<PlaceSearchTextFieldDelegate,UITextFieldDelegate,GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet MVPlaceSearchTextField *txtPlaceSearch;
@property (nonatomic, strong) GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *mapViewContainer;

@end

@implementation LocationOfEventViewController {
    NSUserDefaults *usrDefault;
    NSString *locationOfEvent;
    double longtitude;
    double latitude;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    longtitude = 0;
    latitude = 0;
    usrDefault = [NSUserDefaults standardUserDefaults];
    
    _txtPlaceSearch.placeSearchDelegate                 = self;
    _txtPlaceSearch.strApiKey                           = @"AIzaSyBWZjd3ro_03SSKIQOZ0C2cQOCK9YoHpxE";
    _txtPlaceSearch.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    _txtPlaceSearch.autoCompleteShouldHideOnSelection   = YES;
    _txtPlaceSearch.maximumNumberOfAutoCompleteRows     = 5;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:42.444782
                                                            longitude:-76.484174
                                                                 zoom:16
                                                              bearing:0
                                                         viewingAngle:0];
    
    self.mapView = [GMSMapView mapWithFrame:self.mapViewContainer.bounds camera:camera];
    self.mapView.delegate = self;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10 maxZoom:30];
    
    [self.mapViewContainer addSubview:self.mapView];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    if (longtitude != 0 && latitude != 0) {
        [usrDefault setObject:[NSNumber numberWithDouble:longtitude] forKey:@"longtitude"];
        [usrDefault setObject:[NSNumber numberWithDouble:latitude] forKey:@"latitude"];
        [usrDefault setObject:locationOfEvent forKey:@"locationOfEvent"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    
    //Optional Properties
    _txtPlaceSearch.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    _txtPlaceSearch.autoCompleteBoldFontName = @"HelveticaNeue";
    _txtPlaceSearch.autoCompleteTableCornerRadius=0.0;
    _txtPlaceSearch.autoCompleteRowHeight=35;
    _txtPlaceSearch.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.000];
    _txtPlaceSearch.autoCompleteFontSize=14;
    _txtPlaceSearch.autoCompleteTableBorderWidth=1.0;
    _txtPlaceSearch.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    _txtPlaceSearch.autoCompleteShouldHideOnSelection=YES;
    _txtPlaceSearch.autoCompleteShouldHideClosingKeyboard=YES;
    _txtPlaceSearch.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    _txtPlaceSearch.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_txtPlaceSearch.frame.size.width)*0.5, _txtPlaceSearch.frame.size.height+100.0, _txtPlaceSearch.frame.size.width, 200.0);
}

#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    NSLog(@"SELECTED ADDRESS :%@",responseDict);
    [self drawMarkers:responseDict];
}

-(void)drawMarkers: (GMSPlace*) place{
    [self.mapView clear];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.title = [place name];
    marker.snippet = [place formattedAddress];
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.position = [place coordinate];
    marker.map = self.mapView;
    longtitude = place.coordinate.longitude;
    latitude = place.coordinate.latitude;
    locationOfEvent = place.name;
    [self.mapView animateToLocation:place.coordinate];
}

-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
    
}

-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
}

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    if(index%2==0){
        cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    }else{
        cell.contentView.backgroundColor = [UIColor whiteColor];
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
