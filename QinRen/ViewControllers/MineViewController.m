//
//  MineViewController.m
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#define X [UIScreen mainScreen].bounds.origin.x
#define Y [UIScreen mainScreen].bounds.origin.y
#define WIDTH [UIScreen mainScreen].bounds
#define HEIGHT [UIScreen mainScreen].bounds.origin.y

#import "MineViewController.h"
#import "MyDeviceController.h"
#import "DailyMissionViewController.h"
#import "InteprePlanController.h"

#import "EAOrderTableViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
/*
 @property (weak, nonatomic) IBOutlet UIImageView *Myshebei;
 @property (weak, nonatomic) IBOutlet UIImageView *ganyujihua;
 @property (weak, nonatomic) IBOutlet UIImageView *jiankangtieshi;
 @property (weak, nonatomic) IBOutlet UIImageView *huiyuanka;
 @property (weak, nonatomic) IBOutlet UIImageView *Headimage;
 @property (weak, nonatomic) IBOutlet UILabel *NameLab;
 @property (weak, nonatomic) IBOutlet UILabel *PhoneLab;
 */
    
    _Headimage.image=[UIImage imageNamed:@"tuoxiang-huiyuan"];
    _HeadImage.image=[UIImage imageNamed:@"wodebeijingtu.jpg"];
    _Myshebei.image=[UIImage imageNamed:@"wodeshebei_38"];
    _ganyujihua.image=[UIImage imageNamed:@"ganyujihua_30"];
    _jiankangtieshi.image=[UIImage imageNamed:@"jiankangtieshi_33"];
    _huiyuanka.image=[UIImage imageNamed:@"huiyuanka_35"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)WillPay:(id)sender {
}

- (IBAction)WillDisliver:(id)sender {
}

- (IBAction)WillPraise:(id)sender {
}

- (IBAction)WillRecive:(id)sender {
}

- (IBAction)MyDevice:(id)sender {
//    
//    MyDeviceController *myVC=[[MyDeviceController alloc]init];
//    [self.navigationController pushViewController:myVC animated:YES];
}

- (IBAction)InteprePlan:(id)sender {
    InteprePlanController *intevc=[[InteprePlanController alloc]init];
    [self.navigationController pushViewController:intevc animated:YES];
    
    
}

- (IBAction)HealthGard:(id)sender {

}

- (IBAction)MenberCard:(id)sender {
}

- (IBAction)HowToBeMenber:(id)sender {
}
- (IBAction)MyCollectBtn:(id)sender {
}

- (IBAction)Myjifen:(id)sender {
}
- (IBAction)AllOrderBtn:(id)sender {
}

- (IBAction)Daifahuo:(id)sender {
}

- (IBAction)DaishoukuanBtn:(id)sender {
}

- (IBAction)DaipingjiaBtn:(id)sender {
}

- (IBAction)Daishouhuo:(id)sender {
}
- (IBAction)HowtobeMenberId:(id)sender {
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    UIButton *button = sender;
    
    UIViewController *destination = segue.destinationViewController;
    if ([destination respondsToSelector:@selector(setType:)])
    {
        [destination setValue:[NSString stringWithFormat:@"%ld",(long)button.tag] forKey:@"Type"];
    }
    
}

@end
