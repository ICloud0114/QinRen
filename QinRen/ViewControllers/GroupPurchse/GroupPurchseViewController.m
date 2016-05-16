//
//  GroupPurchseViewController.m
//  QinRen
//
//  Created by Easaa on 15/4/1.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "GroupPurchseViewController.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"
#import "GroupPurchaseCell.h"

#import "GoodCell.h"
#import "UIImageView+WebCache.h"
#import "MallTableViewController.h"

@interface GroupPurchseViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *SeachTextfield;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation GroupPurchseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
    _dataArray=[[NSMutableArray alloc]init];
    [self.myTableView addHeaderWithTarget:self action:@selector(requestForData)];
    [self.myTableView headerBeginRefreshing];
    self.myTableView.tableFooterView=[[UIView alloc]init];
    
}
#pragma mark-请求数据
-(void)requestForData
{
    // pageIndex = 1;
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //  User *user = [User sharedUser];
    
    NSDictionary *parameters = @{@"goodstype":@"3",@"pagesize":@"10"};
    
    [manager GetWithParameters:parameters method:@"get.goods.list" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                [self.myTableView reloadData];
            }
            else
            {
                //
                [self.dataArray removeAllObjects];
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    //  pageIndex ++;
                    [self.myTableView addFooterWithTarget:self action:@selector(footRefresh)];
                }
                [self.dataArray addObjectsFromArray:[dictionary objectForKey:@"data"]];
                
                [self.myTableView reloadData];
                [self.myTableView headerEndRefreshing];
            }
            
            [self.myTableView footerEndRefreshing];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            //            [self.allTableView headerEndRefreshing];
            [self.myTableView footerEndRefreshing];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        //        [self.allTableView headerEndRefreshing];
        [self.myTableView footerEndRefreshing];
        
    }];
}
-(void)footRefresh
{
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
    
    NSDictionary *parameters = @{@"goodstype":@"3",@"pagesize":@"10"};
    
    [manager GetWithParameters:parameters method:@"get.goods.list" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                [self.myTableView reloadData];
            }
            else
            {
                //
                [self.dataArray removeAllObjects];
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    //  pageIndex ++;
                    [self.myTableView reloadData];
                }
                [self.dataArray addObjectsFromArray:[dictionary objectForKey:@"data"]];
                
                [self.myTableView reloadData];
            }
            
            [self.myTableView footerEndRefreshing];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            //            [self.allTableView headerEndRefreshing];
            [self.myTableView footerEndRefreshing];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        //        [self.allTableView headerEndRefreshing];
        [self.myTableView footerEndRefreshing];
        
    }];
}


#pragma mark - Table DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GroupPurchaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GroupPurchaseCell"];
    
    NSDictionary *dic =self.dataArray[indexPath.row];
    
//    cell.nameLabel.text=dic[@"name"];
//    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"pics"]]];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:dic[@"pics"]]];
    cell.nameLabel.text=[NSString stringWithFormat:@"%@",dic[@"name"]];
    cell.newpriceLabel.text=[NSString stringWithFormat:@"￥%@",dic[@"salePirce"]];
    cell.oldPriceLabel.text=[NSString stringWithFormat:@"￥%@",dic[@"needmoney"]];
    cell.purchasePeople.text=[NSString stringWithFormat:@"%@人已购买",dic[@"buypeople"]];
    cell.describLabel.text=@"欢迎光临";
    
//    [cell updateDetailTableViewCellUiWithAttributes:_dataArray[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[self.dataArray objectAtIndex:indexPath.row];
    NSString *ID=dic[@"id"];
    
    [self performSegueWithIdentifier:@"gotomall" sender:ID];
    
    MallTableViewController *mallVC=[[MallTableViewController alloc]init];
    
    
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    if ([segue.identifier isEqualToString:@"gotomall"])
    {
        MallTableViewController *controller = segue.destinationViewController;
        
        controller.ID = sender;
        
        
    }
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
