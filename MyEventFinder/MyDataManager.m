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
#import "MyHelpFunction.h"

@implementation MyDataManager

+ (void)saveEvent:(MyEventInfo *) event withUIViewController:(UIViewController *) thisVC {
    /*
     nameOfEvent: String,
     startingTime: Number, // hour + minute
     endingTime: Number,
     latOfEvent: Number,
     lngOfEvent: Number,
     locationOfEvent: String,
     primaryTag: String,
     secondaryTag: [0: String, 1: String, ...],
     introOfEvent: String,
     restrictionOfEvent: String,
     imageOfEvent: [0: String, 1: String, ...],
     
     postDate: Number,
     postTime: Number,
     authorName: String,
     authorProfileImg: String,
     participantsOfEvent: [String (timestamp) {
     username: String,
     usrProfileImage: String
     }, ...]
     */
    NSDictionary *eventDict = @{@"nameOfEvent" : event.nameOfEvent,
                                @"startingTime" : event.startingTime,
                                @"endingTime" : event.endingTime,
                                @"latOfEvent"   : event.latOfEvent,
                                @"lngOfEvent"   : event.lngOfEvent,
                                @"locationOfEvent" : event.locationOfEvent,
                                @"primaryTag" : event.primaryTag,
                                @"secondaryTag" : event.secondaryTag,
                                @"introOfEvent" : event.introOfEvent,
                                @"restrictionOfEvent" : event.restricttionOfEvent,
                                @"imageOfEvent" : event.imageOfEvent,
                                @"postTime" : event.postTime,
                                @"authorName" : event.authorName,
                                @"authorProfileImg" : event.authorProfileImg,
                                @"numberOfViewed" : @0
                                };
    // Create a reference to a Firebase database URL
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *eventRef = [myRootRef childByAppendingPath:@"events"];
    Firebase *timestampRef = [eventRef childByAutoId];
    @try {
        [timestampRef setValue:eventDict withCompletionBlock:^(NSError *error, Firebase *ref) {
            if (error) {
                UIAlertController* failToPostEvent = [UIAlertController alertControllerWithTitle:@"Alert !!!" message:@"Fail To Post This Event !!!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
                [failToPostEvent addAction:alertAction];
                [thisVC presentViewController:failToPostEvent animated:YES completion:nil];
            } else {
                UIAlertController* succeedToPostEvent = [UIAlertController alertControllerWithTitle:@"Cool !!!" message:@"Event Has Been Successfully Posted !!!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* alertAction = [UIAlertAction actionWithTitle:@"Got it" style:UIAlertActionStyleCancel handler:^(UIAlertAction* action) {}];
                [succeedToPostEvent addAction:alertAction];
                [thisVC presentViewController:succeedToPostEvent animated:YES completion:nil];
            }
        }];
    }
    @catch (NSException *exception) {
        [MyHelpFunction presentAlertViewWithoutAction:thisVC withTitle:@"Alert !!!" withMessage:exception.description withActionTitle:@"Got it"];
    }
    @finally {
        
    }
    
}

+ (NSMutableArray *)fetchEvent{
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *eventRef = [myRootRef childByAppendingPath:@"events"];
    NSMutableArray *events = [[NSMutableArray alloc] init];
    [eventRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *events_dict = snapshot.value;
            for (id key in events_dict) {
                NSDictionary *event_dict = [events_dict objectForKey:key];
                MyEventInfo *event = [MyEventInfo new];
                event.nameOfEvent = [event_dict objectForKey:@"nameOfEvent"];
                event.startingTime = [event_dict objectForKey:@"startingTime"];
                event.endingTime = [event_dict objectForKey:@"endingTime"];
                event.startingTimeString = [event.startingTime stringValue];
                event.endingTimeString = [event.endingTime stringValue];
                event.locationOfEvent = [event_dict objectForKey:@"locationOfEvent"];
                event.introOfEvent = [event_dict objectForKey:@"introOfEvent"];
                event.restricttionOfEvent = [event_dict objectForKey:@"restrictionOfEvent"];
                event.primaryTag = [event_dict objectForKey:@"primaryTag"];
                // array
                event.secondaryTag = [event_dict objectForKey:@"secondaryTag"];
                event.lngOfEvent = [event_dict objectForKey:@"lngOfEvent"];
                event.latOfEvent = [event_dict objectForKey:@"latOfEvent"];
                // array
                event.imageOfEvent = [event_dict objectForKey:@"imageOfEvent"];
                event.postTime = [event_dict objectForKey:@"postTime"];
                event.authorName = [event_dict objectForKey:@"authorName"];
                event.authorProfileImg = [event_dict objectForKey:@"authorProfileImg"];
                event.numberOfViewed = [event_dict objectForKey:@"numberOfViewed"];
//              event.imageOfPoster = [[NSData alloc] initWithBase64EncodedString:imageOfPoster options:NSDataBase64DecodingIgnoreUnknownCharacters];
                // dictionary
                if ([event_dict objectForKey:@"participantsOfEvent"] != nil)
                    event.participantsOfEvent = [event_dict objectForKey:@"participantsOfEvent"];
                
                [events addObject:event];
            }
            [self postNotificationFinishFetchEvents];
        }
    }];
    return events;
}

