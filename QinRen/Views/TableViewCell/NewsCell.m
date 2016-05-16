//
//  NewsCell.m
//  QinRen
//
//  Created by Donny on 15/3/2.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "NewsCell.h"
#import <QuartzCore/QuartzCore.h>
@implementation NewsCell

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


- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
