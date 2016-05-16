//
//  PriaseTableViewCell1.h
//  QinRen
//
//  Created by Easaa on 15/4/3.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriaseModel.h"

@interface PriaseTableViewCell1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TotalPriaseLab;
@property (weak, nonatomic) IBOutlet UILabel *userNameLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImage;
@property (nonatomic,strong)PriaseModel *entity;
-(void)updatePriaseTableViewCell1UiWithAttributes:(NSDictionary *)dic;

@end
