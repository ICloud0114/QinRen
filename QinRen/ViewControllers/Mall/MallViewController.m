//
//  MallViewController.m
//  QinRen
//
//  Created by Donny on 15/2/28.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MallViewController.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"

#import "GoodsCell.h"

#import "MallTableViewController.h"


@interface MallViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger  _selectIndex;
}

@property (strong, nonatomic) IBOutlet UIButton *allButton;
@property (strong, nonatomic) IBOutlet UIButton *promotionsButton;
@property (strong, nonatomic) IBOutlet UIButton *matchButton;
@property (strong, nonatomic) IBOutlet UITableView *allTableView;
@property (strong, nonatomic) IBOutlet UITableView *promotionsTableView;
@property (strong, nonatomic) IBOutlet UITableView *MatchTableView;
@property (strong, nonatomic) IBOutlet UIView *moveView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *moveViewLeft;
@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MallViewController

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
    _dataArray=[[NSMutableArray alloc]init];
    [self.allTableView addHeaderWithTarget:self action:@selector(requestForData)];
    [self.allTableView headerBeginRefreshing];
    

}


#pragma mark - 
#pragma mark - 按钮事件
- (IBAction)allButtonAction:(UIButton *)sender
{
    _selectIndex=sender.tag;
    self.moveViewLeft.constant = -16;
    self.allTableView.hidden = NO;
    self.promotionsTableView.hidden = YES;
    self.MatchTableView.hidden = YES;
    [self.allTableView addHeaderWithTarget:self action:@selector(requestForData)];
     [self.allTableView headerBeginRefreshing];
}

- (IBAction)promotionButtonAction:(UIButton *)sender
{
    _selectIndex=sender.tag;
    self.moveViewLeft.constant = -16 + self.promotionsButton.width;
    self.allTableView.hidden = YES;
    self.promotionsTableView.hidden = NO;
    self.MatchTableView.hidden = YES;
    [self.view bringSubviewToFront:self.promotionsTableView];
    [self.promotionsTableView addHeaderWithTarget:self action:@selector(requestForData)];
    [self.promotionsTableView headerBeginRefreshing];
}

- (IBAction)matchButton:(UIButton *)sender
{
    _selectIndex=sender.tag;
    self.allTableView.hidden = YES;
    self.promotionsTableView.hidden = YES;
     self.MatchTableView.hidden = NO;
    self.moveViewLeft.constant = -16 + self.matchButton.width * 2;
    [self.MatchTableView addHeaderWithTarget:self action:@selector(requestForData)];
    [self.MatchTableView headerBeginRefreshing];

}
#pragma make-请求数据
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
    else if(_selectIndex == 2)
    {
         parameters = @{@"goodstype":@"2",@"pagesize":@"10"};
        
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
//                [self.allTableView reloadData];
                [self refersh];
            }
            else
            {
                //
                [self.dataArray removeAllObjects];
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                  //  pageIndex ++;
                    [self.allTableView addFooterWithTarget:self action:@selector(footRefresh)];
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

-(void)footRefresh
{
    
    
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
    else if(_selectIndex == 2)
    {
        parameters = @{@"goodstype":@"2",@"pagesize":@"10"};
        
    }
    

    
    [manager GetWithParameters:parameters method:@"get.goods.list" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                [self refersh];
            }else
            {
                //
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                  //  pageIndex ++;
                }else
                {
                   [self refersh];
                }
                
                
                [self.dataArray addObjectsFromArray:[dictionary objectForKey:@"data"]];
                
              //  _titleLab=dictionary[@"title"];
                
               [self refersh];
            }
            
            [self endfersh];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
             [self endfersh];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self endfersh];
        
    }];

}
- (void)refersh
{
    if (_selectIndex == 0) {
        
        [self.allTableView reloadData];
    }
    else if(_selectIndex == 1)
    {
       [self.promotionsTableView reloadData];
        
    }
    else if(_selectIndex == 2)
    {
        [self.MatchTableView reloadData];
    }

}
- (void)endfersh
{
    if (_selectIndex == 0) {
        
        [self.allTableView headerEndRefreshing];
    }
    else if(_selectIndex == 1)
    {
        [self.promotionsTableView headerEndRefreshing];
        
    }
    else if(_selectIndex == 2)
    {
        [self.MatchTableView headerEndRefreshing];
    }

}
#pragma mark - 
#pragma mark - Table DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCell"];
    
    
    
    [cell updateGoodsCellUiWithAttributes:self.dataArray[indexPath.row]];
    
    
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
    
      [self performSegueWithIdentifier:@"gototails" sender:ID];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    
    if ([segue.identifier isEqualToString:@"gototails"])
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
