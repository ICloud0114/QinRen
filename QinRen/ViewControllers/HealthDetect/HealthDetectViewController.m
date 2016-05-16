//
//  HealthDetectViewController.m
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "HealthDetectViewController.h"

#import "FatCell.h"
#import "MJRefresh.h"
#import "AddDetectViewController.h"
#import "User.h"
#import "SportCell.h"
#import "PicController.h"
#import "LineChartView.h"
#import "CBChartView.h"




@interface HealthDetectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageIndex;
    BOOL check;
    NSMutableDictionary *pageDictionary;
   
}
@property(nonatomic, strong) NSMutableArray *dataArray01;//
@property(nonatomic, strong) NSMutableArray *dataArray02;//
@property(nonatomic, strong) NSMutableArray *fatArray;//
@property(nonatomic, strong) NSMutableArray *dataArray03;//
@property(nonatomic, strong) NSMutableArray *dataArray04;//
@property (nonatomic,strong)NSMutableArray *HeartDetectArr;
@property (nonatomic,strong)NSMutableArray *sumArr;

@property(nonatomic) AddType type;

@end

@implementation HealthDetectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
    
    
    [self.segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    //
    [self.tableView reloadData];
    [self.tableview1 reloadData];
    self.type = AddType1;
    pageDictionary = [NSMutableDictionary dictionary];

    
    self.dataArray01 = [NSMutableArray array];
    self.dataArray02 = [NSMutableArray array];
    self.fatArray = [NSMutableArray array];
    self.dataArray03 = [NSMutableArray array];
    self.dataArray04 = [NSMutableArray array];
    self.HeartDetectArr=[NSMutableArray array];
    self.sumArr=[NSMutableArray array];
    
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",(long)AddType1]];
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",(long)AddType2]];
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",(long)AddType3]];
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",(long)AddType4]];
    

    
    //
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableview1.tableFooterView = [[UIView alloc]init];

        [self.tableView addHeaderWithTarget:self action:@selector(requestForFat)];

//
    _tableView.hidden=NO;
    _tableview1.hidden=YES;
    [self.tableView headerBeginRefreshing];
     [self.tableview1 headerBeginRefreshing];
    
  //  [self.tableview1 addHeaderWithTarget:self action:@selector(requestForXindian)];
    [self requestForXindian];
  //  [self.tableview1 addHeaderWithTarget:self action:@selector(requestForXindian)];
}
//心电监测的数据请求
-(void)requestForXindian
{
  
    pageIndex = 1;
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *codeno;
    switch (self.type) {
        case AddType1:
            codeno = @"10001";
            break;
        case AddType2:
            codeno = @"10002";
            
            break;
        case AddType3:
            codeno = @"10003";
            
            break;
        case AddType4:
            codeno = @"10004";
            
            break;
        default:
            break;
    }
    User *user = [User sharedUser];
    
    NSDictionary *parameters = @{@"customer_id":@"DR2014071610009"};
    
    [manager GetWithParameters:parameters method:@"get.monitor.ecg.manage" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]])
        {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }
        else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [self.tableview1 reloadData];
            }else
            {
                
                if ([[dictionary objectForKey:@"data"]count] >= 10)
                {
                    pageIndex ++;
                    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:pageIndex] forKey:[NSString stringWithFormat:@"%ld",self.type]];
                    
                    // [self.tableView addFooterWithTarget:self action:@selector(footRequestForFat)];
                }
                
                [_HeartDetectArr addObjectsFromArray:[dictionary objectForKey:@"data"]];
    
//                for(int i=0;i<_HeartDetectArr.count;i++)
//                {
//                    NSDictionary *cell=nil;
//                    NSArray *arr=[cell objectsForKeys:@[@"ect_st",@"ecg_arrhythmia",@"ecg_waveform",@"ecg_heart",@"ecg_wholewave"@"ecg_wholewave"] notFoundMarker:[NSNull null]];
//                    [_sumArr addObject:arr];
//                }
                
                
                [self.tableview1 reloadData];
            }
            
            [self.tableview1 headerEndRefreshing];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.tableview1 headerEndRefreshing];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.tableview1 headerEndRefreshing];
        
    }];
}
#pragma mark -
#pragma mark - Action
- (IBAction)addDetect:(id)sender
{
    [self performSegueWithIdentifier:@"AddDetect" sender:self];
}


