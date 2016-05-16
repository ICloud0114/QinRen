//
//  BookingViewController.m
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "BookingViewController.h"
#import "EAHttpAPIClient.h"
#import "JSONKit.h"
#import "DataParser.h"
#import "SVProgressHUD.h"
#import "BookingCell.h"
#import "SAMTextView.h"
#import "NSString+Regular.h"
#import "CustomDatePickerView.h"


@interface BookingViewController ()
{
    SAMTextView *illTextView;
    UITextField *programField;
    UITextField *dateField;
    UIButton *_dataFieldBtn;
    UITextField *mobileField;
    UILabel *textLabel;
    UIBarButtonItem *rightItem;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
//                                                                   nil];
    
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1], NSForegroundColorAttributeName,
                                nil];
    [self.segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    self.segment.selectedSegmentIndex = self.type - 1;
  
    
    NSDictionary *attributes1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                 [UIColor whiteColor], NSForegroundColorAttributeName,
                                 nil];
    [self.segment setTitleTextAttributes:attributes1 forState:UIControlStateSelected];
    
    [self.segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];

    NSString *title;
    if (self.modify) {
        title = @"修改";
    }else
        title = @"提交";
   rightItem  = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(submitService)];
    rightItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    _dataFieldBtn=[UIButton buttonWithType: UIButtonTypeCustom];
    _dataFieldBtn.frame=CGRectMake(100, 215, 200, 40);
    [_dataFieldBtn addTarget:self action:@selector(choseDate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_dataFieldBtn];
   
    
  
    
}
///日期
-(void)choseDate:(UIButton*)sender
{
    if(self.tabBarController.tabBar.hidden)
    {
    self.tabBarController.tabBar.hidden=YES;
    CustomDatePickerView *pickView=[[CustomDatePickerView alloc] init];
   [pickView setCommitBlock:^(NSString *result) {

        dateField.text=result;

    }];
    [self.view addSubview:pickView];
    }
    
}

//- (void)submitService
//{
//    rightItem.enabled = (programField.text.length && dateField.text.length);
//}
-(void)change:(UISegmentedControl *)segmentControl
{
    NSLog(@"segmentControl %d",segmentControl.selectedSegmentIndex);
  
    if(segmentControl.selectedSegmentIndex==0)
    {
        programField.text=@"     疗养预约";
    }
    else if (segmentControl.selectedSegmentIndex==1)
    {
         programField.text=@"    健康管理师预约";
    }
    else
    {
         programField.text=@"      团购预约";
    }
}
#pragma mark -
#pragma mark - Action
- (void)submitService
{
    
    if (programField.text.length <= 0 || illTextView.text.length <= 0 || dateField.text.length <= 0 || mobileField.text.length <= 0) {
        [SVProgressHUD showErrorWithStatus:@"请将信息填写完整" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if ([NSString validateMobile:mobileField.text] == NO)
    {
        [SVProgressHUD showErrorWithStatus:@"请填写正确的电话号码" maskType:SVProgressHUDMaskTypeClear];
        return;
    }
    
    if (self.modify) {
        [self requestForModify];
    }else
    {
        [self requestForSubmit];
    }
}


//-(void)submitService
//{
//    // 1.关闭当前控制器
//    [self.navigationController popViewControllerAnimated:YES];
//    
//    // 2.传递数据给上一个控制器(MJContactsViewController)
//    // 2.通知代理
//    if ([self.delegate respondsToSelector:@selector(addViewController:didAddContact:)]) {
//        BookingModel *contact = [[BookingModel alloc] init];
//        contact.name = programField.text;
//        contact.phone = dateField.text;
//        [self.delegate addViewController:self didAddContact:contact];
//    }
//}
- (IBAction)segmengtValueChanged:(id)sender
{
    if (self.segment.selectedSegmentIndex == 0)
    {
        self.type = BookingType1;
       
        
    }else if (self.segment.selectedSegmentIndex == 1)
    {
        self.type = BookingType2;
    }else if (self.segment.selectedSegmentIndex == 2)
    {
        self.type = BookingType3;
    }
}

#pragma mark -
#pragma mark - 提交预约
- (void)requestForSubmit
{
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
    NSDictionary *parameters = @{@"userid":user.uid,@"state":@"0",@"custodian":@"好医生",@"moble":mobileField.text,@"subscribeTime":dateField.text,@"bodys":@"候鸟式养生",@"bewrite":illTextView.text,@"type":[NSString stringWithFormat:@"%ld",self.type]};
    
    [manager GetWithParameters:parameters method:@"set.fitness.subscribe" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                //
                [SVProgressHUD showSuccessWithStatus:@"预约添加成功"];
                if ([self.delegate respondsToSelector:@selector(bookingViewControllerDidFinishAdd:)])
                {
                    [self.delegate bookingViewControllerDidFinishAdd:self];
//
                }
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
#pragma mark - 修改预约
- (void)requestForModify
{
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSDictionary *parameters = @{@"uuserid":@"516",@"ustate":@"0",@"ucustodian":@"好医生",@"umoble":mobileField.text,@"usubscribeTime":dateField.text,@"ubodys":@"候鸟式养生",@"ubewrite":illTextView.text,@"usubscribeid":[self.dictionary objectForKey:@"subscribeid"],@"utype":[NSString stringWithFormat:@"%ld",self.type]};
    
    [manager GetWithParameters:parameters method:@"update.fitness.subscribe" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                [SVProgressHUD showErrorWithStatus:@"修改失败"];
            }else
            {
                //
                [SVProgressHUD showSuccessWithStatus:@"预约添加成功"];
                if ([self.delegate respondsToSelector:@selector(bookingViewControllerDidFinishAdd:)]) {
                    [self.delegate bookingViewControllerDidFinishAdd:self];
                    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - 
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        BookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingCell1"];
        cell.textView.placeholder = @"病情描述";
        if (self.modify) {
            if (![[self.dictionary objectForKey:@"bewrite"] isEqualToString:@""]) {
                cell.textView.text = [self.dictionary objectForKey:@"bewrite"];
            }
        }
        illTextView = cell.textView;
        
        return cell;
    }else if(indexPath.section == 1)
    {
        BookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingCell2"];
        cell.nameLabel.text = @"预约项目";
       
        if (self.modify) {
            if (![[self.dictionary objectForKey:@"bodys"] isEqualToString:@""]) {
                cell.contentLabel.text = [self.dictionary objectForKey:@"bodys"];
            }
        }
        programField = cell.contentLabel;
          programField.text=@"     疗养预约";
        return cell;
    }
    else if(indexPath.section == 2)
    {
        BookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingCell2"];
        cell.nameLabel.text = @"预约日期";
        if (self.modify) {
            if (![[self.dictionary objectForKey:@"subscribeTime"] isEqualToString:@""]) {
                cell.contentLabel.text = [Until convertToTime:[self.dictionary objectForKey:@"subscribeTime"]];
            }
        }
        dateField = cell.contentLabel;

        return cell;
    }else if(indexPath.section == 3)
    {
        BookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingCell2"];
        if (self.modify) {
            if (![[self.dictionary objectForKey:@"moble"] isEqualToString:@""]) {
                cell.contentLabel.text = [self.dictionary objectForKey:@"moble"];
            }
        }
        cell.nameLabel.text = @"手机号";
        mobileField = cell.contentLabel;

        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 70;
    }
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.hidesBottomBarWhenPushed=YES;
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
