//
//  PraseCell.m
//  QinRen
//
//  Created by Easaa on 15/4/3.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "PraseCell.h"
#import "PriaseController.h"
#import "UIImageView+WebCache.h"

@implementation PraseCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
 @property (weak, nonatomic) IBOutlet UILabel *totalpraise;
 @property (weak, nonatomic) IBOutlet UIImageView *UserImageView;
 
 @property (weak, nonatomic) IBOutlet UILabel *UserName;
 @property (weak, nonatomic) IBOutlet UILabel *ContentPriase;
- (IBAction)MoreDetaimPic:(id)sender;
 */


-(void)updatePraseCellUiWithAttributes:(NSDictionary *)dic
{
    _ContentPriase.text=[NSString stringWithFormat:@"%@",dic[@"content"]];
    if([dic[@""]isEqualToString:@"http://113.105.159.115:6026"])
    {
        _UserImageView.image=[UIImage imageNamed:@"1-1.jpg"];
    }
//    [_UserImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"1-1.jpg"]]];
    _UserImageView.image=[UIImage imageNamed:@"1-1.jpg"];
    [_UserImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"1-1.jpg"]];
   // _totalpraise.text=[NSString stringWithFormat:@"%@",dic[@"content"]];
}




- (IBAction)CheckMorePriaseBtn:(id)sender {

  //  [self]

}

- (IBAction)MoreDetaimPic:(id)sender {
}
@end
