//
//  AddDetectCell.h
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//



#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AddDetectCellStyle) {
    AddDetectCellStyleNormal          = 0,
    AddDetectCellStyleTwoField    = 1,

};

@interface AddDetectCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *unitLabel;
@property (strong, nonatomic) IBOutlet UITextField *inputField;
@property (strong, nonatomic) IBOutlet UITextField *inputField2;
@property (nonatomic) AddDetectCellStyle style;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineLeftConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *fieldWidth;
@end
