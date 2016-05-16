//
//  MissonDetailViewController.m
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MissonDetailViewController.h"

#import "UIImageView+WebCache.h"

#import "MJRefresh.h"


@interface MissonDetailViewController ()<UITextViewDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITextView *contentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *contentConstraint;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MissonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.contentView.scrollEnabled = NO;
    
    self.Id=@"1";
    [self.scrollView addHeaderWithTarget:self action:@selector(requestForDetail)];
    
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
            
            [self.scrollView headerEndRefreshing];
        }else
        {
            
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.scrollView headerEndRefreshing];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.scrollView headerEndRefreshing];

    }];
}


- (void)fillContent:(NSDictionary *)dictionary
{
    
    //FIXME:修正时间un显示问题
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"imgs"]]];
//    self.categoryLabel.text = [NSString stringWithFormat:@"今日任务 · %@", [Until convertToTimeWithSecond:[dictionary objectForKey:@"remindTime"]]];
    
     self.titleLabel.text = [dictionary objectForKey:@"bodys"];
    
     [self.titleLabel.text boundingRectWithSize:CGSizeMake(200, 3000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil];
  //  self.titleLabel.text
   
     self.categoryLabel.text = [dictionary objectForKey:@"title"];
    self.titleLabel.font=[UIFont systemFontOfSize:13];
    // self.contentView.text = [dictionary objectForKey:@"bodys"];
    CGSize maxSize = CGSizeMake(self.contentView.bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [self.contentView sizeThatFits:maxSize];
    self.contentConstraint.constant = newSize.height;
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
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
