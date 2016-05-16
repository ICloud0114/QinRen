//
//  SignUpViewController.m
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "SignUpViewController.h"
#import "SignupCell.h"
#import "SignupButtonCell.h"
#import "CustomDatePickerView.h"

@interface SignUpViewController ()<UITextFieldDelegate,UIActionSheetDelegate>
{
    UITextField *userField;
    UITextField *pwdField;
    UITextField *confirmField;
    UITextField *nameField;
    UITextField *sexField;
    UITextField *birthField;
    UITextField *idcardField;
    UITextField *moibleField;
    UITextField *industryField; //病史
        UIButton *_dataFieldBtn;
    UIActionSheet *myActionSheet;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
    self.tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] init];

   
    
}




- (void)SignUp
{
//    AFNetworkReachabilityStatus status = [[AFNetworkReachabilityManager sharedManager] networkReachabilityStatus];
//    if (status < 1)
//    {
//        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//        [SVProgressHUD showErrorWithStatus:@"网络似乎断开了"];
//        return;
//    }
    
    if (userField.text.length <= 0 || pwdField.text.length <= 0 || confirmField.text.length <= 0 || nameField.text <= 0 || moibleField.text.length <= 0 || idcardField.text.length <= 0 || birthField.text.length <= 0 || industryField.text <= 0 || sexField.text.length <= 0)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整"];
        return;
    }
    
    if ([pwdField.text isEqualToString:confirmField.text] == NO) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:@"两次填写的密码不一致"];
        return;
    }
    
    
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"username":userField.text,@"pwd":pwdField.text,@"realname":nameField.text,@"mobile":moibleField.text,@"idcard":idcardField.text,@"birthtime":birthField.text,@"industry":industryField.text,@"sex":sexField.text};
    
    [manager GetWithParameters:parameters method:@"set.user.register" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD showErrorWithStatus:[dictionary objectForKey:@"error"]];
            }else
            {
                [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark -
#pragma mark - UITableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 9;
    }
    else
    {
        return 2;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        SignupCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SignupCell"];
        switch (indexPath.row) {
            case 0:
                userField = cell.textField;
                userField.placeholder = @"手机号/用户名/身份证号/会员卡号";
                break;
            case 1:
                nameField = cell.textField;
                cell.textField.placeholder = @"昵称";
                break;
            case 2:
                pwdField = cell.textField;
                cell.textField.placeholder = @"密码";

                cell.textField.secureTextEntry=YES;
                break;
            case 3:
                confirmField = cell.textField;
                cell.textField.placeholder = @"确认密码";
            cell.textField.secureTextEntry=YES;
                break;
            case 4:
                sexField = cell.textField;
                cell.textField.placeholder = @"性别";
                sexField.delegate=self;
                
                break;
            case 5:
                birthField = cell.textField;
                cell.textField.placeholder = @"出生日期";

                birthField.delegate = self;
                
                
                break;
            case 6:
                idcardField = cell.textField;
                cell.textField.placeholder = @"身份证号";

                break;
            case 7:
                moibleField = cell.textField;
                cell.textField.placeholder = @"联系电话";

                break;
            case 8:
                industryField = cell.textField;
                cell.textField.placeholder = @"病史";

                break;
            
            default:
                break;
        }
        return cell;
    }
    else if (indexPath.section == 1)
    {
        if(indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cell"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                cell.backgroundColor = [UIColor clearColor];
                return cell;
                
            }
        }
        else
        {
            SignupButtonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SignupButtonCell"];
            [cell.signupButton addTarget:self action:@selector(SignUp) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        
        
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 45;
    }
    else
    {
        if (indexPath.row == 0)
        {
            return 25;
        }
        return 50;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (section == 1)
//    {
//        return 0;
//    }
//    return 0;
//}
//不让组头跟随
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.tableView)
    {
        CGFloat sectionHeaderHeight = 25;
        if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }
        else if (scrollView.contentOffset.y >= sectionHeaderHeight)
        {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}



- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  
        //
    if(textField==birthField)
    {
     
        
        if(!self.tabBarController.tabBar.hidden)
        {
            self.tabBarController.tabBar.hidden=YES;
            CustomDatePickerView *pickView=[[CustomDatePickerView alloc] init];
            [pickView setCommitBlock:^(NSString *result) {
                
                birthField.text=result;
                
            }];
           [self.view addSubview:pickView];
            [self.view endEditing:YES];

        }
        
    }
   if(textField==sexField)
    {
     
        if(!self.tabBarController.tabBar.hidden)
        {
            self.tabBarController.tabBar.hidden=YES;
        
        myActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"取消", nil) destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"男", nil),NSLocalizedString(@"女",nil), nil];
        myActionSheet.tag = 1001;
        [myActionSheet showInView:self.view];

        //   [self.view addSubview:myActionSheet];
        }
        
         [self.view endEditing:YES];
        
    }
}

#pragma mark  UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        
        sexField.text=@"男";
    }
    else
    {
        sexField.text=@"女";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
    
}

@end
