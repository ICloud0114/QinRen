//
//  PeopleCell.m
//  QinRen
//
//  Created by Donny on 15/3/1.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "PeopleCell.h"

@implementation PeopleCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att
{
    _iconView1.image=[UIImage imageNamed:@"zhongguoronge"];
}
@end
