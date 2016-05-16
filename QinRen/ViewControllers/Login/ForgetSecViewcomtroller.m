//
//  ForgetSecViewcomtroller.m
//  QinRen
//
//  Created by Easaa on 15/3/30.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "ForgetSecViewcomtroller.h"

#import "CustomDatePickerView.h"


//#import "Unit.h"

@interface ForgetSecViewcomtroller ()<UITextFieldDelegate,UIActionSheetDelegate>
{
    UITextField *idcardNO;
    UITextField *verfiNO;
    UITextField *sexNO;
    UITextField *birthNo;
    UITextField *phoneNo;
    UITextField *newNO;
    UITextField *newNO1;
     NSInteger counter;
    UIButton *btn1;
}
@property (nonatomic,strong)UIActionSheet *myActionSheet;
@end

@implementation ForgetSecViewcomtroller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
 self.title = @"找回密码";
   self.tabBarItem.title=@"找回密码";
    self.view.backgroundColor=[UIColor colorWithRed:231.0/255.0 green:231.0/255.0 blue:231.0/255.0 alpha:5];
    [self creatUI];
}
-(void)creatUI
{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 100, 30)];
    label.text=@"修改密码";
    label.backgroundColor=[UIColor whiteColor];
    label.font=[UIFont fontWithName:@"Arial" size:14];
    label.textAlignment=NSTextAlignmentCenter;
    label.layer.cornerRadius=5.0f;
    label.layer.masksToBounds=YES;
    [self.view addSubview:label];


   idcardNO =[[UITextField alloc]initWithFrame:CGRectMake(20, 60, 140, 25)];
    [self creatTextField:idcardNO placeholder:@"请输入您的身份证/护照/军官证"];
   // idcardNO.text=@"333";
    [self.view addSubview:idcardNO];
    
    verfiNO=[[UITextField alloc]initWithFrame:CGRectMake(20, 90, 140, 25)];
    [self creatTextField:verfiNO placeholder:@"请输入注册姓名"];
   // verfiNO.text=@"444";
    [self.view addSubview:verfiNO];
    
    sexNO=[[UITextField alloc]initWithFrame:CGRectMake(20, 120, 140, 25)];
    [self creatTextField:sexNO placeholder:@"请输入注册性别"];
  // sexNO.text=@"1s";
    sexNO.delegate=self;
    [self.view addSubview:sexNO];
    
    birthNo=[[UITextField alloc]initWithFrame:CGRectMake(20, 150, 140, 25)];
    [self creatTextField:birthNo placeholder:@"请输入生日日期"];
   // birthNo.text=@"211";
    birthNo.delegate=self;
    [self.view addSubview:birthNo];
    
    phoneNo=[[UITextField alloc]initWithFrame:CGRectMake(20, 180, 140, 25)];
  //  phoneNo.text=@"dd";
    [self creatTextField:phoneNo placeholder:@"请输入电话号码"];
    [self.view addSubview:phoneNo];

    
    btn1=[UIButton buttonWithType: UIButtonTypeRoundedRect];
    btn1.frame=CGRectMake(200, 130, 100, 100);
    [btn1 setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:152.0/255.0 blue:29.0/255.0 alpha:1]];
    [btn1 setTitle:@"验证中" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(verifiNO) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.cornerRadius=8.0f;
    btn1.layer.masksToBounds=YES;
    [btn1.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.view addSubview:btn1];
    
    
    newNO=[[UITextField alloc]initWithFrame:CGRectMake(20, 210, 140, 25)];
      [self creatTextField:newNO placeholder:@"请输入新密码"];
  //  newNO.text=@"001";
    [self.view addSubview:newNO];
    
    
    newNO1=[[UITextField alloc]initWithFrame:CGRectMake(20, 240, 140, 25)];
 [self creatTextField:newNO1 placeholder:@"请重新输入密码"];
  //  newNO1.text=@"001";
    [self.view addSubview:newNO1];
    
    UIButton *btn=[UIButton buttonWithType: UIButtonTypeRoundedRect];
    btn.frame=CGRectMake(20, 400, 280, 30);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:152.0/255.0 blue:29.0/255.0 alpha:1]];
    btn.layer.cornerRadius=8.0f;
    btn.layer.masksToBounds=YES;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:10]];
  
    [self.view addSubview:btn];
    
    UIButton *back=[UIButton buttonWithType: UIButtonTypeRoundedRect];
    back.frame=CGRectMake(20, 460, 280, 30);
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back setBackgroundColor:[UIColor colorWithRed:102.0/255.0 green:152.0/255.0 blue:29.0/255.0 alpha:1]];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    back.layer.cornerRadius=8.0f;
    back.layer.masksToBounds=YES;
    [back.titleLabel setFont:[UIFont systemFontOfSize:10]];
       [self.view addSubview:back];

}
-(void)creatTextField:(UITextField *)textfield placeholder:(NSString *)placeholder
{
    textfield.borderStyle = UITextBorderStyleRoundedRect;
    textfield.placeholder=placeholder;
    textfield.font = [UIFont systemFontOfSize:10];
   
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)verifiNO
{
    if (idcardNO.text.length <= 0 || verfiNO.text.length <= 0|| sexNO.text.length <= 0 || birthNo.text <= 0 || phoneNo.text.length <= 0 )
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整"];
        return;
    }

    [SVProgressHUD show];
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(getTimer:) userInfo:nil repeats:YES];
//    counter = 60;
//    //    [ZZTool showHud:self.view title:@"正在提交数据" animated:YES];

    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *sex ;
    if ([sexNO.text isEqualToString:@"男"])
    {
        sex = @"1";
    }
    else
    {
        sex = @"2";
    }
    NSDictionary *parameters = @{@"customer_truename":verfiNO.text,
                                 @"customer_credentialscard":idcardNO.text,
                                 @"customer_gender":sex,
                                 @"customer_birthday":birthNo.text,
                                 @"uphone":phoneNo.text,
                                 @"unewpwd":newNO.text,
                                 @"unewpwdcfm":newNO1.text};
 
    
    [manager GetWithParameters:parameters method:@"update.user.resetpwd" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        NSLog(@"dictonary :%@",[dictionary description]);
        
        if([dictionary[@"total"] integerValue] == 0)
        {
            [SVProgressHUD showErrorWithStatus:@"验证失败"];
            return ;
        }
        else
        {
            [SVProgressHUD showSuccessWithStatus:@"验证成功"];
            [NSThread sleepForTimeInterval:1.0f];
            return ;
            
        }
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([dictionary[@"data"] isKindOfClass:[NSArray class]])
            {
                
                NSDictionary *useDictionary = [[dictionary objectForKey:@"data"]firstObject];
                if ([[useDictionary objectForKey:@"status"]intValue] <= 0)
                {
                    [SVProgressHUD showErrorWithStatus:@"验证失败"];
                  
                    
                }else
                {
                    //
                    [SVProgressHUD showSuccessWithStatus:@"验证成功"];
                    [NSThread sleepForTimeInterval:1.0f];
                    
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField==birthNo)
    {
        if(!self.tabBarController.tabBar.hidden)
        {
            [self.view endEditing:YES];
            self.tabBarController.tabBar.hidden=YES;
            CustomDatePickerView *pickView=[[CustomDatePickerView alloc] init];
            [pickView setCommitBlock:^(NSString *result) {
                
                birthNo.text=result;
                
            }];
            [self.view addSubview:pickView];
            [self.view endEditing:YES];
            
        }
        
    }
    if(textField==sexNO)
    {
        
        if(!self.tabBarController.tabBar.hidden)
        {
            self.tabBarController.tabBar.hidden=YES;
            
            _myActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"男", nil),NSLocalizedString(@"女",nil), nil];
            _myActionSheet.tag = 1001;
            [_myActionSheet showInView:self.view];

            
            //   [self.view addSubview:myActionSheet];
        }
        
        [self.view endEditing:YES];
        
    }
}
#pragma mark  UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        sexNO.text=@"男";
    }
    else
    {
        sexNO.text=@"女";
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
