
//  MallTableViewController.m
//  QinRen
//
//  Created by Easaa on 15/4/2.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MallTableViewController.h"
#import "PayView.h"
#import "DetailTableViewCell.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"

#import "GoodsCell.h"

#import "TESTUser.h"
#import "PraseCell.h"
#import "MoreDetailController.h"
#import "UIImageView+WebCache.h"
#import "ShoppingCarViewController.h"
#import "BBBadgeBarButtonItem.h"
#import "JSBadgeView.h"



@interface MallTableViewController ()<PayViewviewdelegate,UIAlertViewDelegate>
{
  
    
    UILabel *qualityLabel;
}
@property(nonatomic,retain)PayView* payview;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (strong, nonatomic) IBOutlet UITableView *mytableview;
@property (nonatomic,strong)UIScrollView  *myscrollview;
@property (strong, nonatomic) IBOutlet UILabel *QualityLab;
- (IBAction)tiaozhuanGouwu:(id)sender;
- (IBAction)zhuanfaBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *tiaozhuangouwu;
@property (weak, nonatomic) IBOutlet UIView *gouwuView;


@end

@implementation MallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    _dataArr=[[NSMutableArray alloc]init];
     [self.mytableview addHeaderWithTarget:self action:@selector(requestForData)];
    [self.mytableview headerBeginRefreshing];

    self.mytableview.tableFooterView = [[UIView alloc] init];
    
    [self.mytableview registerNib:[UINib nibWithNibName:@"DetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
   // [self requestForData];
    
    [self.mytableview addFooterWithTarget:self action:@selector(footerRefresh)];
    
//    _badgeView.layer.cornerRadius=10.0f;
//  //  _badgeView.layer.shadowColor = [UIColor blackColor].CGColor;
//    _badgeView.layer.shadowOffset = CGSizeMake(0.0f, 3.0f);
//    _badgeView.layer.shadowOpacity = 0.4;
//    _badgeView.layer.shadowRadius = 1.0;
//
//     JSBadgeView *badgeView = [[JSBadgeView alloc] initWithParentView:_badgeView alignment:JSBadgeViewAlignmentTopCenter];
//      badgeView.badgeText =@"1";
//    [_badgeView addSubview:badgeView];
    
    
    BBBadgeBarButtonItem *barButton = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:_tiaozhuangouwu];
    // Set a value for the badge
    barButton.badgeValue = @"10";
    
    barButton.badgeOriginX = 13;
    barButton.badgeOriginY = -9;
    
    // Add it as the leftBarButtonItem of the navigation bar
    _tiaozhuangouwu= barButton;
}
-(void)footerRefresh
{
    
    [UIView animateWithDuration:0.1f animations:^{
        MoreDetailController *more=[[MoreDetailController alloc]init];
        [self.navigationController pushViewController:more animated:YES];
        
        [self.mytableview footerEndRefreshing];
        
    }];
    
}
#pragma make-请求数据
-(void)requestForData
{
    
    
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user=[User sharedUser];
    NSDictionary *parameters = @{@"uid":user.uid,@"goodsid":_ID,};
    // set.fitness.subscribedelete
    [manager GetWithParameters:parameters method:@"get.goods.detail" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                [self.mytableview reloadData];
            }else
            {
                //
                // [SVProgressHUD showSuccessWithStatus:@"成功"];
                
                [self.dataArr addObjectsFromArray:[dictionary objectForKey:@"data"]];
                [self.tableView reloadData];
                [self.mytableview headerEndRefreshing];
                
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

-(void)requestForshoppingList
{
    
   
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user=[User sharedUser];
    NSDictionary *parameters = @{@"userid":user.uid,@"pid":_ID,@"quetity":qualityLabel.text};
    // set.fitness.subscribedelete
    [manager GetWithParameters:parameters method:@"set.user.cartlist" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                [self.mytableview reloadData];
            }else
            {
                //
                 [SVProgressHUD showSuccessWithStatus:@"加入购物车成功"];
//                
//                [self.dataArr addObjectsFromArray:[dictionary objectForKey:@"data"]];
//                [self.tableView reloadData];
//                [self.mytableview headerEndRefreshing];
                
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

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return _dataArr.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_dataArr.count ==0)
    {
        return 0;
    }
    return 2;
    
}

-(void)TakeintoAnotherUI
{

    [self performSegueWithIdentifier:@"gotoshop" sender:self];
}
-(void)TakeintoAnotherUI1
{
    [self requestForshoppingList];
    
    BBBadgeBarButtonItem *barButton = (BBBadgeBarButtonItem *)self.navigationItem.leftBarButtonItem;
    barButton.badgeValue = [NSString stringWithFormat:@"%d", [barButton.badgeValue intValue] + 1];
    
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"加入购物车成功" message:@"确定" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        
    }
}
//返回tabeview头的高度
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section == 0) {
//        return 1;
//    }else{
//        return Screen.bounds.size.height/80;
//    }
//
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  QRModelGetClient *get = _dataArr[indexPath.row];
    // TESTUser *test = get.data;
    if(indexPath.row==0)
    {
        
        DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTableViewCell"forIndexPath:indexPath];
    
        [cell updateGoodsCellUiWithAttributes:self.dataArr[indexPath.row]];
        qualityLabel = cell.quality;
        
        return cell;
    }
    else
    {
        PraseCell *cell=[tableView dequeueReusableCellWithIdentifier:@"PraseCell" forIndexPath:indexPath];
        
        
           [cell.UserImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"1-1.jpg"]];
        return cell;
    }
    
    // [cell updateGoodsCellUiWithAttributes:_dataArr[indexPath.row]];
    
    return nil;
}






- (IBAction)tiaozhuanGouwu:(id)sender {
    

    


}

- (void)barButtonItemPressed:(UIButton *)sender
{
    NSLog(@"跳转购物车");
    

    BBBadgeBarButtonItem *barButton = (BBBadgeBarButtonItem *)self.navigationItem.leftBarButtonItem;
    barButton.badgeValue = @"0";
    
    // If you don't want to remove the badge when it's zero just set
    barButton.shouldHideBadgeAtZero = NO;
    // Next time zero should still be displayed
    
    // You can customize the badge further (color, font, background), check BBBadgeBarButtonItem.h ;)
}

- (IBAction)zhuanfaBtn:(id)sender {
}
@end

