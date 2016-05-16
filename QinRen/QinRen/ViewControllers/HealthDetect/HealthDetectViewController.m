//
//  HealthDetectViewController.m
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "HealthDetectViewController.h"
#import "EAHttpAPIClient.h"
#import "DataParser.h"
#import "JSONKit.h"
#import "SVProgressHUD.h"
#import "FatCell.h"
#import "MJRefresh.h"
#import "AddDetectViewController.h"
#import "User.h"

/*
 {
 "verification": true,
 "total": 1,
 "data": [
 {
 "ResultId": 2,
 "codeno": "10002",
 "SN": "",
 "UserName": "15818738100",
 "identify": "100021",
 "dateTime": "2015-02-10 16:39:18",
 "attribute": [
 {
 "name": "总胆固醇",
 "alias": "zdgc",
 "upperLimit": 6.1,
 "lowerLimit": 3.1,
 "unit": "",
 "vlues": ""
 },
 {
 "name": "高密度脂蛋白胆固醇",
 "alias": "gmdgc",
 "upperLimit": 2.25,
 "lowerLimit": 0.74,
 "unit": "",
 "vlues": ""
 },
 {
 "name": "低密度脂蛋白胆固醇",
 "alias": "dmdzdbgc",
 "upperLimit": 3.6,
 "lowerLimit": 0,
 "unit": "",
 "vlues": ""
 },
 {
 "name": "甘油三酯",
 "alias": "glycerin trimyris",
 "upperLimit": 1.7,
 "lowerLimit": 0.56,
 "unit": "",
 "vlues": ""
 }
 ]
 }
 ],
 "error": null
 }
 */

@interface HealthDetectViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger pageIndex;
    BOOL check;
    NSMutableDictionary *pageDictionary;
}
@property(nonatomic, strong) NSMutableArray *dataArray01;//
@property(nonatomic, strong) NSMutableArray *fatArray;//
@property(nonatomic, strong) NSMutableArray *dataArray03;//
@property(nonatomic, strong) NSMutableArray *dataArray04;//

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
    
    
    //
    self.type = AddType1;
    pageDictionary = [NSMutableDictionary dictionary];
    
    self.dataArray01 = [NSMutableArray array];
    self.fatArray = [NSMutableArray array];
    self.dataArray03 = [NSMutableArray array];
    self.dataArray04 = [NSMutableArray array];

    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",AddType1]];
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",AddType2]];
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",AddType3]];
    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:1] forKey:[NSString stringWithFormat:@"%ld",AddType4]];


    //
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.tableView addHeaderWithTarget:self action:@selector(requestForFat)];
    
    
    [self.tableView headerBeginRefreshing];
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
            }else
            {
                //
                switch (self.type) {
                    case 0:
                        [self.dataArray01 removeAllObjects];
                        break;
                    case 1:
                        [self.fatArray removeAllObjects];
                        break;
                    case 2:
                        [self.dataArray03 removeAllObjects];
                        break;
                    case 3:
                        [self.dataArray04 removeAllObjects];
                        break;
                    default:
                        break;
                }
                
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:pageIndex] forKey:[NSString stringWithFormat:@"%ld",self.type]];

                    [self.tableView addFooterWithTarget:self action:@selector(footRequestForFat)];
                }
                [self dealFatDataSource:[dictionary objectForKey:@"data"]];
                
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
            }else
            {
                //
                if ([[dictionary objectForKey:@"data"]count] >= 10) {
                    pageIndex ++;
                    [pageDictionary setObject:[NSNumber numberWithUnsignedLong:pageIndex] forKey:[NSString stringWithFormat:@"%ld",self.type]];

                }else
                {
                    [self.tableView removeFooter];
                }
                [self dealFatDataSource:[dictionary objectForKey:@"data"]];
                
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
    for (int i = 0; i < array.count; i ++)
    {
        NSDictionary *dictionary = [array objectAtIndex:i];
        NSString *time = [dictionary objectForKey:@"dateTime"];
        for (int j = 0; j < [[dictionary objectForKey:@"attribute"]count]; j ++)
        {
            NSDictionary *attributeDict = [[dictionary objectForKey:@"attribute"] objectAtIndex:j];
            NSMutableDictionary *addDict = [NSMutableDictionary dictionary];
            [addDict addEntriesFromDictionary:attributeDict];
            [addDict setObject:time forKey:@"dateTime"];
            [self.fatArray addObject:addDict];
            
        }
    }
}

#pragma mark -
#pragma mark - TableDataSource 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.fatArray) {
        return self.fatArray.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FatCell"];
    
    NSDictionary *attributeDict = [self.fatArray objectAtIndex:indexPath.section];

    NSString *name = [attributeDict objectForKey:@"name"];
    NSString *upperLimit = [attributeDict objectForKey:@"upperLimit"];
    NSString *lowerLimit = [attributeDict objectForKey:@"lowerLimit"];
    NSString *unit = [attributeDict objectForKey:@"unit"];
    NSString *vlues = [attributeDict objectForKey:@"vlues"];
    NSString *alias = [attributeDict objectForKey:@"alias"];
    NSString *time = [attributeDict objectForKey:@"dateTime"];

    cell.nameLabel.text = name;
    cell.refrenceLabel.text = [NSString stringWithFormat:@"%@-%@%@",lowerLimit,upperLimit,unit];
    cell.dateLabel.text = [Until convertToTimeWithSecond:time];
    cell.valueLabel.text = [NSString stringWithFormat:@"%@%@",vlues,unit];
    
    return cell;
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    check = YES;
    if(self.segment.selectedSegmentIndex == 1)
        [self performSegueWithIdentifier:@"AddDetect" sender:self];
    
    check = NO;
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
//                   controller.checkDictionary = [self dictionaryForFatCheck:indexPath];
//                    break;
//                case 1:
//                    controller.checkDictionary = [self dictionaryForFatCheck:indexPath];
//                    break;
//            
//                    
//                default:
//                    break;
//            }
        }
        
    }
    
}


- (NSDictionary *)dictionaryForFatCheck:(NSIndexPath *)indexPath
{
    NSUInteger index = indexPath.section / 4;
    NSUInteger yushuIndex = indexPath.section % 4;
    NSDictionary *dict1 = [self.fatArray objectAtIndex:index * 4];
    NSDictionary *dict2 = [self.fatArray objectAtIndex:index * 4 + 1];
    NSDictionary *dict3 = [self.fatArray objectAtIndex:index * 4 + 2];
    NSDictionary *dict4 = [self.fatArray objectAtIndex:index * 4 + 3];
 
    return @{@"fat":@[dict1,dict2,dict3,dict4]};
}


@end
