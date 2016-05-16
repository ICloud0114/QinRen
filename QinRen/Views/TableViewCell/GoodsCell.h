//
//  GoodsCell.h
//  QinRen
//
//  Created by Donny on 15/2/28.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopPrice;
@property (strong, nonatomic) IBOutlet UILabel *memberPrice;

- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att;

@end
