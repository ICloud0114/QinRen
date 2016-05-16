//
//  BookingViewController.m
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "BookingViewController.h"
#import "BookingCell.h"
#import "SAMTextView.h"
#import "NSString+Regular.h"
#import "CustomDatePickerView.h"
#import "HotCell.h"
#import "MJRefresh.h"


@interface BookingViewController ()<NIDropDownDelegate,UITextFieldDelegate>
{
    SAMTextView *illTextView;
    UITextField *programField;
    UITextField *dateField;
    UIButton *_dataFieldBtn;
    UITextField *mobileField;
    UILabel *textLabel;
    UIBarButtonItem *rightItem;
    NSMutableArray *_dataArr1;
    NSString *string ;
    NSString *idc;
}


@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIButton *btnSelect;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)HotCell *tableCell;
@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
    _dataArr1=[[NSMutableArray alloc]init];
    _dataArr=[[NSMutableArray alloc]init];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                [UIColor colorWithRed:115/255.0 green:115/255.0 blue:115/255.0 alpha:1], NSForegroundColorAttributeName,
                                nil];
    [self.segment setTitleTextAttributes:attributes forState:UIControlStateNormal];
    self.segment.selectedSegmentIndex = self.type - 1;
    _tableCell.backgroundColor=[UIColor whiteColor];
    
//    if(self.type==BookingType1)
//    {
//        string =@"疗养预约";
//    }
//    else if (self.type==BookingType2)
//    {
//        string=@"健康管理师预约";
//    }
//    else
//    {
//        string=@"团购预约";
//    }

  
    
    NSDictionary *attributes1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [UIFont boldSystemFontOfSize:13], NSFontAttributeName,
                                 [UIColor whiteColor], NSForegroundColorAttributeName,
                                 nil];
    [self.segment setTitleTextAttributes:attributes1 forState:UIControlStateSelected];
   

    NSString *title;
    if (self.modify) {
        title = @"修改";
    }else
        title = @"提交";
   rightItem  = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(submitService)];
    rightItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightItem;

    self.tableView.tableFooterView = [[UIView alloc]init];
   //时间按钮
    _dataFieldBtn=[UIButton buttonWithType: UIButtonTypeCustom];
    _dataFieldBtn.frame=CGRectMake(100, 150, 200, 40);
    [_dataFieldBtn addTarget:self action:@selector(choseDate:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:_dataFieldBtn];
   //下拉菜单按钮
    _btnSelect=[[UIButton alloc]initWithFrame:CGRectMake(150, 100, 200, 30)];
    [_btnSelect addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSelect setTitle:@"点击选择" forState:UIControlStateNormal];
    [_btnSelect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _btnSelect.titleLabel.font=[UIFont fontWithName:@"Arial" size:13];
    [self.tableView addSubview:_btnSelect];
    
   // [self.tableView addHeaderWithTarget:self action:@selector(requestForAdd)];
    
   // [self requestForAdd];
}

-(void)selectedClick:(id)sender
{
    programField.text=@"";
    {
        
        if(self.type==BookingType1)
        {
    
            idc=@"1";
        }
        else if (self.type==BookingType2)
        {
          
            idc=@"2";
        }
        else
        {
          
            idc=@"3";
        }
        
        EAHttpAPIClient *manager = [EAHttpAPIClient manager];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
      //  User *user = [User sharedUser];
        
        NSDictionary *parameters = @{@"type":idc};
        
        [manager GetWithParameters:parameters method:@"get.fitness.dic.solution" success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *resposeString ;
            if ([responseObject isKindOfClass:[NSData class]]) {
                resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            }else
                resposeString = responseObject;
            
            NSString *jsonString = [DataParser parseString:resposeString];
            id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
            //  NSLog(@"dictonary :%@",[dictionary description]);
            
            
            if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
            {
                if ([[dictionary objectForKey:@"total"] intValue] <= 0)
                {
                    //                [self showNoReslutUI];
                    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                    [SVProgressHUD dismiss];
                    
                    [self.tableView reloadData];
                }
                else
                {
                    [_dataArr1 setArray:[dictionary objectForKey:@"data"]];
                    
                    [self.tableView reloadData];
                }
                [self.tableView headerEndRefreshing];
                
            }else
            {
                NSString *error = [dictionary objectForKey:@"error"];
                [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
                [SVProgressHUD showErrorWithStatus:error];
                [self.tableView headerEndRefreshing];
                
            }
            [_dataArr removeAllObjects];
            
            for(NSDictionary *dic in _dataArr1)
            {
                NSString *name=dic[@"st_name"];
                [_dataArr addObject:name];
            }


                if(_tableCell==nil)
                {
                    CGFloat f=120.0;
                    _tableCell=[[HotCell alloc]initShowDropDown:sender :&f :_dataArr :YES];
                    _tableCell.delegate=self;
                   
                }
                else
                {
                    [_tableCell hideDropDown:sender];
                    [self niDropDownDelegateMethod:_tableCell ID:nil];
                }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
            [self.tableView headerEndRefreshing];
            
        }];
    }
    
    
    
}
//-(void)selectedClick:(id)sender
//{
//    _dataArr=[NSArray arrayWithObjects:@"预约项目",@"预约项目1",@"预约项目2",@"预约项目3", nil];
//    if(_tableCell==nil)
//    {
//        CGFloat f=150.0;
//        _tableCell=[[HotCell alloc]initShowDropDown:sender :&f :_dataArr :YES];
//        _tableCell.delegate=self;
//    }
//    else
//    {
//        [_tableCell hideDropDown:sender];
//        [self niDropDownDelegateMethod:_tableCell ID:nil];
//    }
//    
//}

-(void)niDropDownDelegateMethod:(HotCell *)sender ID:(NSString *)ID
{

    _tableCell=nil;

    if([ID isEqual:@"0"])
    {
        programField.text=sender.btn.titleLabel.text;
        [_btnSelect setTitle:@"点击选择" forState:UIControlStateNormal];
     
    }
    else if ([ID isEqual:@"1"])
    {
        programField.text=sender.btn.titleLabel.text;
  [_btnSelect setTitle:@"点击选择" forState:UIControlStateNormal];
    } else if ([ID isEqual:@"2"])
    {
        programField.text=sender.btn.titleLabel.text;
     [_btnSelect setTitle:@"点击选择" forState:UIControlStateNormal];
    }
    else if ([ID isEqual:@"3"])
    {
        programField.text=sender.btn.titleLabel.text;
[_btnSelect setTitle:@"点击选择" forState:UIControlStateNormal];
    }
  //  NSLog(@"",)
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
       
        idc=@"1";
        [_tableCell hideDropDown:_btnSelect];
     
    }
    else if (self.segment.selectedSegmentIndex == 1)
    {
        self.type = BookingType2;
        idc=@"2";
          [_tableCell hideDropDown:_btnSelect];
   
    }
    else if (self.segment.selectedSegmentIndex == 2)
    {
        self.type = BookingType3;
        idc=@"3";
          [_tableCell hideDropDown:_btnSelect];
    
    }
}

