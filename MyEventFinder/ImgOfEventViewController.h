//
//  ImgOfEventViewController.h
//  EventFinder
//
//  Created by Guo Xiaoyu on 11/11/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerHeader.h"

@interface ImgOfEventViewController : UIViewController<ELCImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, copy) NSArray *chosenImages;

// the default picker controller
- (IBAction)launchController;

// a special picker controller that limits itself to a single album, and lets the user
// pick just one image from that album.
- (IBAction)launchSpecialController;

@end
