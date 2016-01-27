//
//  MyPostTableViewCell.m
//  MyEventFinder
//
//  Created by Guo Xiaoyu on 10/20/15.
//  Copyright © 2015 Xiaoyu Guo. All rights reserved.
//

#import "MyPostTableViewCell.h"

@implementation MyPostTableViewCell

//- (void)awakeFromNib {
//    // Initialization code
//}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageOfEvent = [[UIImageView alloc] initWithFrame:CGRectMake(8, 98, 180, 180)];
        self.imageOfEvent.clipsToBounds = YES;
        self.imageOfEvent.layer.cornerRadius = 90;
        self.imageOfEvent.layer.borderColor = [UIColor blackColor].CGColor;
        self.imageOfEvent.layer.borderWidth = 0.5f;
        [self.contentView addSubview:self.imageOfEvent];
        
        self.lNameOfEvent = [[UILabel alloc] initWithFrame:CGRectMake(137, 20, 175, 21)];
        [self.contentView addSubview:self.lNameOfEvent];
        self.lNameOfEvent.adjustsFontSizeToFitWidth = YES;
        self.lNameOfEvent.numberOfLines = 0;
        self.nameImg = [[UIImageView alloc] initWithFrame:CGRectMake(120, 20, 14, 14)];
        self.nameImg.image = [UIImage imageNamed:@"star2.png"];
        [self.contentView addSubview:self.nameImg];
        
        self.lTimeOfEvent = [[UILabel alloc] initWithFrame:CGRectMake(137, 49, 175, 21)];
        [self.contentView addSubview:self.lTimeOfEvent];
        self.lTimeOfEvent.adjustsFontSizeToFitWidth = YES;
        self.lTimeOfEvent.numberOfLines = 0;
        self.timeImg = [[UIImageView alloc] initWithFrame:CGRectMake(120, 49, 14, 14)];
        self.timeImg.image = [UIImage imageNamed:@"time.png"];
        [self.contentView addSubview:self.timeImg];
        
        self.imageOfParticipants = [[UIImageView alloc] initWithFrame:CGRectMake(260, 170, 44, 44)];
        self.imageOfParticipants.clipsToBounds = YES;
        self.imageOfParticipants.layer.cornerRadius = 22;
        [self.contentView addSubview:self.imageOfParticipants];
        
        self.lDateOfEvent = [[UILabel alloc] initWithFrame:CGRectMake(137, 289, 175, 21)];
        [self.contentView addSubview:self.lDateOfEvent];
        self.lDateOfEvent.adjustsFontSizeToFitWidth = YES;
        self.lDateOfEvent.numberOfLines = 0;
        self.dateImg = [[UIImageView alloc] initWithFrame:CGRectMake(120, 289, 14, 14)];
        self.dateImg.image = [UIImage imageNamed:@"date.png"];
        [self.contentView addSubview:self.dateImg];
        
        self.lLocationOfEvent = [[UILabel alloc] initWithFrame:CGRectMake(137, 318, 175, 21)];
        [self.contentView addSubview:self.lLocationOfEvent];
        self.lLocationOfEvent.adjustsFontSizeToFitWidth = YES;
        self.lLocationOfEvent.numberOfLines = 0;
        self.locationImg = [[UIImageView alloc] initWithFrame:CGRectMake(120,318, 14, 14)];
        self.locationImg.image = [UIImage imageNamed:@"location.png"];
        [self.contentView addSubview:self.locationImg];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
