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
#import "MyUserInfo.h"

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
                                @"imageOfPoster" : imageOfPoster,
                                @"lngOfEvent"   : event.lngOfEvent,
                                @"latOfEvent"   : event.latOfEvent
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
                event.lngOfEvent = [event_dict objectForKey:@"lngOfEvent"];
                event.latOfEvent = [event_dict objectForKey:@"latOfEvent"];
                NSString *imageOfEvent = [event_dict objectForKey:@"imageOfEvent"];
                NSString *imageOfPoster = [event_dict objectForKey:@"imageOfPoster"];
                event.imageOfEvent = [[NSData alloc] initWithBase64EncodedString:imageOfEvent options:NSDataBase64DecodingIgnoreUnknownCharacters];
                event.imageOfPoster = [[NSData alloc] initWithBase64EncodedString:imageOfPoster options:NSDataBase64DecodingIgnoreUnknownCharacters];
                [events addObject:event];
            }
            [self postNotificationFinishFetchEvents];
        }
    }];
    return events;
}

+ (void)saveUser:(MyUserInfo *) user {
    NSString *usrProfileImage = [user.usrProfileImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *usrDict =   @{@"username" : user.username,
                                @"password" : user.password,
                                @"nickname" : user.nickname,
                                @"age" : user.age,
                                @"gender" : user.gender,
                                @"region" : user.region,
                                @"whatsup" : user.whatsup,
                                @"usrProfileImage" : usrProfileImage,
                                @"myPostsNumber" : [@(user.myPostsNumber) stringValue],
                                @"myAttendanceNumber" : [@(user.myAttendanceNumber) stringValue]
                                };
    // Create a reference to a Firebase database URL
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://blistering-inferno-5277.firebaseio.com"];
    Firebase *userRef = [myRootRef childByAppendingPath:@"users"];
    Firebase *nameRef = [userRef childByAppendingPath: user.username];
    [nameRef setValue: usrDict];
    [self postNotificationFinishSignUp];
}

+ (MyUserInfo *)fetchUser:(NSString *) username{
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://blistering-inferno-5277.firebaseio.com"];
    Firebase *userRef = [myRootRef childByAppendingPath:@"users"];
    Firebase *nameRef = [userRef childByAppendingPath:username];
    MyUserInfo *user = [MyUserInfo new];
    [nameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *user_dict = snapshot.value;
            user.username = [user_dict objectForKey:@"username"];
            user.password = [user_dict objectForKey:@"password"];
            user.nickname = [user_dict objectForKey:@"nickname"];
            user.age = [user_dict objectForKey:@"age"];
            user.gender = [user_dict objectForKey:@"gender"];
            user.region = [user_dict objectForKey:@"region"];
            user.whatsup = [user_dict objectForKey:@"whatsup"];
            NSString *usrProfileImage = [user_dict objectForKey:@"usrProfileImage"];
            user.usrProfileImage = [[NSData alloc] initWithBase64EncodedString:usrProfileImage options:NSDataBase64DecodingIgnoreUnknownCharacters];
            user.myPostsNumber = [[user_dict objectForKey:@"myPostsNumber"] integerValue];
            user.myAttendanceNumber = [[user_dict objectForKey:@"myAttendanceNumber"] integerValue];
            [self postNotificationFinishFetchUserInfo];
        }
        else {
            [self postNotificationUsernameNotFound];
        }
    }];
    return user;
}

+ (void)postNotificationFinishFetchEvents //post notification method and logic
{
    NSString *notificationName = @"didFinishFetchEvents";
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

+ (void)postNotificationFinishSignUp {
    NSString *notificationName = @"didFinishSignUp";
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

+ (void)postNotificationFinishFetchUserInfo {
    NSString *notificationName = @"didFinishFetchUserInfo";
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

+ (void)postNotificationUsernameNotFound {
    NSString *notificationName = @"usernameNotFound";
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}
@end
