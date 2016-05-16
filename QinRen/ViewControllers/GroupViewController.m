//
//  GroupViewController.m
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupCell.h"
#import "ChatingController.h"
#import "ChattingController.h"

@interface GroupViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UITableView *MytableView;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    _dataArr=[[NSMutableArray alloc]init];
    _MytableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    _MytableView.delegate=self;
    _MytableView.dataSource=self;
    _MytableView.tableFooterView=[[UIView alloc]init];
//    _MytableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [_MytableView registerNib:[UINib nibWithNibName:@"GroupCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_MytableView];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString  *ID=@"cell";
    GroupCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[GroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    if(indexPath.section==0)
    {
        cell.HeadImage.image=[UIImage imageNamed:@"zhongguoronge.jpg"];
        cell.NameLab.text=@"健康管家";
    }
    else if(indexPath.section==1)
    {
        cell.HeadImage.image=[UIImage imageNamed:@"zhongguoronge.jpg"];
        cell.NameLab.text=@"健康管理师";
    }
    //cell.AllowImge.image=[UIImage imageNamed:@"jntou you.jpg"];
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChattingController *chatvc=[[ChattingController alloc]init];
    [self.navigationController pushViewController:chatvc animated:YES];
}

@end
