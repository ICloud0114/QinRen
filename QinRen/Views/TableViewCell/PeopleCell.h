//
//  PeopleCell.h
//  QinRen
//
//  Created by Donny on 15/3/1.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconView1;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel1;
@property (strong, nonatomic) IBOutlet UIImageView *iconView2;
@property (strong, nonatomic) IBOutlet UILabel *nameLable2;
- (void)updateGoodsCellUiWithAttributes:(NSDictionary *)att;
@end
