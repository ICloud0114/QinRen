//
//  MineViewController.h
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MineViewController : UITableViewController
//@property (weak, nonatomic) IBOutlet UIImageView *BackImageview;
//@property (weak, nonatomic) IBOutlet UILabel *MineName;
//@property (weak, nonatomic) IBOutlet UIImageView *MineImageview;
//@property (weak, nonatomic) IBOutlet UILabel *MinePhone;
//@property (weak, nonatomic) IBOutlet UIButton *AllOrder;
//@property (weak, nonatomic) IBOutlet UIView *MineView;
//- (IBAction)WillPay:(id)sender;
//- (IBAction)WillDisliver:(id)sender;
//- (IBAction)WillPraise:(id)sender;
//- (IBAction)WillRecive:(id)sender;
//
//- (IBAction)MyDevice:(id)sender;
//- (IBAction)InteprePlan:(id)sender;
//- (IBAction)HealthGard:(id)sender;
//- (IBAction)MenberCard:(id)sender;
//- (IBAction)HowToBeMenber:(id)sender;
- (IBAction)MyCollectBtn:(id)sender;
- (IBAction)Myjifen:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *Headimage;
@property (weak, nonatomic) IBOutlet UILabel *NameLab;
@property (weak, nonatomic) IBOutlet UILabel *PhoneLab;

- (IBAction)AllOrderBtn:(id)sender;
- (IBAction)Daifahuo:(id)sender;
- (IBAction)DaishoukuanBtn:(id)sender;
- (IBAction)DaipingjiaBtn:(id)sender;
- (IBAction)Daishouhuo:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *Myshebei;
@property (weak, nonatomic) IBOutlet UIImageView *ganyujihua;
@property (weak, nonatomic) IBOutlet UIImageView *jiankangtieshi;
@property (weak, nonatomic) IBOutlet UIImageView *huiyuanka;
- (IBAction)HowtobeMenberId:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *HeadImage;

@end
