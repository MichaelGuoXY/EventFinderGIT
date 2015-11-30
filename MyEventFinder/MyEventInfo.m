//
//  MyEventInfo.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/12/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyEventInfo.h"

@implementation MyEventInfo

@synthesize nameOfEvent;
@synthesize startingTime;
@synthesize endingTime;
@synthesize locationOfEvent;
@synthesize introOfEvent;
@synthesize lngOfEvent;
@synthesize latOfEvent;
@synthesize imageOfEvent;
@synthesize primaryTag;
@synthesize secondaryTag;
@synthesize restricttionOfEvent;
@synthesize participantsOfEvent;
@synthesize postTime;
@synthesize authorName;
@synthesize authorProfileImg;
@synthesize numberOfViewed;
@synthesize startingTimeString;
@synthesize endingTimeString;


- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.nameOfEvent = [decoder decodeObjectForKey:@"nameOfEvent"];
        self.startingTime = [decoder decodeObjectForKey:@"startingTime"];
        self.endingTime = [decoder decodeObjectForKey:@"endingTime"];
        self.locationOfEvent = [decoder decodeObjectForKey:@"locationOfEvent"];
        self.introOfEvent = [decoder decodeObjectForKey:@"introOfEvent"];
        self.latOfEvent = [decoder decodeObjectForKey:@"latOfEvent"];
        self.lngOfEvent = [decoder decodeObjectForKey:@"lngOfEvent"];
        self.imageOfEvent = [decoder decodeObjectForKey:@"imageOfEvent"];
        self.primaryTag = [decoder decodeObjectForKey:@"primaryTag"];
        self.secondaryTag = [decoder decodeObjectForKey:@"secondaryTag"];
        self.restricttionOfEvent = [decoder decodeObjectForKey:@"restricttionOfEvent"];
        self.participantsOfEvent = [decoder decodeObjectForKey:@"participantsOfEvent"];
        self.postTime = [decoder decodeObjectForKey:@"postTime"];
        self.authorName = [decoder decodeObjectForKey:@"authorName"];
        self.authorProfileImg = [decoder decodeObjectForKey:@"authorProfileImg"];
        self.numberOfViewed = [decoder decodeObjectForKey:@"numberOfViewed"];
        self.startingTimeString = [decoder decodeObjectForKey:@"startingTimeString"];
        self.endingTimeString = [decoder decodeObjectForKey:@"endingTimeString"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:nameOfEvent forKey:@"nameOfEvent"];
    [encoder encodeObject:startingTime forKey:@"startingTime"];
    [encoder encodeObject:endingTime forKey:@"endingTime"];
    [encoder encodeObject:locationOfEvent forKey:@"locationOfEvent"];
    [encoder encodeObject:introOfEvent forKey:@"introOfEvent"];
    [encoder encodeObject:latOfEvent forKey:@"latOfEvent"];
    [encoder encodeObject:lngOfEvent forKey:@"lngOfEvent"];
    [encoder encodeObject:imageOfEvent forKey:@"imageOfEvent"];
    [encoder encodeObject:primaryTag forKey:@"primaryTag"];
    [encoder encodeObject:secondaryTag forKey:@"secondaryTag"];
    [encoder encodeObject:restricttionOfEvent forKey:@"restricttionOfEvent"];
    [encoder encodeObject:participantsOfEvent forKey:@"participantsOfEvent"];
    [encoder encodeObject:postTime forKey:@"postTime"];
    [encoder encodeObject:authorName forKey:@"authorName"];
    [encoder encodeObject:authorProfileImg forKey:@"authorProfileImg"];
    [encoder encodeObject:numberOfViewed forKey:@"numberOfViewed"];
    [encoder encodeObject:startingTimeString forKey:@"startingTimeString"];
    [encoder encodeObject:endingTimeString forKey:@"endingTimeString"];
}

@end
