//
//  DetailTableViewCell.hDeatilTableViewCell
//  QinRen
//
//  Created by Easaa on 15/4/2.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *DescribLabel;
@property (weak, nonatomic) IBOutlet UILabel *MarketLabel;
@property (weak, nonatomic) IBOutlet UILabel *MemberLabel;
@property (weak, nonatomic) IBOutlet UILabel *JifenLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageview;
@property (weak, nonatomic) IBOutlet UILabel *quality;
@property (weak, nonatomic) IBOutlet UIButton *minue;
@property (weak, nonatomic) IBOutlet UIButton *add;

- (IBAction)minue:(id)sender;

- (IBAction)add:(id)sender;

- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att;
@end
