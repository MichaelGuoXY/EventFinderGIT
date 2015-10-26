//
//  MyEventInfo.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/12/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyEventInfo : NSObject<NSCoding> {
    NSString *nameOfEvent;
    NSString *timeOfEvent;
    NSString *dateOfEvent;
    NSString *locationOfEvent;
    NSString *introOfEvent;
    NSString *posterOfEvent;
    NSData *imageOfEvent;
    NSData *imageOfPoster;
}

@property (nonatomic, strong) NSString *nameOfEvent;
@property (nonatomic, strong) NSString *timeOfEvent;
@property (nonatomic, strong) NSString *dateOfEvent;
@property (nonatomic, strong) NSString *locationOfEvent;
@property (nonatomic, strong) NSString *introOfEvent;
@property (nonatomic, strong) NSString *posterOfEvent;
@property (nonatomic, strong) NSData *imageOfEvent;
@property (nonatomic, strong) NSData *imageOfPoster;

@end
