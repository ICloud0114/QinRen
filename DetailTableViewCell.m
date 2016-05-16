//
//  DetailTableViewCell.m
//  QinRen
//
//  Created by Easaa on 15/4/2.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "DetailTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "PayView.h"



@implementation DetailTableViewCell

- (void)awakeFromNib {
        _minue.layer.borderWidth = 0.5;
    
        _minue.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:5].CGColor;
    
    
        _add.layer.borderWidth = 0.5;
    
        _add.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:5].CGColor;
    
        _quality.layer.borderWidth = 0.5;
    
        _quality.layer.borderColor = [UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:5].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
 @property (weak, nonatomic) IBOutlet UILabel *DescribLabel;
 @property (weak, nonatomic) IBOutlet UILabel *MarketLabel;
 @property (weak, nonatomic) IBOutlet UILabel *MemberLabel;
 @property (weak, nonatomic) IBOutlet UILabel *JifenLabel;
 @property (weak, nonatomic) IBOutlet UIImageView *headImageview;
 */
- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att
{
    _nameLabel.text= [NSString stringWithFormat:@"%@",att[@"goodsname"]]; ;
    _DescribLabel.text= [NSString stringWithFormat:@"%@",att[@"description"]];
    _MarketLabel.text= [NSString stringWithFormat:@"市 场 价:%@",att[@"groupprice"]];
     _MemberLabel.text= [NSString stringWithFormat:@"会 员 价:%@",att[@"returnintegral"]];
    [_headImageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",att[@"imgurl"]]] placeholderImage:nil];
}



- (IBAction)minue:(id)sender {
    
    _quality.text=0;
    
    int i = [self.quality.text intValue];
    if (i != 0) {
        [self.quality setText:[NSString stringWithFormat:@"%d",--i]];
    }
}

- (IBAction)add:(id)sender {
    
    int i = [self.quality.text intValue];
    [self.quality setText:[NSString stringWithFormat:@"%d",++i]];
}
@end
