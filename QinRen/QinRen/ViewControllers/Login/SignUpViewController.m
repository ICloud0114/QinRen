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
#import "EAHttpAPIClient.h"
#import "SVProgressHUD.h"
#import "JSONKit.h"
#import "DataParser.h"

@interface SignUpViewController ()
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
    if (section == 0) {
        return 9;
    }else
    {
        return 1;
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

                break;
            case 3:
                confirmField = cell.textField;
                cell.textField.placeholder = @"确认密码";

                break;
            case 4:
                sexField = cell.textField;
                cell.textField.placeholder = @"性别";

                break;
            case 5:
                birthField = cell.textField;
                cell.textField.placeholder = @"出生日期";

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
    }else if (indexPath.section == 1)
    {
        SignupButtonCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SignupButtonCell"];
        [cell.signupButton addTarget:self action:@selector(SignUp) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 45;
    }else
    {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 25;
    }
    return 0;
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
