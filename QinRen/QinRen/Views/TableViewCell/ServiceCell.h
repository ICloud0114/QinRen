//
//  ServiceCell.h
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MGSwipeTableCell.h"

@interface ServiceCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end
