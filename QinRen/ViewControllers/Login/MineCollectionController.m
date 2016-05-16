//
//  MineCollectionController.m
//  QinRen
//
//  Created by Easaa on 15/4/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//
#define DAPagesItemsOffset [UIScreen mainScreen].bounds.size.width/6
#define Screen  [UIScreen mainScreen]

#import "MineCollectionController.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"

#import "GoodsCell.h"

#import "CollectionCell.h"
#import "CollectNEWCell.h"


@interface MineCollectionController ()<UITableViewDataSource,UITableViewDelegate>
{
      int  _selectIndex;
}
@property (nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MineCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray=[[NSMutableArray alloc]init];
    [self.CollectTableview addHeaderWithTarget:self action:@selector(requestForData)];
    self.CollectTableview.tableFooterView = [[UIView alloc]init];
    self.CollectNewTableView.tableFooterView = [[UIView alloc]init];
}
-(void)requestForData
{
    
    // pageIndex = 1;
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
    NSDictionary *parameters = nil;
    if (_selectIndex == 0) {
        parameters = @{@"goodstype":@"0",@"pagesize":@"10"};
        
    }
    else if(_selectIndex == 1)
    {
        
        parameters = @{@"goodstype":@"1",@"pagesize":@"10"};
        
    }
    
    
    
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
         
                [self refersh];
            }
            else
            {
                //
                [self.dataArray removeAllObjects];
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    //  pageIndex ++;
                    [self.CollectTableview addFooterWithTarget:self action:@selector(footRefresh)];
                }
                [self.dataArray addObjectsFromArray:[dictionary objectForKey:@"data"]];
                
                //                [self.allTableView reloadData];
                [self refersh];
            }
            
            //            [self.allTableView headerEndRefreshing];
            [self endfersh];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            //            [self.allTableView headerEndRefreshing];
            [self endfersh];
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        //        [self.allTableView headerEndRefreshing];
        [self endfersh];
        
    }];

}
- (void)refersh
{
    if (_selectIndex == 0) {
        
        [self.CollectTableview reloadData];
    }
    else if(_selectIndex == 1)
    {
        [self.CollectNewTableView reloadData];
        
    }

    
}
- (void)endfersh
{
    if (_selectIndex == 0) {
    
        [self.CollectTableview headerEndRefreshing];
    }
    else if(_selectIndex == 1)
    {
        [self.CollectNewTableView headerEndRefreshing];
        
    }
   
    
}

- (IBAction)CollectAction:(UIButton *)sender {
    
    

    _selectIndex=sender.tag;
//    [self.CollectTableview reloadData];
    self.CollectTableview.hidden=NO;
    self.CollectNewTableView.hidden = YES;
[self.CollectTableview addHeaderWithTarget:self action:@selector(requestForData)];
  [self.CollectTableview headerBeginRefreshing];
}

- (IBAction)CollectNewAction:(UIButton *)sender {
    
    
    _selectIndex=sender.tag;

    [self.CollectTableview reloadData];
    self.CollectTableview.hidden = YES;
    self.CollectNewTableView.hidden=NO;
    [self.CollectNewTableView addHeaderWithTarget:self action:@selector(requestForData)];
   [self.CollectNewTableView headerBeginRefreshing];
    

}

#pragma mark - Table DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.CollectTableview)
    {
        CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell"];

      //  [cell updateGoodsCellUiWithAttributes:self.dataArray[indexPath.row]];
   
        return cell;
    }
    else if(tableView==self.CollectNewTableView)
    {
        CollectNEWCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectNEWCell"];
        
     //   [cell updateGoodsCellUiWithAttributes:self.dataArray[indexPath.row]];
        
        return cell;
    }
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier:@"gototails" sender:self];
//    // MallTableViewController *vc=[[MallTableViewController alloc]init];
//    // [self.navigationController pushViewController:vc animated:YES];
//}

@end
