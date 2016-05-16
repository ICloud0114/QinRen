//
//  DailyMissionViewController.m
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "DailyMissionViewController.h"
#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "MissonDetailViewController.h"
#import "MJRefresh.h"
#import "MisionModel.h"

/*
 {"verification":true,"total":1,"data":[{"bodys":"锻炼时间","remindid":2,"userid":1,"remindTime":"2015/3/9 11:29:53","addTime":"2015/3/9 11:29:22","userName":"15818738100","imgs":"","title":"2356","state":0}],"error":null}
 */
@interface DailyMissionViewController ()
{
    NSInteger pageIndex;
}
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation DailyMissionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
;
    
    pageIndex = 1;
    self.dataArray = [NSMutableArray array];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    [self.tableView addHeaderWithTarget:self action:@selector(headRefresh)];
    
    [self.tableView headerBeginRefreshing];
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
    
      NSDictionary *parameters = @{@"name":user.uid,@"sn":@"",@"pagesize":@"",@"pageindex":@""};
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
                [self.tableView reloadData];
            }
            else
            {
                //
                [self.dataArray removeAllObjects];
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                    [self.tableView addFooterWithTarget:self action:@selector(footRefresh)];
                }
                [self.dataArray addObjectsFromArray:[dictionary objectForKey:@"data"]];
                
                [self.tableView reloadData];
            }
            
            [self.tableView headerEndRefreshing];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.tableView headerEndRefreshing];

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.tableView headerEndRefreshing];

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
                [self.tableView reloadData];
            }else
            {
                //
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                }else
                {
                    [self.tableView removeFooter];
                }
        
            
                [self.dataArray addObjectsFromArray:[dictionary objectForKey:@"data"]];
        
                _titleLab=dictionary[@"title"];
                
                [self.tableView reloadData];
            }
            
            [self.tableView footerEndRefreshing];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.tableView footerEndRefreshing];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.tableView footerEndRefreshing];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"DailyDetail" sender:self];
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"DailyDetail"]) {
        MissonDetailViewController *controller = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *dictionary = [self.dataArray objectAtIndex:indexPath.section];
        controller.Id = [dictionary objectForKey:@"remindid"];
    
    }
}

@end
