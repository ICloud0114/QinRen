//
//  GroupPurchaseCell.h
//  QinRen
//
//  Created by Easaa on 15/4/1.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupPurchaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *describLabel;
@property (weak, nonatomic) IBOutlet UILabel *newpriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *purchasePeople;

- (void)updateDetailTableViewCellUiWithAttributes:(NSDictionary *)dic;
@end
