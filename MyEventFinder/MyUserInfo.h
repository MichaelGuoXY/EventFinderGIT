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
@property (nonatomic, strong) NSNumber *age;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *whatsup;
@property (nonatomic, strong) NSString *usrProfileImage;
@property (nonatomic, strong) NSNumber *myPostsNumber;
@property (nonatomic, strong) NSNumber *myAttendanceNumber;
@property (nonatomic, strong) NSArray *interests;
@property (nonatomic, strong) NSDictionary *incomeMsg;
/*
 users {
	String (timestamp): {
 username: String,
 passworld: String,
 age: Number,
 gender: String,
 myAttendanceNumber: Number,
 myPostNumber: Number,
 nickName: String,
 usrProfileImage: String,
 whatsup: String,
 interests: [0: String, 1: String, ...],
 
 incomeMsg: [String(timestamp): {
 sender: String (username),
 msg: String
 }, ...]
	}
 }
 */

@end
