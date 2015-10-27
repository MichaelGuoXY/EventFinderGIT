//
//  MyUserInfo.h
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/26/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUserInfo : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *whatsup;
@property (nonatomic, strong) NSData *usrProfileImage;
@property NSInteger myPostsNumber;
@property NSInteger myAttendanceNumber;

@end
