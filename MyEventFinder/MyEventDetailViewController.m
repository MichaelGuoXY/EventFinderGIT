//
//  MyEventDetailViewController.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/12/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyEventDetailViewController.h"
#import "HideAndShowTabbarFunction.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MyEventDetailViewController () <GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *myNGIT;
@property (nonatomic, strong) GMSMapView *mapView;

@end

@implementation MyEventDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scroller setScrollEnabled:YES];
    [self.scroller setContentSize:CGSizeMake(320, 900)];
    self.myNGIT.title = self.event.nameOfEvent;
    self.posterOfEvent.text = self.event.posterOfEvent;
    self.nameOfEvent.text = self.event.nameOfEvent;
    self.timeOfEvent.text = self.event.timeOfEvent;
    self.dateOfEvent.text = self.event.dateOfEvent;
    self.locationOfEvent.text = self.event.locationOfEvent;
    self.infoOfEvent.text = self.event.introOfEvent;
    self.tagOfEvent.text = self.event.tagOfEvent;
    self.imageOfEvent.image = [UIImage imageWithData:self.event.imageOfEvent];
    self.imageOfPoster.image = [UIImage imageWithData:self.event.imageOfPoster];
    self.imageOfPoster.clipsToBounds = YES;
    self.imageOfPoster.layer.cornerRadius = 27;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgd6.png"]];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[self.event.latOfEvent doubleValue]
                                                            longitude:[self.event.lngOfEvent doubleValue]
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
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake([self.event.latOfEvent doubleValue], [self.event.lngOfEvent doubleValue]);
    marker.title = self.event.nameOfEvent;
    marker.snippet = self.event.locationOfEvent;
    marker.map = self.mapView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [HideAndShowTabbarFunction hideTabBar:self.tabBarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
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
