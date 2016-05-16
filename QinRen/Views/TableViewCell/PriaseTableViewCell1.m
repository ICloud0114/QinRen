//
//  PriaseTableViewCell1.m
//  QinRen
//
//  Created by Easaa on 15/4/3.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "PriaseTableViewCell1.h"
#import "UIImageView+WebCache.h"

@implementation PriaseTableViewCell1

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 @property (weak, nonatomic) IBOutlet UILabel *TotalPriaseLab;
 @property (weak, nonatomic) IBOutlet UILabel *userNameLab;
 @property (weak, nonatomic) IBOutlet UILabel *contentLab;
 @property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
*/
-(void)updatePriaseTableViewCell1UiWithAttributes:(NSDictionary *)dic
{
    _TotalPriaseLab.text=[NSString stringWithFormat:@"%@",dic[@"commtime"]];
    _userNameLab.text=[NSString stringWithFormat:@"%@",dic[@"username"]];
    _contentLab.text=[NSString stringWithFormat:@"%@",dic[@"content"]];
    
    
//    [_userHeadImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dic[@"Icon"]]]];
    
}

//-(void)setEntity:(PriaseModel *)entity
//{
//    _entity=entity;
//    
//    _TotalPriaseLab.text=entity.time;
//    _contentLab.text=entity.content;
//    
//    
//}
@end
