//
//  PriaseController.m
//  QinRen
//
//  Created by Easaa on 15/4/3.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "PriaseController.h"
#import "PriaseTableViewCell1.h"
#import "PayView.h"
#import "DetailTableViewCell.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"

#import "GoodsCell.h"

#import "TESTUser.h"
#import "PraseCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "PriaseModel.h"
#import "PayView.h"


@interface PriaseController ()<PayViewviewdelegate>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)NSMutableArray *CommentdataArr;

@property(nonatomic,retain)PayView* payview;
@end

@implementation PriaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc]init];
    _CommentdataArr=[[NSMutableArray alloc]init];

    [self.tableView registerNib:[UINib nibWithNibName:@"PriaseTableViewCell1" bundle:nil] forCellReuseIdentifier:@"cell"];

  self.tableView.tableFooterView= [[UIView alloc] init];
    [self.tableView addHeaderWithTarget:self action:@selector(requestForComment)];
    [self.tableView headerBeginRefreshing];

    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];

    
    
}

#pragma make-请求数据
#pragma make-请求数据
-(void)requestForComment
{
    
    
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"userid":@"20150325164912",@"goodsid":@"4",};
    // set.fitness.subscribedelete
    [manager GetWithParameters:parameters method:@"get.goods.comment" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        // NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD showErrorWithStatus:@"失败"];
                [self.tableView reloadData];
            }else
            {
                 NSMutableArray *entities = @[].mutableCopy;
                NSMutableArray *datas=[[NSMutableArray alloc]init];
                // [SVProgressHUD showSuccessWithStatus:@"成功"];
                [_CommentdataArr removeAllObjects];
                [_CommentdataArr addObjectsFromArray:[dictionary objectForKey:@"data"]];
//               
//                [datas addObjectsFromArray:[dictionary objectForKey:@"data"]];
//               
//                [datas enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//                    
//                    [entities addObject:[[PriaseModel alloc] initWithDictionary:obj]];
//                }];
//                _CommentdataArr = entities;
                
                [self.tableView headerEndRefreshing];
                [self.tableView reloadData];
                
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return _CommentdataArr.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _CommentdataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PriaseTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(!cell)
    {
        cell=[[PriaseTableViewCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    [cell updatePriaseTableViewCell1UiWithAttributes:_CommentdataArr[indexPath.row]];
  
   cell.entity=_CommentdataArr[indexPath.row];

    cell.userNameLab.text=@"美女";

    cell.userHeadImage.image=[UIImage imageNamed:@"1.jpg"];

  
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"PayView" owner:nil options:nil]; //&1
    self.payview = [views lastObject];
    self.payview.delegate=self;
    self.payview.frame = CGRectMake(0, Screen.bounds.size.height, Screen.bounds.size.width, Screen.bounds.size.height/15);
    [[UIApplication sharedApplication].keyWindow addSubview:self.payview];
    [UIView animateWithDuration:0.2 animations:^{
        self.payview.frame = CGRectMake(0, Screen.bounds.size.height-Screen.bounds.size.height/15, Screen.bounds.size.width, Screen.bounds.size.height/15);
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [UIView animateWithDuration:0.2 animations:^{
        self.payview.frame = CGRectMake(0, Screen.bounds.size.height, Screen.bounds.size.width, Screen.bounds.size.height/15);
    } completion:^(BOOL finished) {
        [self.payview removeFromSuperview];
    }];
}
-(void)TakeintoAnotherUI
{
    
    [self performSegueWithIdentifier:@"gotopraiseshopping" sender:self];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(PriaseTableViewCell1 *cell) {
//        
//      cell.entity=_CommentdataArr[indexPath.row];
//        
//    }];
//}

@end
