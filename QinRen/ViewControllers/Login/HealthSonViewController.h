//
//  HealthSonViewController.h
//  QinRen
//
//  Created by Easaa on 15/4/7.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HealthSonViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UILabel *PublicTime;
@property (weak, nonatomic) IBOutlet UILabel *TilleLab;
@property (weak, nonatomic) IBOutlet UILabel *DescribLab;
@property (strong, nonatomic) IBOutlet UIScrollView *MyscrollView;
@property (nonatomic, strong) NSString *Id;
@end
