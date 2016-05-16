//
//  CollectionCell.h
//  QinRen
//
//  Created by Easaa on 15/4/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UILabel *PriceLab;
@property (weak, nonatomic) IBOutlet UILabel *OldPriceLab;

@property (weak, nonatomic) IBOutlet UILabel *JifenLab;

- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att;
@end
