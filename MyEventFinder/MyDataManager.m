//
//  MyDataManager.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/25/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyDataManager.h"
#import "MyEventInfo.h"
#import <Firebase/Firebase.h>

@implementation MyDataManager

+ (void)saveEvent:(MyEventInfo *) event {
    NSString *imageOfEvent = [event.imageOfEvent base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSString *imageOfPoster = [event.imageOfPoster base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *eventDict = @{@"nameOfEvent" : event.nameOfEvent,
                                @"timeOfEvent" : event.timeOfEvent,
                                @"dateOfEvent" : event.dateOfEvent,
                                @"locationOfEvent" : event.locationOfEvent,
                                @"introOfEvent" : event.introOfEvent,
                                @"posterOfEvent" : event.posterOfEvent,
                                @"imageOfEvent" : imageOfEvent,
                                @"imageOfPoster" : imageOfPoster
                                };
    // Create a reference to a Firebase database URL
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://blistering-inferno-5277.firebaseio.com"];
    Firebase *eventRef = [myRootRef childByAppendingPath:@"events"];
    Firebase *nameRef = [eventRef childByAppendingPath: event.nameOfEvent];
    [nameRef setValue: eventDict];
}

+ (NSMutableArray *)fetchEvent{
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://blistering-inferno-5277.firebaseio.com"];
    Firebase *eventRef = [myRootRef childByAppendingPath:@"events"];
    NSMutableArray *events = [[NSMutableArray alloc] init];
    [eventRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *events_dict = snapshot.value;
            for (id key in events_dict) {
                NSDictionary *event_dict = [events_dict objectForKey:key];
                MyEventInfo *event = [MyEventInfo new];
                event.nameOfEvent = [event_dict objectForKey:@"nameOfEvent"];
                event.timeOfEvent = [event_dict objectForKey:@"timeOfEvent"];
                event.dateOfEvent = [event_dict objectForKey:@"dateOfEvent"];
                event.locationOfEvent = [event_dict objectForKey:@"locationOfEvent"];
                event.introOfEvent = [event_dict objectForKey:@"introOfEvent"];
                event.posterOfEvent = [event_dict objectForKey:@"posterOfEvent"];
                NSString *imageOfEvent = [event_dict objectForKey:@"imageOfEvent"];
                NSString *imageOfPoster = [event_dict objectForKey:@"imageOfPoster"];
                event.imageOfEvent = [[NSData alloc] initWithBase64EncodedString:imageOfEvent options:NSDataBase64DecodingIgnoreUnknownCharacters];
                event.imageOfPoster = [[NSData alloc] initWithBase64EncodedString:imageOfPoster options:NSDataBase64DecodingIgnoreUnknownCharacters];
                [events addObject:event];
            }
            [self postNotificationWithString];
        }
    }];
    return events;
}

+ (void)postNotificationWithString //post notification method and logic
{
    NSString *notificationName = @"EventDataLoadNotification";
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

@end