+ (void)hasViewedThisEvent:(MyEventInfo *)event {
    // Create a reference to a Firebase database URL
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *eventRef = [myRootRef childByAppendingPath:@"events"];
    FQuery *nameRef = [[eventRef queryOrderedByChild:@"nameOfEvent"] queryEqualToValue:event.nameOfEvent];
    [nameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *dict = snapshot.value;
            NSString *keyForEvent = [[dict allKeys]objectAtIndex:0];
            NSNumber *originViewedNumber = [[dict objectForKey:keyForEvent] objectForKey:@"numberOfViewed"];
            NSNumber *updatedViewedNumer = [[NSNumber alloc] initWithInteger:[originViewedNumber integerValue] + 1];
            [[[[snapshot.ref childByAppendingPath:keyForEvent] childByAppendingPath:@"numberOfViewed"] childByAutoId] setValue:updatedViewedNumer];
        }
    }];
}

+ (void)saveUser:(MyUserInfo *) user {
    /*
     username: String,
     password: String,
     age: Number,
     gender: String,
     myAttendanceNumber: Number,
     myPostNumber: Number,
     nickname: String,
     usrProfileImage: String,
     whatsup: String,
     interests: [0: String, 1: String, ...],
     
     incomeMsg: [String(timestamp): {
     sender: String (username),
     msg: String 
     }, ...]
     */
    NSDictionary *usrDict =   @{@"username" : user.username,
                                @"password" : user.password,
                                @"nickname" : user.nickname,
                                @"age" : user.age,
                                @"gender" : user.gender,
                                @"whatsup" : user.whatsup,
                                @"usrProfileImage" : user.usrProfileImage,
                                @"myPostsNumber" : user.myPostsNumber,
                                @"myAttendanceNumber" : user.myAttendanceNumber,
                                @"interests" : user.interests
                                };
    // Create a reference to a Firebase database URL
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *userRef = [myRootRef childByAppendingPath:@"users"];
    Firebase *timestampRef = [userRef childByAutoId];
    [timestampRef setValue: usrDict];
    [self postNotificationFinishSignUp];
}

+ (MyUserInfo *)fetchUser:(NSString *) username{
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *userRef = [myRootRef childByAppendingPath:@"users"];
    FQuery *nameRef = [[userRef queryOrderedByChild:@"username"] queryEqualToValue:username];
    MyUserInfo *user = [MyUserInfo new];
    [nameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *dict = snapshot.value;
            NSDictionary *user_dict = [[dict allValues] objectAtIndex:0];
            user.username = [user_dict objectForKey:@"username"];
            user.password = [user_dict objectForKey:@"password"];
            user.nickname = [user_dict objectForKey:@"nickname"];
            user.age = [user_dict objectForKey:@"age"];
            user.gender = [user_dict objectForKey:@"gender"];
            user.whatsup = [user_dict objectForKey:@"whatsup"];
            user.usrProfileImage = [user_dict objectForKey:@"usrProfileImage"];
            user.myPostsNumber = [user_dict objectForKey:@"myPostsNumber"];
            user.myAttendanceNumber = [user_dict objectForKey:@"myAttendanceNumber"];
            user.interests = [user_dict objectForKey:@"interests"];
            [self postNotificationFinishFetchUserInfo];
        }
        else {
            [self postNotificationUsernameNotFound];
        }
    }];
    return user;
}

+ (void)updateUser:(MyUserInfo *) user {
    NSDictionary *user_dict = @{@"username" : user.username,
                                @"password" : user.password,
                                @"nickname" : user.nickname,
                                @"age" : user.age,
                                @"gender" : user.gender,
                                @"whatsup" : user.whatsup,
                                @"usrProfileImage" : user.usrProfileImage,
                                @"myPostsNumber" : user.myPostsNumber,
                                @"myAttendanceNumber" : user.myAttendanceNumber,
                                @"interests" : user.interests
                                };
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *userRef = [myRootRef childByAppendingPath:@"users"];
    FQuery *nameRef = [[userRef queryOrderedByChild:@"username"] queryEqualToValue:user.username];
    
    [nameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *dict = snapshot.value;
            NSString *keyForUser = [[dict allKeys] objectAtIndex:0];
            [[snapshot.ref childByAppendingPath:keyForUser] setValue:user_dict];
        }
    }];

}

