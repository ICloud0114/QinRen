//
//  ShoppingCell.h
//  QinRen
//
//  Created by Easaa on 15/4/7.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ProductLab;
@property (weak, nonatomic) IBOutlet UILabel *PriceLab;
@property (weak, nonatomic) IBOutlet UILabel *CountLab;
@property (weak, nonatomic) IBOutlet UIImageView *ProductImageView;
- (IBAction)SelectedBtn:(id)sender;
- (IBAction)Add:(id)sender;
- (IBAction)mInue:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *Count2Lab;
@property (weak, nonatomic) IBOutlet UILabel *SumPriceLab;

@property (weak, nonatomic) IBOutlet UILabel *TotalSumProductLab;


@end
