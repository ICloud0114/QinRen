//
//  GroupPurchaseCell.m
//  QinRen
//
//  Created by Easaa on 15/4/1.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "GroupPurchaseCell.h"
#import "UIImageView+WebCache.h"

@implementation GroupPurchaseCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)dic
{
    /*
     @property (weak, nonatomic) IBOutlet UIImageView *headImage;
     @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
     @property (weak, nonatomic) IBOutlet UILabel *describLabel;
     @property (weak, nonatomic) IBOutlet UILabel *newpriceLabel;
     @property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
     @property (weak, nonatomic) IBOutlet UILabel *purchasePeople;
     */

    [_headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"pics"]]];
    _nameLabel.text=[NSString stringWithFormat:@"%@",dic[@"name"]];
    _newpriceLabel.text=[NSString stringWithFormat:@"%@",dic[@"salePirce"]];
    _oldPriceLabel.text=[NSString stringWithFormat:@"%@",dic[@"needmoney"]];
    _purchasePeople.text=[NSString stringWithFormat:@"%@",dic[@"buypeople"]];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