#pragma mark -
#pragma mark - 提交预约
- (void)requestForSubmit
{
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
    NSDictionary *parameters = @{@"userid":user.uid,@"state":@"0",@"custodian":@"好医生",@"moble":mobileField.text,@"subscribeTime":dateField.text,@"bodys":programField.text,@"bewrite":illTextView.text,@"type":[NSString stringWithFormat:@"%ld",self.type]};
    
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
    User *user = [User sharedUser];
    NSDictionary *parameters = @{@"uuserid":user.uid,@"ustate":@"0",@"ucustodian":@"好医生",@"umoble":mobileField.text,@"uSubscribeTime":dateField.text,@"ubodys":programField.text,@"ubewrite":illTextView.text,@"usubscribeid":[self.dictionary objectForKey:@"subscribeid"],@"utype":[NSString stringWithFormat:@"%ld",self.type]};
    
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
       // programField.text=  _tableCell.btn.titleLabel.text;
  
        return cell;
    }
    else if(indexPath.section == 2)
    {
   
        BookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingCell2"];
        cell.nameLabel.text = @"预约日期";
        if (self.modify) {
            if (![[self.dictionary objectForKey:@"subscribeTime"] isEqualToString:@""]) {
                cell.contentLabel.text = [ZZTool convertToTime:[self.dictionary objectForKey:@"subscribeTime"]];
                
            }
        }
     
        
        dateField = cell.contentLabel;

        return cell;
    }else if(indexPath.section == 3)
    {
       
      //  _ChoiceBtn.hidden=YES;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==3)
    {
        _btnSelect.hidden=YES;
    }
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
