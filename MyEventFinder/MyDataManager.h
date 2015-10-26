//
//  MyDataManager.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/25/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEventInfo.h"
@interface MyDataManager : NSObject

+ (void)saveEvent:(MyEventInfo *) event;
+ (NSMutableArray *)fetchEvent;

@end
