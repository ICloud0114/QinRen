//
//  OrderViewController.m
//  QinRen
//
//  Created by Easaa on 15/4/21.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "OrderViewController.h"
#import "ShopingView.h"
#import "Order.h"
#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>


@interface OrderViewController ()
{
      NSMutableDictionary  *infoDic;
}
@property (weak, nonatomic) IBOutlet UIView *defaultSiteView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;
@property (weak, nonatomic) IBOutlet UIButton *addSiteButton;
@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@property (nonatomic,strong) NSDictionary   *dataDic;
- (IBAction)confirmOrder:(id)sender;
@property (nonatomic,strong)ShopingView *shopview;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  //  [self.mytableview registerNib:[UINib nibWithNibName:@"ShoppingCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self getUserDefaultAddress];
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"ShopingView" owner:nil options:nil]; //&1
//    self.shopview = [views lastObject];
//    
//    
//    self.shopview.frame = CGRectMake(0, HEIGHT-55, WIDTH, 60);
//    
//  //  self.shopview.delegate=self;
//    
//    [[UIApplication sharedApplication].keyWindow addSubview:self.shopview];
//    [UIView animateWithDuration:0.2 animations:^{
//        
//        self.shopview.frame = CGRectMake(0,  HEIGHT-55, WIDTH, 60);
//    }];
//}
//-(void)viewWillDisappear:(BOOL)animated{
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        
//        self.shopview.frame = CGRectMake(0,  HEIGHT-55, WIDTH, 60);
//    } completion:^(BOOL finished) {
//        [self.shopview removeFromSuperview];
//    }];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *ID=@"orderlist";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
       return cell;
    
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 80;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)confirmOrder:(id)sender {
    
    UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                     message:@"订单已提交现在是否支付"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"确定", nil];
    alert1.tag = 1314;
    [alert1 show];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1314)
    {
        if (buttonIndex == 0)
        {
            for (UIViewController *temp in self.navigationController.viewControllers)
            {
                if ([temp isKindOfClass:[OrderViewController class]])
                {
                    [self.navigationController popToViewController:temp animated:YES];
                    break ;
                }
            }
            
        }
        else if (buttonIndex == 1)
        {
            
            NSDictionary *parametes = @{@"":@"",@"":@""};
            
            EAHttpAPIClient *manager = [EAHttpAPIClient manager];
            [manager GetWithParameters:parametes method:@"get.pay.address" success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSString *resposeString ;
                if ([responseObject isKindOfClass:[NSData class]]) {
                    resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
                }else
                    resposeString = responseObject;
                
                NSString *jsonString = [DataParser parseString:resposeString];
                id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];

                 [NSThread detachNewThreadSelector:@selector(getPayInfo:) toTarget:self withObject:dictionary];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
            for (UIViewController *temp in self.navigationController.viewControllers)
            {
                if ([temp isKindOfClass:[OrderViewController class]])
                {
                    [self.navigationController popToViewController:temp animated:YES];
                    break ;
                }
            }
            
        }
    }
}
-(void)getPayInfo:(NSDictionary*)dic
{
    DLog(@"支付宝参数:%@",dic);
    if ([dic[DATA] isKindOfClass:[NSArray class]])
    {
        if ([dic[DATA] count]> 0  )
        {
            [self paygoods:dic[DATA][0]];
        }
    }
}
-(void)paygoods:(NSDictionary*)dic
{
    
    NSString *partner = dic[Partner];
    NSString *seller = dic[Seller];
    NSString *privateKey = dic[PrivateKEY];
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = infoDic[@"orderid"]; //订单ID（由商家自行制定）
    order.productName = self.dataDic[@"intro"]; //商品标题
    order.productDescription = @"支付宝支付"; //商品描述
    order.amount = dic[Total_fee]; //商品价格
    order.notifyURL = dic[NoTify_URL]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"Alipy";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil)
    {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            //返回到商品列表
            for (UIViewController *temp in self.navigationController.viewControllers)
            {
                if ([temp isKindOfClass:[OrderViewController class]])
                {
                    [self.navigationController popToViewController:temp animated:YES];
                    break ;
                }
            }
            
        }];
        
    }
}

- (void)getUserDefaultAddress
{
    
    User *user = [User sharedUser];
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:user.uid,@"suid",@"1",@"isdefault", nil];
    [manager GetWithParameters:parameters method:@"get.user.address" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            NSDictionary *data = [[dictionary objectForKey:@"data"] firstObject];
              self.addSiteButton.hidden = YES;
            self.nameLabel.text = [data objectForKey:@"receivename"];
            self.phoneLabel.text = [data objectForKey:@"mobilephone"];
            self.siteLabel.text = [NSString stringWithFormat:@"%@%@%@%@",data[@"province"],data[@"city"],data[@"county"],data[@"address"]];
        }else
        {
//            NSString *error = [dictionary objectForKey:@"error"];
//            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//            [SVProgressHUD showErrorWithStatus:error];
            self.defaultSiteView.hidden = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        
    }];
}

@end