#pragma mark -
#pragma mark - 网络请求
- (void)requestForFat
{
    pageIndex = 1;
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *codeno;
    switch (self.type) {
        case AddType1:
            codeno = @"10001";
            break;
        case AddType2:
            codeno = @"10002";
            
            break;
        case AddType3:
            codeno = @"10003";
            
            break;
        case AddType4:
            codeno = @"10004";
            
            break;
        default:
            break;
    }
    User *user = [User sharedUser];
    
    NSDictionary *parameters = @{@"MemberId":user.uid,@"codeno":codeno,@"pagesize":@"10",@"pageindex":[NSString stringWithFormat:@"%ld",(long)pageIndex],@"posttime":@"",@"endtime":@""};
    
    [manager GetWithParameters:parameters method:@"get.testingresult.info" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]])
        {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }
        else
            resposeString = responseObject;
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        NSLog(@"dictonary :%@",[dictionary description]);
        
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            if ([[dictionary objectForKey:@"total"]intValue] <= 0)
            {
                [self.tableView reloadData];
            }else
            {
                //
                switch (self.type) {
                    case 0:
                        [self.dataArray01 removeAllObjects];
                        break;
                    case 1:
                        [self.dataArray02 removeAllObjects];
                        break;
                    case 2:
                        [self.HeartDetectArr removeAllObjects];
                        break;
                    case 3:
                        [self.dataArray04 removeAllObjects];
                        break;
                    default:
                        break;
                }
                
                if ([[dictionary objectForKey:@"data"]count] >= 10)
                {
                    pageIndex ++;
                    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:pageIndex] forKey:[NSString stringWithFormat:@"%ld",self.type]];
                    
                   // [self.tableView addFooterWithTarget:self action:@selector(footRequestForFat)];
                }
                [self dealFatDataSource:[dictionary objectForKey:@"data"]];
                switch (self.type)
                {
                    case AddType1:
                        [self.fatArray setArray:self.dataArray01];
                        break;
                    case AddType2:
                        [self.fatArray setArray:self.dataArray02];
                        
                        break;
                    case AddType3:
                       [self.fatArray setArray:self.HeartDetectArr];
                        
                        
                        break;
                    case AddType4:
                        [self.fatArray setArray:self.dataArray04];
                        
                        break;
                    default:
                        break;
                }
                
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
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.tableView headerEndRefreshing];
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self requestForFat];
}
- (void)footRequestForFat
{
    
    for (NSString *number in pageDictionary.allKeys) {
        if ([number integerValue] == self.type)
        {
            pageIndex = [[pageDictionary objectForKey:number]intValue];
        }
    }
    
    NSString *codeno;
    switch (self.type) {
        case AddType1:
            codeno = @"10001";
            break;
        case AddType2:
            codeno = @"10002";
            
            break;
        case AddType3:
            codeno = @"10003";
            
            break;
        case AddType4:
            codeno = @"10004";
            
            break;
        default:
            break;
    }
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    User *user = [User sharedUser];
    
    NSDictionary *parameters = @{@"MemberId":user.uid,@"codeno":codeno,@"pagesize":@"10",@"pageindex":[NSString stringWithFormat:@"%ld",(long)pageIndex],@"posttime":@"",@"endtime":@""};
    
    [manager GetWithParameters:parameters method:@"get.testingresult.info" success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
                [self.tableView reloadData];
            }
            else
            {
                //
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:pageIndex] forKey:[NSString stringWithFormat:@"%ld",self.type]];
                    
                }
                else
                {
                    [self.tableView removeFooter];
                }
                [self dealFatDataSource:[dictionary objectForKey:@"data"]];
                
                switch (self.type) {
                    case AddType1:
                        [self.fatArray setArray:self.dataArray01];
                        break;
                    case AddType2:
                        [self.fatArray setArray:self.dataArray02];
                        
                        break;
                    case AddType3:
                        [self.fatArray setArray:self.dataArray03];
                        
                        break;
                    case AddType4:
                        [self.fatArray setArray:self.dataArray04];
                        
                        break;
                    default:
                        break;
                }
                
                
                [self.tableView reloadData];
            }
            
            [self.tableView footerEndRefreshing];
            
        }else
        {
            NSString *error = [dictionary objectForKey:@"error"];
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            
            [self.tableView footerEndRefreshing];
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        
        [self.tableView footerEndRefreshing];
        
    }];
}


