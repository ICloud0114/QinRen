//
//  GoodsCell.m
//  QinRen
//
//  Created by Donny on 15/2/28.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "GoodsCell.h"
#import "UIImageView+WebCache.h"

@implementation GoodsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att
{

    self.nameLabel.text = att[@"name"];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:att[@"pics"]]];
   
    self.shopPrice.text= [NSString stringWithFormat:@"%@",att[@"needmoney"]];
     self.memberPrice.text= [NSString stringWithFormat:@"%@",att[@"salePirce"]];;

}

@end
