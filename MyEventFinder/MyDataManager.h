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
@interface MyDataManager : NSObject

+ (void)saveEvent:(MyEventInfo *) event;
+ (NSMutableArray *)fetchEvent;
+ (void)saveUser:(MyUserInfo *) user;
+ (MyUserInfo *)fetchUser:(NSString *) username;

@end