- (void)dealFatDataSource:(NSArray *)array
{
    
    for (int i = 0; i < 1; i ++)
    {
        NSDictionary *dictionary = [array objectAtIndex:i];
        NSString *time = [dictionary objectForKey:@"dateTime"];
        
        
        
        if (self.type == AddType4)
        {
            
            [self.dataArray04 addObjectsFromArray:array];
        }
        else
        {
            for (int j = 0; j < [[dictionary objectForKey:@"attribute"]count]; j ++)
            {
                NSDictionary *attributeDict = [[dictionary objectForKey:@"attribute"] objectAtIndex:j];
                NSMutableDictionary *addDict = [NSMutableDictionary dictionary];
                [addDict addEntriesFromDictionary:attributeDict];
                [addDict setObject:time forKey:@"dateTime"];
                
                switch (self.type) {
                    case AddType1:
                        [self.dataArray01 addObject:addDict];
                        break;
                    case AddType2:
                        [self.dataArray02 addObject:addDict];
                        
                        break;
                

                    default:
                        break;
                }
                
            }
        }
        
        

    }
}

#pragma mark -
#pragma mark - TableDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.fatArray.count != 0)
    {
        return self.fatArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView==_tableview1)
    {
        return 5;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_segment.selectedSegmentIndex==3)
    {
        SportCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SportCell"];
        if(self.dataArray04!=nil)
        {
     
            NSMutableArray *arr=[[NSMutableArray alloc]init];
          
//                if(self.dataArray04.count==3)
//                {
//                    
                    [arr addObjectsFromArray:self.dataArray04];
//
            
                    NSDictionary *attributeDict = [arr objectAtIndex:indexPath.section];
                    
                    // NSString *name = [attributeDict objectForKey:@"dateTime"];
                    
                    //  NSDictionary *dataArray = [attributeDict objectForKey:@"attribute"];
                    //     NSArray *arr=dataArray[0];
                    NSArray *dataArray = [attributeDict objectForKey:@"attribute"];
                    
                    NSDictionary *dic=[dataArray objectAtIndex:2];
                    NSString *name=dic[@"vlues"];
                    NSString *unit=dic[@"unit"];
                    
                    cell.SpideLabel.text =[NSString stringWithFormat:@"总耗能:%@/%@",name,unit];
                    
                    NSDictionary *dic1=[dataArray objectAtIndex:0];
                    NSString *name1=dic1[@"vlues"];
                    NSString *unit1=dic1[@"unit"];
                    cell.AllTimeLabel.text = [NSString stringWithFormat:@"总时间:%@/%@",name1,unit1];
                    
                    NSDictionary *dic2=[dataArray objectAtIndex:1];
                    NSString *name2=dic2[@"vlues"];
                    NSString *unit2=dic2[@"unit"];
                    cell.PaobuLabel.text = [NSString stringWithFormat:@"总步数:%@/%@",name2,unit2];
                    
                    
                    NSString *time = [attributeDict objectForKey:@"dateTime"];
                    //            
                    cell.TimeLabel.text = [ZZTool convertToTimeWithSecond:time];
                    
                    return cell;
           //    }
          

            
            
            
        }
    }else
    {
        
        FatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FatCell"];
        if(self.fatArray!=nil)
        {

              NSMutableArray *arr=[[NSMutableArray alloc]init];
            if (self.segment.selectedSegmentIndex == 0)
            {
              if(self.fatArray.count==9)
              {

                [arr addObjectsFromArray:self.fatArray];
                
                  NSDictionary *attributeDict = [arr objectAtIndex:indexPath.section];
  
                      NSString *name = [attributeDict objectForKey:@"name"];
                      NSString *upperLimit = [attributeDict objectForKey:@"upperLimit"];
                      NSString *lowerLimit = [attributeDict objectForKey:@"lowerLimit"];
                      
                      NSString *unit = [attributeDict objectForKey:@"unit"];
                      NSString *vlues=[NSString stringWithFormat:@"%@",attributeDict[@"vlues"]];
                      // NSString *vlues = [attributeDict objectForKey:@"vlues"];
                      
                      NSString *time = [attributeDict objectForKey:@"dateTime"];
                      
                      if([lowerLimit intValue] <= [vlues intValue] && [vlues intValue] <= [upperLimit intValue])
                      {
                          cell.StatusImageview.image=[UIImage imageNamed:@"lvdeng_39.jpg"];
                      }
                      else
                      {
                          cell.StatusImageview.image=[UIImage imageNamed:@"hongdeng_33.jpg"];
                      }
                      
                      cell.nameLabel.text = name;
                      cell.refrenceLabel.text = [NSString stringWithFormat:@"%2@-%@%@",lowerLimit,upperLimit,unit];
                      cell.dateLabel.text = [ZZTool convertToTimeWithSecond:time];
                      cell.valueLabel.text = [NSString stringWithFormat:@"%@%@",vlues,unit];
                      return cell;

              }
            }
            else if (self.segment.selectedSegmentIndex == 1)
            {
               
                if(self.fatArray.count==4)
                {
                    [arr removeAllObjects];
                    
                    [arr addObjectsFromArray:self.fatArray];
                    
                    NSDictionary *attributeDict = [arr objectAtIndex:indexPath.section];
             
                   
                    NSString *name = [attributeDict objectForKey:@"name"];
                    NSString *upperLimit = [attributeDict objectForKey:@"upperLimit"];

                    CGFloat flat = [attributeDict[@"lowerLimit"] floatValue];
                    NSString *lowerLimit = [NSString stringWithFormat:@"%0.2f",flat];
     
                    
                    NSString *unit = [attributeDict objectForKey:@"unit"];
                    NSString *vlues = [attributeDict objectForKey:@"vlues"];
                    
                    NSString *time = [attributeDict objectForKey:@"dateTime"];
                   if([lowerLimit intValue] <= [vlues intValue] && [vlues intValue] <= [upperLimit intValue])
                    {
                        cell.StatusImageview.image=[UIImage imageNamed:@"lvdeng_39.jpg"];
                    }
                    else
                    {
                        cell.StatusImageview.image=[UIImage imageNamed:@"hongdeng_33.jpg"];
                    }
                    cell.nameLabel.text = name;
                    cell.refrenceLabel.text = [NSString stringWithFormat:@"%@-%@%@",lowerLimit,upperLimit,unit];
                    cell.dateLabel.text = [ZZTool convertToTimeWithSecond:time];
                    cell.valueLabel.text = [NSString stringWithFormat:@"%@%@",vlues,unit];
                    return cell;
                    
                }
            }
            else if (self.segment.selectedSegmentIndex == 2)
            {
                if(self.fatArray.count==1)
                {
                    [arr removeAllObjects];
                    
                    [arr addObjectsFromArray:self.fatArray];
                   
                    for(int i=0;i<arr.count;i++)
                    {
                        NSDictionary *cell=arr[i];
                        NSArray *arr=[cell objectsForKeys:@[@"ecg_heart",@"ecg_arrhythmia",@"ect_st",@"ecg_waveform",@"ecg_wholewave",@"ecg_wholewave"] notFoundMarker:[NSNull null]];
                        [_sumArr addObjectsFromArray:arr];
                    }
                    NSMutableArray *sumarr=[[NSMutableArray alloc]init];
                    for(int i=0;i<arr.count;i++)
                    {
                        NSDictionary *cell=arr[i];
                        NSArray *arr1=[cell objectsForKeys:@[@"input_time"] notFoundMarker:[NSNull null]];
                        [sumarr addObjectsFromArray:arr1];
                    }

                    NSArray *arr=@[@"心率",@"心律",@"ST段",@"整体波长",@"波形质量"];
                    cell.valueLabel.text = _sumArr[indexPath.row];
                    cell.nameLabel.text=arr[indexPath.row];
                    cell.dateLabel.text=sumarr[indexPath.section];
                    if([cell.valueLabel.text isEqualToString:@"心率正常"]||[cell.valueLabel.text isEqualToString:@"ST段正常"]||[cell.valueLabel.text isEqualToString:@"波形质量正常"]||[cell.valueLabel.text isEqualToString:@"没有发现心律失常"]||[cell.valueLabel.text isEqualToString:@"整体波形正常"])
                    {
                        cell.StatusImageview.image=[UIImage imageNamed:@"lvdeng_39.jpg"];
                    }
                    else
                    {
                        cell.StatusImageview.image=[UIImage imageNamed:@"hongdeng_33.jpg"];
                    }
                    return cell;
              
                    
                }
            }
         

        }
    }
    return nil;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_segment.selectedSegmentIndex==0)
    {
    PicController *picvc=[[PicController alloc]initWithNibName:@"PicController" bundle:nil];
    
     NSDictionary *attributeDict = [self.fatArray objectAtIndex:indexPath.section];
    NSString *alias = [attributeDict objectForKey:@"alias"];
    picvc.alias=alias;
    [self.navigationController pushViewController:picvc animated:YES];
  
    }
    else if(_segment.selectedSegmentIndex==1)
    {
        PicController *picvc=[[PicController alloc]initWithNibName:@"PicController" bundle:nil];
        
        NSDictionary *attributeDict = [self.fatArray objectAtIndex:indexPath.section];
        NSString *alias = [attributeDict objectForKey:@"alias"];
        picvc.alias=alias;
        [self.navigationController pushViewController:picvc animated:YES];
        
    }
