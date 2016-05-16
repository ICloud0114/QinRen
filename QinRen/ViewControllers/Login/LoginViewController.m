//
//  LoginViewController.m
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

#import "ForgetSecViewcomtroller.h"
/*
 {"verification":true,"total":1,"data":[{"uid":"1","username":"15818738100","realname":"15818738100","icon":"","funds":"2797669.60","Integral":"958073.00","mshopid":"0","paypwd":"49ba59abbe56e057","groupid":"1","groupname":"普通会员组","discount":"100.00","msg":"登录成功","status":"1"}],"error":null}
 */
 

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *savePwButton;
@property (strong, nonatomic) IBOutlet UIButton *saveUserButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
   // User *user = [User sharedUser];
//    NSString *passwd = user.paypwd;
//    NSString *userid = user.uid;
   
    // Do any additional setup after loading the view from its nib.
    self.signUpButton.layer.cornerRadius = 6.0f;

    self.loginButton.layer.cornerRadius = 6.0f;
    
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:ifSaveAccount])
    {
        self.userField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        self.saveUserButton.selected = YES;
        if ([[NSUserDefaults standardUserDefaults]boolForKey:ifSavePassword]) {
            self.pwField.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"password"];
            self.savePwButton.selected = YES;
        }
    }
    
    self.userField.text = @"13713004891";
    self.pwField.text = @"123456";
    
}


- (IBAction)gotoSignUp:(id)sender
{
    [self performSegueWithIdentifier:@"SignUp" sender:self];

}


- (void)requestForLogin
{
    if (self.userField.text.length <= 0 || self.pwField.text.length <= 0)
    {
        [SVProgressHUD showErrorWithStatus:@"请填写用户名或密码"];
        return;
    }
    
    
    [SVProgressHUD show];
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"username":self.userField.text,@"password":self.pwField.text};
    
    [manager GetWithParameters:parameters method:@"get.user.login" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            if ([dictionary[@"data"] isKindOfClass:[NSArray class]])
            {
                
                NSDictionary *useDictionary = [[dictionary objectForKey:@"data"]firstObject];
                if ([[useDictionary objectForKey:@"status"]intValue] <= 0)
                {
                    [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
                    
                }else
                {
                    //
                    [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                    [NSThread sleepForTimeInterval:1.0f];
                    
                    //
                    if (self.saveUserButton.selected)
                    {
                        [[NSUserDefaults standardUserDefaults]setObject:[useDictionary objectForKey:@"username"] forKey:@"username"];
                        if (self.savePwButton.selected)
                        {
                            [[NSUserDefaults standardUserDefaults]setObject:self.pwField.text forKey:@"password"];
                        }
                    }
                    
                    //
                    User *user = [User sharedUser];
                    [user setUserInfo:useDictionary];
                    
                    
                    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [appdelegate setupTabbar];
                    
                    [self presentViewController:appdelegate.tabbarController animated:NO completion:NULL];
                    
                }
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

- (IBAction)login:(id)sender
{
    [self requestForLogin];
}

- (IBAction)savepassword:(id)sender
{
    self.savePwButton.selected = !self.savePwButton.selected;
    [[NSUserDefaults standardUserDefaults]setBool:self.savePwButton.selected forKey:ifSavePassword];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (IBAction)saveaccount:(id)sender
{
    self.saveUserButton.selected = !self.saveUserButton.selected;
    [[NSUserDefaults standardUserDefaults]setBool:self.saveUserButton.selected forKey:ifSaveAccount];
    [[NSUserDefaults standardUserDefaults]synchronize];
}



- (void)forgetpassword
{
    ForgetSecViewcomtroller *vc=[[ForgetSecViewcomtroller alloc]init];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == [self.view viewWithTag:10086]) {
        [self forgetpassword];
        return NO;
    }
    return YES;
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
