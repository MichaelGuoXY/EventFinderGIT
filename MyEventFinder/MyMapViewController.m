//
//  MyMapViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MyDataManager.h"
#import "MyEventDetailViewController.h"
#import "HideAndShowTabbarFunction.h"

@interface MyMapViewController () <GMSMapViewDelegate>
@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, strong) NSMutableSet *markers;
@end

@implementation MyMapViewController {
    NSMutableArray *events;
    MyEventInfo *filterResult;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:42.444782
                                                            longitude:-76.484174
                                                                 zoom:16
                                                              bearing:0
                                                         viewingAngle:0];
        
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    self.mapView.delegate = self;
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.mapView setMinZoom:10 maxZoom:30];
    
    [self.view addSubview:self.mapView];
//    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(42.444782, -76.484174);
//    marker.title = @"Free Food";
//    marker.snippet = @"Carpentar Library";
//    marker.map = self.mapView;
    
    // init notification
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(useNotificationWithString:)
     name:@"didFinishFetchEvents"
     object:nil];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction showTabBar:self.tabBarController];
    // load events
    events = [[NSMutableArray alloc] init];
    events = [MyDataManager fetchEvent];
    
}
- (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
{
    if ([notification.name isEqualToString:@"didFinishFetchEvents"]) {
        [self setupMarkers];
        [self drawMarkers];
    }
}

- (void)setupMarkers {
    self.markers = [[NSMutableSet alloc] init];
    for (MyEventInfo *event in events) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.title = event.nameOfEvent;
        marker.snippet = event.locationOfEvent;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.position = CLLocationCoordinate2DMake([event.latOfEvent doubleValue], [event.lngOfEvent doubleValue]);
        [self.markers addObject:marker];
    }
}

- (void)drawMarkers {
    for (GMSMarker *marker in self.markers) {
        marker.map = self.mapView;
    }
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    UIView *infoWindow = [[UIView alloc] init];
    infoWindow.frame = CGRectMake(0, 0, 200, 70);
    infoWindow.backgroundColor = [UIColor whiteColor];
    
//    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"infoWindow"]];
//    [infoWindow addSubview:backgroundImage];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = CGRectMake(14, 11, 175, 16);
    [infoWindow addSubview:titleLabel];
    titleLabel.text = marker.title;
    
    UILabel *snippetLabel = [[UILabel alloc] init];
    snippetLabel.frame = CGRectMake(14, 42, 175, 16);
    [infoWindow addSubview:snippetLabel];
    snippetLabel.text = marker.snippet;
    
    return infoWindow;
}

- (void)filterEvensToMarker:(NSString *)searchText {
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"nameOfEvent == %@", searchText];
    filterResult = [[events filteredArrayUsingPredicate:resultPredicate] objectAtIndex:0];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    [self filterEvensToMarker:marker.title];
    MyEventDetailViewController *myEDVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MapEventDetailViewController"];
    myEDVC.event =filterResult;
    [self presentViewController:myEDVC animated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.mapView.padding = UIEdgeInsetsMake(0, 0, self.bottomLayoutGuide.length + 5, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showEventDetail"]) {
        
        MyEventInfo *event = filterResult;
        MyEventDetailViewController *destViewController = segue.destinationViewController;
        destViewController.event = event;
    }
}
*/

@end