//   else if(_segment.selectedSegmentIndex==2)
//    {
//        if(indexPath.row==0||indexPath.row==1)
//        {
//            PicController *picvc=[[PicController alloc]initWithNibName:@"PicController" bundle:nil];
//
//            [self.navigationController pushViewController:picvc animated:YES];
//        }
//        else
//        {
//
//        PicViewController *picvc=[[PicViewController alloc]init];
//
//        [self.navigationController pushViewController:picvc animated:YES];
//        }
//        
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"AddDetect"])
    {
        AddDetectViewController *controller = segue.destinationViewController;
        if (!check) {
            controller.type = self.segment.selectedSegmentIndex;
            controller.ifCheck = YES;
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            
            //
//            switch (self.segment.selectedSegmentIndex) {
//                case 0:
//                    controller.checkDictionary = [self dictionaryForFatCheck:indexPath];
//                    break;
//                case 1:
//                    controller.checkDictionary = [self dictionaryForFatCheck:indexPath];
//                    break;
                    //                case 2:
                    //                    controller.checkDictionary = [self dictionaryForFatCheck:indexPath];
                    //                    break;
                    //                case 3:
                    //                    controller.checkDictionary = [self dictionaryForFatCheck:indexPath];
                    //                    break;
                    
                    
//                default:
//                    break;
//            }
        }
        
    }
    
}


