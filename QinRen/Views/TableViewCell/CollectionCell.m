//
//  CollectionCell.m
//  QinRen
//
//  Created by Easaa on 15/4/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att
{
    
    self.NameLab.text = att[@"name"];
    
    self.PriceLab.text= [NSString stringWithFormat:@"%@",att[@"needmoney"]];
    self.OldPriceLab.text= [NSString stringWithFormat:@"%@",att[@"salePirce"]];;
     self.JifenLab.text= [NSString stringWithFormat:@"%@",att[@"salePirce"]];;
    
}
@end
