//
//  PraseCell.h
//  QinRen
//
//  Created by Easaa on 15/4/3.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PraseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *totalpraise;
@property (weak, nonatomic) IBOutlet UIImageView *UserImageView;

@property (weak, nonatomic) IBOutlet UILabel *UserName;
@property (weak, nonatomic) IBOutlet UILabel *ContentPriase;
- (IBAction)CheckMorePriaseBtn:(id)sender;
- (IBAction)MoreDetaimPic:(id)sender;

-(void)updatePraseCellUiWithAttributes:(NSDictionary *)dic;

@end
