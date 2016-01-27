//
//  MyDataManager.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/25/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEventInfo.h"
#import "MyUserInfo.h"
#import <UIKit/UIKit.h>

@interface MyDataManager : NSObject

+ (void)saveEvent:(MyEventInfo *) event withUIViewController:(UIViewController *) thisVC;
+ (NSMutableArray *)fetchEvent;
+ (void)saveUser:(MyUserInfo *) user;
+ (MyUserInfo *)fetchUser:(NSString *) username;
+ (void)saveParticipantToEvent:(MyEventInfo *)event withUser:(MyUserInfo *)user;
+ (void)removeParticipantFromEvent:(MyEventInfo *)event withUser:(MyUserInfo *)user;
+ (void)updateUser:(MyUserInfo *) user;
+ (void)updateUser:(NSString *) username postsNumber:(NSNumber *) myPostsNumber;
+ (void)updateUser:(NSString *) username usrProfileImg:(NSString *) usrProfileImg;
+ (void)saveEventsToUsrDefaults:(NSArray *)events;
+ (NSArray *)extractEventsFromUsrDefaults;

@end
