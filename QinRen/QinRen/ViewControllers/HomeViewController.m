//
//  HomeViewController.m
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "HomeViewController.h"
#import "UIViewAdditions.h"
#import "CycleScrollView.h"
#import "HomeCell.h"
#import "PeopleCell.h"
#import "GoodsCell.h"

#import "EAHttpAPIClient.h"
#import "JSONKit.h"
#import "DataParser.h"
#import "UIButton+block.h"
#import "MallViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic ,strong) CycleScrollView *adsView;
@end


@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //01 广告
    self.adsView = [[CycleScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,100) animationDuration:5.0f];
    self.adsView.backgroundColor = [UIColor grayColor];
    self.tableView.tableHeaderView = self.adsView;
    
    
    
 
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x68C55E);
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                   nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor blackColor], NSForegroundColorAttributeName,
                                                                   nil];
}

#pragma mark - 
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 3;
    }else if(section == 2)
    {
        return 1;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    if (section == 0)
    {
        PeopleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PeopleCell"];
        
        return cell;
    }else if (section == 1)
    {
        HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell"];
        switch (row) {
            case 0:
                cell.iconView1.image = [UIImage imageNamed:@"home_icon_19"];
                cell.nameLabel1.text = @"今日任务";
                cell.iconView2.image = [UIImage imageNamed:@"home_icon_27"];
                cell.nameLable2.text = @"服务预约";
                
                [cell.button1 addTarget:self action:@selector(goToDaily) forControlEvents:UIControlEventTouchUpInside];
                [cell.button2 addTarget:self action:@selector(goToService) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 1:
                cell.iconView1.image = [UIImage imageNamed:@"home_icon_11"];
                cell.nameLabel1.text = @"健康检测";
                cell.iconView2.image = [UIImage imageNamed:@"home_icon_13"];
                cell.nameLable2.text = @"健康资讯";
                [cell.button1 addTarget:self action:@selector(goToHealthDetect) forControlEvents:UIControlEventTouchUpInside];
                [cell.button2 addTarget:self action:@selector(goToHealthNews) forControlEvents:UIControlEventTouchUpInside];

                break;
            case 2:
                cell.iconView1.image = [UIImage imageNamed:@"home_icon_25"];
                cell.nameLabel1.text = @"健康商城";
                cell.iconView2.image = [UIImage imageNamed:@"home_icon_08"];
                cell.nameLable2.text = @"社区团购";
                
                [cell.button1 addTarget:self action:@selector(goToHealthMall) forControlEvents:UIControlEventTouchUpInside];
                break;
            default:
                break;
        }
        return cell;
    }else if (section == 2)
    {
        GoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GoodsCell"];
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0)
    {
        return 105;
    }else if (section == 1)
    {
        return 50;
    }else if (section == 2)
    {
        return 80;
    }
    return 0;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    view.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.width - 20, 35)];
    label.backgroundColor = [UIColor clearColor];
    label.text = @"猜你喜欢";
    label.font = [UIFont systemFontOfSize:17];
    label.textColor = [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1];
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 35;
    }
    return 0;
}

#pragma mark -
#pragma mark - Button Action
- (void)goToHealthMall
{
    [self performSegueWithIdentifier:@"goToShop" sender:self];
}

- (void)goToHealthNews
{
    [self performSegueWithIdentifier:@"goToNews" sender:self];
}


- (void)goToService
{
    [self performSegueWithIdentifier:@"goToService" sender:self];
}

- (void)goToDaily
{
    [self performSegueWithIdentifier:@"goToDaily" sender:self];
}


- (void)goToHealthDetect
{
    [self performSegueWithIdentifier:@"goToHealthDecete" sender:self];
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
