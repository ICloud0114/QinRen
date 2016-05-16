//
//  BookingCell.m
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "BookingCell.h"

@implementation BookingCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.borderWidth = 1;
    self.bgView.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0f].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
