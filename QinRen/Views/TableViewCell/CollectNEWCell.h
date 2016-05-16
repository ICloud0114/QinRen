//
//  CollectNEWCell.h
//  QinRen
//
//  Created by Easaa on 15/4/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectNEWCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *TitileLab;
@property (weak, nonatomic) IBOutlet UILabel *TimeLab;
@property (weak, nonatomic) IBOutlet UILabel *DecLab;
- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att;
@end
