//
//  PicController.m
//  QinRen
//
//  Created by Easaa on 15/4/8.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "PicController.h"
#import "LineChartView.h"
#import "CBChartView.h"

#import "FatCell.h"
#import "MJRefresh.h"
#import "AddDetectViewController.h"
#import "User.h"

@interface PicController ()
{

    NSMutableArray *_totalSum;
    NSMutableArray *_totalTime;
    UILabel *_label;
}
@property (weak, nonatomic) CBChartView *chartView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation PicController

- (void)viewDidLoad {
    [super viewDidLoad];
    _totalTime=[[NSMutableArray alloc]init];
    _totalSum=[[NSMutableArray alloc]init];
    _dataArr=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
   
  
    
    DLog(@"名字是===%@",_alias);
     [self requestForFat];
   
}


//-(void)creatQuxian
//{
//
//    for(NSDictionary *dic in _dataArr)
//    {
//        if([dic[@"alias"] isEqualToString:_alias])
//        {
//            if([_alias isEqualToString:@"jcdxz"])
//               {
//                   
//                      self.title=@"基础代谢";
//                       [_totalSum addObject:dic[@"vlues"]];
//                   CBChartView *chartView = [CBChartView charView];
//                   [self.view addSubview:chartView];
//
//                   chartView.xValues = _totalSum;
//                 // chartView.yValues = @[@"11", @"333", @"2000", @"50", @"55", @"60", @"50", @"50", @"34", @"67"];
//                   
//                                    // chartView.yValues = _totalSum;
//                   chartView.chartColor = [UIColor greenColor];
//                   self.chartView = chartView;
//                   
//               }


-(void)CreatLabel:(UILabel *)label labeltext:(NSString *)text
{
    _label=[[UILabel alloc]init];
    _label=label;
    _label.text=text;
    [self.view addSubview:_label];
}

- (void)requestForFat
{

    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    User *user = [User sharedUser];
    
    NSDictionary *parameters = @{@"MemberId":user.uid,@"alias":_alias};
    
    [manager GetWithParameters:parameters method:@"get.testingresult.details" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]])
        {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }
        else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
//                [self.tableView reloadData];
            }else
            {

                NSMutableArray *_arr1 = [NSMutableArray array];
                NSMutableArray *_arr2 = [NSMutableArray array];
             
                
                for (int j = (int)[dictionary[@"data"] count] - 1; j >= 0; j--)
                {
                    [_arr1 addObject:[[dictionary[@"data"][j][@"addTime"] substringToIndex:10] substringFromIndex:6]];
                    [_arr2 addObject:dictionary[@"data"][j][@"vlues"]];
                }
                
                
                _dataArr = [NSMutableArray arrayWithObjects:_arr1,_arr2, nil];
                DLog(@"_dataArr==%@",_dataArr);
                [self CreatTime];

               
               
            }
            
           
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
          
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        
        
    }];
}
-(void)CreatTime
{   CBChartView *chartView = [CBChartView charView];
    if(_dataArr.count<5)
    {

          chartView.yValueCount = [_dataArr[1] count];
     
    }
    else
    {
       
          chartView.yValueCount = 5;
    }
    // 使用方法
  
  
    [self.view addSubview:chartView];
    chartView.xValues = _dataArr[0];

    chartView.yValues = _dataArr[1];
    
    chartView.chartColor = [UIColor greenColor];
    self.chartView = chartView;
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
