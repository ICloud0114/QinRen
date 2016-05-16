//
//  InteDetailController.m
//  QinRen
//
//  Created by Easaa on 15/4/10.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "InteDetailController.h"

@interface InteDetailController ()

@end

@implementation InteDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self creatUI];
}

-(void)creatUI
{
    UILabel *timeLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 200, 50)];
    timeLab.text=@"2015-4-10 00:00:00";
    timeLab.font=[UIFont fontWithName:@"Arial" size:13];
    [self.view addSubview:timeLab];
    
    
    UILabel *StutasLab=[[UILabel alloc]initWithFrame:CGRectMake(230, 10, 200, 50)];
    StutasLab.text=@"未执行";
    StutasLab.font=[UIFont fontWithName:@"Arial" size:13];
    [self.view addSubview:StutasLab];
    
    
    UILabel *DetailLab=[[UILabel alloc]initWithFrame:CGRectMake(10, 60, 200, 50)];
    DetailLab.text=@"内容";
    DetailLab.font=[UIFont fontWithName:@"Arial" size:13];
    [self.view addSubview:DetailLab];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
