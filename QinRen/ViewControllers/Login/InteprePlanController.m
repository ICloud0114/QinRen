//
//  InteprePlanController.m
//  QinRen
//
//  Created by Easaa on 15/4/10.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "InteprePlanController.h"
#import "IntergreCell.h"
#import "MJRefresh.h"
#import "UIViewAdditions.h"

#import "GoodsCell.h"

#import "InteDetailController.h"

@interface InteprePlanController ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)UITableView *MytableView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation InteprePlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor yellowColor];
    _dataArr=[[NSMutableArray alloc]init];
          self.navigationItem.title =@"干预计划";
  //  [_MytableView addHeaderWithTarget:self action:@selector(requestForData)];
  //  [_MytableView headerBeginRefreshing];
    _MytableView=[[UITableView alloc]initWithFrame:self.view.bounds];
    _MytableView.delegate=self;
    _MytableView.dataSource=self;

    _MytableView.tableFooterView=[[UIView alloc]init];
     [_MytableView registerNib:[UINib nibWithNibName:@"IntergreCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_MytableView];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString  *ID=@"cell";
    IntergreCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[IntergreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
       
    }
  
    cell.AllowImge.image=[UIImage imageNamed:@"jntou you.jpg"];
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InteDetailController *indeVC=[[InteDetailController alloc]init];
    [self.navigationController pushViewController:indeVC animated:YES];
    
}
@end