+ (void)updateUser:(NSString *) username postsNumber:(NSNumber *) myPostsNumber {
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *userRef = [myRootRef childByAppendingPath:@"users"];
    FQuery *nameRef = [[userRef queryOrderedByChild:@"username"] queryEqualToValue:username];
    
    [nameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *dict = snapshot.value;
            NSString *keyForUser = [[dict allKeys] objectAtIndex:0];
            [[[snapshot.ref childByAppendingPath:keyForUser] childByAppendingPath:@"myPostsNumber"] setValue:myPostsNumber];
        }
    }];
}

+ (void)updateUser:(NSString *) username usrProfileImg:(NSString *) usrProfileImg {
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *userRef = [myRootRef childByAppendingPath:@"users"];
    FQuery *nameRef = [[userRef queryOrderedByChild:@"username"] queryEqualToValue:username];
    
    [nameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *dict = snapshot.value;
            NSString *keyForUser = [[dict allKeys] objectAtIndex:0];
            [[[snapshot.ref childByAppendingPath:keyForUser] childByAppendingPath:@"usrProfileImage"] setValue:usrProfileImg];
        }
    }];
}

+ (void)saveParticipantToEvent:(MyEventInfo *)event withUser:(MyUserInfo *)user {
    NSDictionary *usrDict =   @{@"username" : user.username,
                                @"usrProfileImage" : user.usrProfileImage,
                                };
    // Create a reference to a Firebase database URL
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *eventRef = [myRootRef childByAppendingPath:@"events"];
    FQuery *nameRef = [[eventRef queryOrderedByChild:@"nameOfEvent"] queryEqualToValue:event.nameOfEvent];
    [nameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *dict = snapshot.value;
            NSString *keyForEvent = [[dict allKeys]objectAtIndex:0];
            [[[[snapshot.ref childByAppendingPath:keyForEvent] childByAppendingPath:@"participantsOfEvent"] childByAutoId] setValue:usrDict];
        }
    }];
}

+ (void)removeParticipantFromEvent:(MyEventInfo *)event withUser:(MyUserInfo *)user {
    // Create a reference to a Firebase database URL
    Firebase *myRootRef = [[Firebase alloc] initWithUrl:@"https://event-finder.firebaseio.com"];
    Firebase *eventRef = [myRootRef childByAppendingPath:@"events"];
    FQuery *nameRef = [[eventRef queryOrderedByChild:@"nameOfEvent"] queryEqualToValue:event.nameOfEvent];
    
    [nameRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if (snapshot.value != [NSNull null]) {
            NSDictionary *dict = snapshot.value;
            NSString *keyForEvent = [[dict allKeys]objectAtIndex:0];
            [[[[[snapshot.ref childByAppendingPath:keyForEvent] childByAppendingPath:@"participantsOfEvent"] queryOrderedByChild:@"username"] queryEqualToValue:user.username] observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
                if (snapshot.value != [NSNull null]) {
                    NSDictionary *dict = snapshot.value;
                    NSString *keyForEvent = [[dict allKeys] objectAtIndex:0];
                    [[snapshot.ref childByAppendingPath:keyForEvent] removeValue];
                }
            }];
        }
    }];
}

+ (void)saveEventsToUsrDefaults:(NSArray *)events {
    
    NSMutableArray *archiveArray = [NSMutableArray arrayWithCapacity:events.count];
    for (MyEventInfo *event in events) {
        NSData *eventEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:event];
        [archiveArray addObject:eventEncodedObject];
    }
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    [usrDefault setObject:archiveArray forKey:@"events"];
}

+ (NSMutableArray *)extractEventsFromUsrDefaults {
    NSMutableArray *events = [[NSMutableArray alloc] init];
    NSUserDefaults *usrDefault = [NSUserDefaults standardUserDefaults];
    NSArray *dataArray = [[NSArray alloc] initWithArray:[usrDefault objectForKey:@"events"]];
    for (NSData *dataObject in dataArray) {
        MyEventInfo *eventDecodedObject = [NSKeyedUnarchiver unarchiveObjectWithData:dataObject];
        [events addObject:eventDecodedObject];
    }
    return events;
}

//+ (void)useNotificationWithString:(NSNotification *)notification //use notification method and logic
//{
//    if ([notification.name isEqualToString:@"didFinishFetchUserInfo"]) {
//        numberOfParticipants --;
//        if (numberOfParticipants == 0) {
//            [MyDataManager postNotificationFinishFetchParticipants];
//        }
//    }
//}

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

+ (void)postNotificationFinishFetchParticipants
{
    NSString *notificationName = @"didFinishFetchParticipants";
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];

}
//
//
//+ (void) downloadDataCompleted: (void (^) (NSString *output, NSNumber *count))completion
//{
//    // download
//    NSString *downloadedString = @"123";
//    NSNumber *downloadedNumber = @123;
//    // download finished
//    completion(downloadedString, downloadedNumber);
//}


@end
