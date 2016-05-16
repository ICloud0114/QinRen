//
//  AddDetectCell.m
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "AddDetectCell.h"

@implementation AddDetectCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)layoutSubviews
{
    if (self.style == AddDetectCellStyleTwoField)
    {
        if ([UIScreen mainScreen].bounds.size.width == 320)
        {
            self.lineLeftConstraint.constant = 60;
            self.fieldWidth.constant = 60;
        }else if ([UIScreen mainScreen].bounds.size.width == 375)
        {
            self.lineLeftConstraint.constant = 90;
            self.fieldWidth.constant = 70;
        }else if ([UIScreen mainScreen].bounds.size.width == 414)
        {
            self.lineLeftConstraint.constant = 110;
            self.fieldWidth.constant = 90;
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