//- (NSDictionary *)dictionaryForFatCheck:(NSIndexPath *)indexPath
//{
//    NSUInteger index = indexPath.section / 4;
//    NSUInteger yushuIndex = indexPath.section % 4;
//    NSDictionary *dict1 = [self.fatArray objectAtIndex:index * 4];
//    
//    NSDictionary *dict2 = [self.fatArray objectAtIndex:index * 4 + 1];
//    NSDictionary *dict3 = [self.fatArray objectAtIndex:index * 4 + 2];
//    NSDictionary *dict4 = [self.fatArray objectAtIndex:index * 4 + 3];
//    
//    return @{@"fat":@[dict1,dict2,dict3,dict4]};
//    
//    //    return 0;
//}

-(void)segmentAction:(UISegmentedControl *)Seg{
    
    if (self.segment.selectedSegmentIndex == 0)
    {
        _tableView.hidden=NO;
        _tableview1.hidden=YES;
        self.type = AddType1;
        if (self.dataArray01.count <= 0)
        {
            [self.fatArray removeAllObjects];
            [self.tableView headerBeginRefreshing];
        }
        else
        {
               [self.fatArray removeAllObjects];
            [self.fatArray setArray:self.dataArray01];

            
            [self.tableView reloadData];
        }
    }
    else if (self.segment.selectedSegmentIndex == 1)
    {
        _tableView.hidden=NO;
        _tableview1.hidden=YES;

        self.type = AddType2;
        if (self.dataArray02.count <= 0)
        {
            [self.fatArray removeAllObjects];
            [self.tableView headerBeginRefreshing];
        }
        else
        {
            [self.fatArray removeAllObjects];
            
            [self.fatArray setArray:self.dataArray02];
  
            [self.tableView reloadData];

        }
    }
    else if (self.segment.selectedSegmentIndex == 2)
    {
        _tableView.hidden=YES;
        _tableview1.hidden=NO;
      //  [self.tableview1 addHeaderWithTarget:self action:@selector(requestForXindian)];
      
        self.type = AddType3;
        if (self.HeartDetectArr.count <= 0)
        {
            [self.fatArray removeAllObjects];
            //[self.tableview1 headerBeginRefreshing];
        }
        else
        {
              [self.tableview1 headerBeginRefreshing];
            
            [self.fatArray removeAllObjects];
            [self.fatArray setArray:self.HeartDetectArr];
            [self.tableview1 reloadData];

        }
    }
    else if (self.segment.selectedSegmentIndex == 3)
    {
        _tableView.hidden=NO;
        _tableview1.hidden=YES;

        self.type = AddType4;
        if (self.dataArray04.count <= 0)
        {
            [self.fatArray removeAllObjects];
            [self.tableView headerBeginRefreshing];
        }
        else
        {
               [self.fatArray removeAllObjects];
            [self.fatArray setArray:self.dataArray04];
      
            [self.tableView reloadData];
        
        }
    }
    
    
    
}
- (IBAction)SpideSumBtn:(id)sender {
    //[self requestForPic];
    PicController *pic=[[PicController alloc]init];
    NSDictionary *dic=[_dataArray04 objectAtIndex:0];
    NSArray *attribute=dic[@"attribute"];
    NSDictionary *dic1=[attribute objectAtIndex:0];
    NSString *alias=dic1[@"alias"];
    pic.alias=alias;
    DLog(@"pic.alias1===%@",pic.alias);
    [self.navigationController pushViewController:pic animated:YES];
    
}

- (IBAction)paobuSumBtn:(id)sender {
    
    PicController *pic=[[PicController alloc]init];
    NSDictionary *dic=[_dataArray04 objectAtIndex:0];
    NSArray *attribute=dic[@"attribute"];
    NSDictionary *dic1=[attribute objectAtIndex:1];
    NSString *alias=dic1[@"alias"];
    pic.alias=alias;
    DLog(@"pic.alias2===%@",pic.alias);
    [self.navigationController pushViewController:pic animated:YES];
}

- (IBAction)TotalSumBtn:(id)sender {
    PicController *pic=[[PicController alloc]init];
    NSDictionary *dic=[_dataArray04 objectAtIndex:0];
    NSArray *attribute=dic[@"attribute"];
    NSDictionary *dic1=[attribute objectAtIndex:2];
    NSString *alias=dic1[@"alias"];
    pic.alias=alias;
    [self.navigationController pushViewController:pic animated:YES];
}


@end
