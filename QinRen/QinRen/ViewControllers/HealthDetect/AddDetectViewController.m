 //
//  AddDetectViewController.m
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "AddDetectViewController.h"
#import "AddDetectCell.h"
#import "EAHttpAPIClient.h"
#import "DataParser.h"
#import "JSONKit.h"
#import "SVProgressHUD.h"

@interface AddDetectViewController ()<UITextFieldDelegate>
{
    UITextField *tallField; //身高
    UITextField *heightField; //体重
    UITextField *rateField; //心率
    UITextField *oxygenField; //血氧
    UITextField *sugarField; //空腹血糖
    UITextField *sugarAfterLunchField; //餐后血糖
    UITextField *proteinField; //糖化红蛋白
    UITextField *sbpField; //收缩压
    UITextField *dbpField; //舒张压
    UITextField *waistlineField; //腰围
    UITextField *temperatureField; //体温
    
    //血脂检测
    UITextField *textField1;
    UITextField *textField2;
    UITextField *textField3;
    UITextField *textField4;
    
    //心电监测
    UITextField *textFieldA;
    UITextField *textFieldB;


}
@end

@implementation AddDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //
    tallField=[[UITextField alloc]init];
    
    if (self.ifCheck)
    {
        self.navigationItem.rightBarButtonItem = nil;
        self.title = @"详情";
        
        
    }
//    else
////        self.type = AddType1;
//    if(self.type==0)
//    {
////        self.type = AddType1;
//    }
//    else if (self.type==1)
//    {
////        self.type = AddType2;
//    }
    
}

#pragma mark - 
#pragma mark - Action
- (IBAction)addAction:(id)sender
{
    if (self.type == AddType1)
    {
  [self requestForAdd];
        
    }else if (self.type == AddType2)
    {
        if ([self checkIfEmptyType2])
        {
            return;
        }
        [self requestForAdd];
    }
    else if (self.type==AddType3)
    {
        [self requestForAdd];
    }
    else if (self.type==AddType4)
    {
        [self requestForAdd];
    }
    
    
    
    
}


#pragma mark - 
#pragma mark - 添加网络请求
- (void)requestForAdd
{
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
    NSDictionary *aparameters = @{@"sbcode":user.username,@"sn":@"",@"tag":@"",@"uid":user.uid};
    NSDictionary *json = [self parameterType2];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:aparameters];
    [parameters addEntriesFromDictionary:json];
    
    [manager GetWithParameters:parameters method:@"set.para.save" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        NSLog(@"dictonary健康监测 :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD showErrorWithStatus:@"添加失败"];
                NSLog(@"error :%@",[[dictionary objectForKey:@"error"]description]);
            }else
            {
                //
                [SVProgressHUD showSuccessWithStatus:@"数据添加成功"];
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
#pragma mark - 填写检查
- (BOOL)checkIfEmptyType1
{
    return NO;
}

- (BOOL)checkIfEmptyType2
{
    if (textField1.text.length <= 0 || textField2.text.length <= 0 || textField3.text.length <= 0 || textField4.text.length <= 0) {
        return YES;
    }
    return NO;
}


- (NSDictionary *)parameterType2
{
   
    NSDictionary *dictionary = @{@"zdgc":textField2.text, @"gmdgc":textField3.text,  @"dmdzdbgc":textField4.text,  @"glycerin trimyris":textField1.text};
        NSString *json = [dictionary JSONString];
        return @{@"para":json};
 
 
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.type == AddType1)
    {
        return    10;
    }else if (self.type == AddType2)
    {
        return 4;
    }
    else if (self.type==AddType3)
    {
        return 2;
    }
    else if (self.type==AddType4)
    {
        return 2;
    }
    
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == AddType1)
    {
        AddDetectCell * cell = (AddDetectCell *)[self  cellForType1:tableView AtIndexPath:indexPath];
        return cell;
    }else if (self.type == AddType2)
    {
        AddDetectCell * cell = (AddDetectCell *)[self  cellForType2:tableView AtIndexPath:indexPath];
        return cell;
    }
    else if (self.type==AddType3)
    {
        AddDetectCell *cell=(AddDetectCell *)[self cellForType3:tableView AtIndexPath:indexPath];
        return cell;
    }
    else if (self.type==AddType4)
    {
        AddDetectCell *cell=(AddDetectCell *)[self cellForType4:tableView AtIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}




- (UITableViewCell *)cellForType1:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section != 7)
    {
        AddDetectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddDetectCell"];
        cell.style = AddDetectCellStyleNormal;
        switch (indexPath.section) {
            case 0:
                cell.nameLabel.text = @"身高";
                cell.unitLabel.text = @"/厘米";
                tallField = cell.inputField;
                break;
            case 1:
                cell.nameLabel.text = @"体重";
                cell.unitLabel.text = @"/公斤";
                heightField = cell.inputField;
                break;
            case 2:
                cell.nameLabel.text = @"心率";
                cell.unitLabel.text = @"次/分钟";
                rateField = cell.inputField;
                break;
            case 3:
                cell.nameLabel.text = @"血氧";
                cell.unitLabel.text = @"%";
                oxygenField = cell.inputField;
                break;
            case 4:
                cell.nameLabel.text = @"空腹血糖";
                cell.unitLabel.text = @"mmol/L";
                sugarField = cell.inputField;
                break;
            case 5:
                cell.nameLabel.text = @"餐后血糖";
                cell.unitLabel.text = @"mmol/L";
                sugarAfterLunchField = cell.inputField;
                break;
            case 6:
                cell.nameLabel.text = @"糖化红蛋白";
                cell.unitLabel.text = @"%";
                proteinField = cell.inputField;
                break;
            case 8:
                cell.nameLabel.text = @"腰围";
                cell.unitLabel.text = @"厘米";
                waistlineField = cell.inputField;
                break;
            case 9:
                cell.nameLabel.text = @"体温";
                cell.unitLabel.text = @"°C";
                temperatureField = cell.inputField;
                break;
            default:
                break;
        }
        return cell;
    }else
    {
        AddDetectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddDetectCell1"];
        cell.style = AddDetectCellStyleTwoField;
        cell.nameLabel.text = @"收缩压/舒张压";
        cell.unitLabel.text = @"mmHg";
        sbpField = cell.inputField;
        dbpField = cell.inputField2;
        return cell;
    }
    return nil;
}

