//
//  CollectNEWCell.m
//  QinRen
//
//  Created by Easaa on 15/4/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "CollectNEWCell.h"

@implementation CollectNEWCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att
{
    
   // self..text = att[@"name"];
    
    self.TimeLab.text= [NSString stringWithFormat:@"%@",att[@"needmoney"]];
    self.TimeLab.text= [NSString stringWithFormat:@"%@",att[@"salePirce"]];;
    self.DecLab.text= [NSString stringWithFormat:@"%@",att[@"salePirce"]];;
    
}
@end
