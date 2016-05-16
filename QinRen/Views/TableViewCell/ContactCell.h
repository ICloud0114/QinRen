//
//  ContactCell.h
//  QinRen
//
//  Created by Easaa on 15/4/19.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *HeadView;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
- (IBAction)ChattingBtn:(id)sender;
- (IBAction)PhoneBtn:(id)sender;

@end