- (UITableViewCell *)cellForType2:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    AddDetectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddDetectCell"];
    cell.style = AddDetectCellStyleNormal;
    switch (indexPath.section) {
        case 0:
            cell.nameLabel.text = @"甘油三酯";
            cell.unitLabel.text = @"mmol/L";
            textField1 = cell.inputField;
            if(self.type == AddType2 &&self.ifCheck == YES)
            {
                NSDictionary *attributeDict = [[self.checkDictionary objectForKey:@"fat"]objectAtIndex:indexPath.section];
                NSString *vlues = [attributeDict objectForKey:@"vlues"];
                cell.inputField.text = vlues;
            }
            break;
        case 1:
            cell.nameLabel.text = @"总胆固醇";
            cell.unitLabel.text = @"mmol/L";
            textField2 = cell.inputField;
            if(self.type == AddType2 &&self.ifCheck == YES)
            {
                NSDictionary *attributeDict = [[self.checkDictionary objectForKey:@"fat"]objectAtIndex:indexPath.section];
                NSString *vlues = [attributeDict objectForKey:@"vlues"];
                cell.inputField.text = vlues;

            }
            break;
        case 2:
            cell.nameLabel.text = @"高密度脂蛋白固醇";
            cell.unitLabel.text = @"mmol/L";
            textField3 = cell.inputField;
            if(self.type == AddType2 &&self.ifCheck == YES)
            {
                NSDictionary *attributeDict = [[self.checkDictionary objectForKey:@"fat"]objectAtIndex:indexPath.section];
                NSString *vlues = [attributeDict objectForKey:@"vlues"];
                cell.inputField.text = vlues;

            }
            break;
        case 3:
            cell.nameLabel.text = @"低密度脂蛋白固醇";
            cell.unitLabel.text = @"mmol/L";
            textField4 = cell.inputField;
            if(self.type == AddType2 &&self.ifCheck == YES)
            {
                NSDictionary *attributeDict = [[self.checkDictionary objectForKey:@"fat"]objectAtIndex:indexPath.section];
                NSString *vlues = [attributeDict objectForKey:@"vlues"];
                cell.inputField.text = vlues;

            }
            break;
        
        default:
            break;
    }
    
    return cell;
}
- (UITableViewCell *)cellForType3:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    AddDetectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddDetectCell"];
    cell.style = AddDetectCellStyleNormal;
    switch (indexPath.section) {
        case 0:
            cell.nameLabel.text = @"身体含水量";
            cell.unitLabel.text = @"/L";
            textFieldA = cell.inputField;

            break;
        case 1:
            cell.nameLabel.text = @"心跳测试";
            cell.unitLabel.text = @"/次";
            textFieldB = cell.inputField;
            break;
 
            
        default:
            break;
    }
    
    return cell;
}
- (UITableViewCell *)cellForType4:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    AddDetectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddDetectCell"];
    cell.style = AddDetectCellStyleNormal;
    switch (indexPath.section) {
        case 0:
            cell.nameLabel.text = @"运动时间";
            cell.unitLabel.text = @"/L";
            textFieldA = cell.inputField;
            
            break;
        case 1:
            cell.nameLabel.text = @"耗能";
            cell.unitLabel.text = @"/次";
            textFieldB = cell.inputField;
            break;
            
            
        default:
            break;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.ifCheck) {
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
