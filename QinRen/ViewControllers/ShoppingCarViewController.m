//
//  ShoppingCarViewController.m
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "ShopingView.h"
#import "ShoppingCell.h"
#import "OrderViewController.h"
#import "PayView.h"
#import "DetailTableViewCell.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"

#import "GoodsCell.h"

#import "TESTUser.h"
#import "PraseCell.h"
#import "MoreDetailController.h"
#import "UIImageView+WebCache.h"

@interface ShoppingCarViewController ()<ShopingViewviewdelegate>
@property (nonatomic,strong)ShopingView *shopview;
- (IBAction)addBtn:(id)sender;
@property(nonatomic,strong)NSMutableArray *dataArr;
- (IBAction)minueBtn:(id)sender;
- (IBAction)selectedBtn:(id)sender;
@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor whiteColor];
     [self.MyTableView registerNib:[UINib nibWithNibName:@"ShoppingCell" bundle:nil] forCellReuseIdentifier:@"cell"];

    
    [self requestForshoppingList];
    [self.MyTableView headerBeginRefreshing];
    
//    
//        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ShopingView" owner:nil options:nil]; //&1
//        self.shopview = [views lastObject];
//    
//    
//        self.shopview.frame = CGRectMake(0, HEIGHT-49-50, WIDTH, 50);
// //   self.shopview.frame = CGRectMake(0, 300 ,WIDTH, 50);
//        self.shopview.delegate=self;
//    
//        [self.view addSubview:self.shopview];
////        [UIView animateWithDuration:0.2 animations:^{
////    
////            self.shopview.frame = CGRectMake(0,  HEIGHT-49-50, WIDTH, 50);
////        }];

   
 
}
-(void)requestForshoppingList
{
    
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user=[User sharedUser];
    NSDictionary *parameters = @{@"uid":user.uid};
    // set.fitness.subscribedelete
    [manager GetWithParameters:parameters method:@"get.user.cartlist" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                [self.MyTableView reloadData];
            }else
            {
                //
//                [SVProgressHUD showSuccessWithStatus:@"加入购物车成功"];
                //
                                [self.dataArr addObjectsFromArray:[dictionary objectForKey:@"data"]];
                                [self.MyTableView reloadData];
                                [self.MyTableView headerEndRefreshing];
                
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
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ShopingView" owner:nil options:nil]; //&1
    self.shopview = [views lastObject];

    
    self.shopview.frame = CGRectMake(0, HEIGHT-49-50, WIDTH, 50);
    
    self.shopview.delegate=self;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.shopview];
    [UIView animateWithDuration:0.2 animations:^{

        self.shopview.frame = CGRectMake(0,  HEIGHT-49-50, WIDTH, 50);
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
 
    [UIView animateWithDuration:0.2 animations:^{

        self.shopview.frame = CGRectMake(0,  HEIGHT-49-50, WIDTH, 50);
    } completion:^(BOOL finished) {
        [self.shopview removeFromSuperview];
    }];
}


-(void)TakeintoAnotherUI
{
//    OrderViewController *orderVC=[[OrderViewController alloc]initWithNibName:@"OrderViewController" bundle:nil];
//    [self.navigationController pushViewController:orderVC animated:YES];
    
     [self performSegueWithIdentifier:@"gotoshopping" sender:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    if (_dataArr.count ==0)
//    {
//        return 0;
//    }
    return _dataArr.count;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //  QRModelGetClient *get = _dataArr[indexPath.row];
    // TESTUser *test = get.data;
 
        
        ShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCell"forIndexPath:indexPath];
        if(!cell)
        {
            cell=[[ShoppingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShoppingCell"];
        }
        /*
         @property (weak, nonatomic) IBOutlet UILabel *ProductLab;
         @property (weak, nonatomic) IBOutlet UILabel *PriceLab;
         @property (weak, nonatomic) IBOutlet UILabel *CountLab;
         @property (weak, nonatomic) IBOutlet UIImageView *ProductImageView;
         */
        
        NSDictionary *dic=_dataArr[indexPath.row];
        cell.ProductLab.text=[NSString stringWithFormat:@"%@",dic[@"name"]];
        cell.PriceLab.text=[NSString stringWithFormat:@"%@",dic[@"buyprice"]];
        cell.CountLab.text=[NSString stringWithFormat:@"%@",dic[@"quetity"]];
        [cell.ProductImageView sd_setImageWithURL:[NSURL URLWithString:dic[@"imgurl"]] placeholderImage:[UIImage imageNamed:@""]];
        cell.Count2Lab.text=[NSString stringWithFormat:@"%@",dic[@"quetity"]];
        return cell;


    
    // [cell updateGoodsCellUiWithAttributes:_dataArr[indexPath.row]];
    
   
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)minueBtn:(id)sender {
    
 
}

- (IBAction)selectedBtn:(id)sender {
}
- (IBAction)addBtn:(id)sender {
}
@end
