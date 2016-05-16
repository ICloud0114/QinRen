//
//  HealthSonViewController.m
//  QinRen
//
//  Created by Easaa on 15/4/7.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "HealthSonViewController.h"

#import "UIImageView+WebCache.h"

#import "MJRefresh.h"
@interface HealthSonViewController ()
{
    //文字高度
    CGFloat TitleHeight;
    CGFloat TitleWidth;
    CGFloat BodyHeight;
}

@end

@implementation HealthSonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor=[UIColor lightGrayColor];
    
  [self.MyscrollView addHeaderWithTarget:self action:@selector(requestForDetail)];
   // self.Id=@"1";
 [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
 [self requestForDetail];
    
    
}


- (void)requestForDetail
{
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"gremindid":self.Id};
    
    [manager GetWithParameters:parameters method:@"get.fitness.health.reminddelete" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        //替换
        
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"new+Date(" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@")" withString:@""];
        
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD showErrorWithStatus:@"加载失败"];
            }else
            {
        
                [SVProgressHUD dismiss];
                
                //
                [self fillContent:[[dictionary objectForKey:@"data"]firstObject]];
            }
            
            [self.MyscrollView headerEndRefreshing];
        }else
        {
            
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.MyscrollView headerEndRefreshing];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.MyscrollView headerEndRefreshing];
        
    }];
}


- (void)fillContent:(NSDictionary *)dictionary
{
    
    /*
     @property (weak, nonatomic) IBOutlet UIImageView *ImageView;
     
     @property (weak, nonatomic) IBOutlet UILabel *PublicTime;
     @property (weak, nonatomic) IBOutlet UILabel *TilleLab;
     @property (weak, nonatomic) IBOutlet UILabel *DescribLab;
     */
    
    //FIXME:修正时间显示问题
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"imgs"]]];
    //    self.categoryLabel.text = [NSString stringWithFormat:@"今日任务 · %@", [Until convertToTimeWithSecond:[dictionary objectForKey:@"remindTime"]]];
    
    self.TilleLab.text = [dictionary objectForKey:@"title"];
    
    TitleHeight=[ZZTool heightWithString:self.TilleLab.text font:[UIFont fontWithName:@"Arial" size:13] constrainedToWidth:230];
    TitleWidth=[ZZTool widthWithString:self.TilleLab.text font:[UIFont fontWithName:@"Arial" size:13]];
    
    // self.contentView.text = [dictionary objectForKey:@"bodys"];

    self.DescribLab.text=[dictionary objectForKey:@"bodys"];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}




@end
