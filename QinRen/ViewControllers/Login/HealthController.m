//
//  HealthController.m
//  QinRen
//
//  Created by Easaa on 15/4/7.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "HealthController.h"
#import "NewsCell.h"

#import "UIImageView+WebCache.h"
#import "MissonDetailViewController.h"
#import "MJRefresh.h"
#import "MisionModel.h"

@interface HealthController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageIndex;
}
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HealthController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pageIndex = 1;
    self.dataArray = [NSMutableArray array];
    
    self.MyTableView.tableFooterView = [[UIView alloc]init];
    self.MyTableView.delegate=self;
    self.MyTableView.dataSource=self;
    
    [self.MyTableView addHeaderWithTarget:self action:@selector(headRefresh)];
    
    [self.MyTableView headerBeginRefreshing];

}

#pragma mark -
#pragma mark - 网络请求
- (void)headRefresh
{
    pageIndex = 1;
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
    
    //  NSDictionary *parameters = @{@"name":user.username,@"sn":@"",@"pagesize":@"10",@"pageindex":[NSString stringWithFormat:@"%ld",(long)pageIndex]};
    
    NSDictionary *parameters = @{@"name":@"",@"sn":@"",@"pagesize":@"",@"pageindex":@""};
    [manager GetWithParameters:parameters method:@"get.fitness.health.remind" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        NSLog(@"responseObject===%@",responseObject);
        
        
        
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        
        NSLog(@"dictonary2111 :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [self.MyTableView reloadData];
            }
            else
            {
                //
                [self.dataArray removeAllObjects];
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                    [self.MyTableView addFooterWithTarget:self action:@selector(footRefresh)];
                }
                [self.dataArray addObjectsFromArray:[dictionary objectForKey:@"data"]];
                
                [self.MyTableView reloadData];
            }
            
            [self.MyTableView headerEndRefreshing];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.MyTableView headerEndRefreshing];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.MyTableView headerEndRefreshing];
        
    }];
}


- (void)footRefresh
{
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
    
    // NSDictionary *parameters = @{@"name":user.username,@"sn":@"",@"pagesize":@"10",@"pageindex":[NSString stringWithFormat:@"%ld",(long)pageIndex]};
    
    NSDictionary *parameters = @{@"name":@"",@"sn":@"",@"pagesize":@"",@"pageindex":@""};
    
    [manager GetWithParameters:parameters method:@"get.fitness.health.remind" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        //  NSLog(@"responseObject==%@",responseObject);
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        //  NSLog(@"dictonary1111 :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [self.MyTableView reloadData];
            }else
            {
                //
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                }else
                {
                    [self.MyTableView removeFooter];
                }
                
                
                [self.dataArray addObjectsFromArray:[dictionary objectForKey:@"data"]];
                
                _titleLab=dictionary[@"title"];
                
                [self.MyTableView reloadData];
            }
            
            [self.MyTableView footerEndRefreshing];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.MyTableView footerEndRefreshing];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.MyTableView footerEndRefreshing];
        
    }];
}


#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray) {
        return self.dataArray.count;
    }
    
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    
    NSDictionary *dictionary = [self.dataArray objectAtIndex:indexPath.section];
    cell.titleLabel = [dictionary objectForKey:@"title"];
    
    
    NSLog(@"cell.titleLabel111==%@",cell.titleLabel);
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"imgs"]]];
    
    cell.dateLabel.text = [ZZTool convertToTimeWithSecond:[dictionary objectForKey:@"remindTime"]];
    cell.detailLabel.text = [dictionary objectForKey:@"bodys"];
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 270;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"DailyDetail" sender:self];
//    [self.MyTableView deselectRowAtIndexPath:indexPath animated:NO];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"HealthGrad"]) {
        MissonDetailViewController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.MyTableView indexPathForSelectedRow];
        NSDictionary *dictionary = [self.dataArray objectAtIndex:indexPath.section];
        controller.Id = [dictionary objectForKey:@"remindid"];
        
    }
}


@end
