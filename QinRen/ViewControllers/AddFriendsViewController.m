//
//  AddFriendsViewController.m
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "Masonry.h"
#import "MyHeader.h"
#import "ContactController.h"

@interface AddFriendsViewController ()< UITableViewDataSource , UITableViewDelegate >

{
    
    
    UITableView *_tableVIew;
    
    
    NSMutableArray *_DataArray;
    
    UIScrollView *_scroller;
    
}


@end

@implementation AddFriendsViewController

-(void)refreshBtn
{
    ContactController *contactVc=[[ContactController alloc]init];
    [self.navigationController pushViewController:contactVc animated:YES];
}


#define  DIC_EXPANDED @ "expanded" //是否是展开 0收缩 1展开

#define  DIC_ARARRY @ "array"

#define  DIC_TITILESTRING @ "title"

#define  CELL_HEIGHT 50.0f



//初始化数据

- ( void )initDataSource

{
    
    //创建一个数组
    
    _DataArray =[[ NSMutableArray alloc ] init ];
    
    
    for ( int i= 0 ;i<= 5 ; i++) {
        
        NSMutableArray *array=[[ NSMutableArray alloc ] init ];
        
        for ( int j= 0 ; j<= 5 ;j++) {
            
            NSString *string=[ NSString stringWithFormat : @"%i组-%i行" ,i,j];
            
            [array addObject :string];
            
        }
        
        
        NSString *string=[ NSString stringWithFormat : @"第%i分组" ,i];
        
        
        //创建一个字典 包含数组，分组名，是否展开的标示
        
        NSMutableDictionary *dic=[[ NSMutableDictionary alloc ] initWithObjectsAndKeys :array, DIC_ARARRY ,string, DIC_TITILESTRING ,[ NSNumber numberWithInt : 0 ], DIC_EXPANDED , nil ];
        
        
        
        //将字典加入数组
        
        [ _DataArray addObject :dic];
        
    }
    
}

//初始化表

- ( void )initTableView

{
    
    _scroller=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 130, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:_scroller];
    _tableVIew =[[ UITableView alloc ] initWithFrame :CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style : UITableViewStylePlain ];

    
    _tableVIew . dataSource = self ;
    
    _tableVIew . delegate = self ;
    
    [_scroller addSubview : _tableVIew ];
    _tableVIew.tableFooterView=[[UIView alloc]init];
    
}

- ( void )viewDidLoad

{
    
    [ super viewDidLoad ];
    
    [ self initDataSource ];
    
    [self creatUi];
    [ self initTableView ];
    
}
-(void)creatUi
{
    
    // UIView *view0=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    UIView *view0=[[UIView alloc]init];
    // view.alpha=0.2;
    view0.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:view0];
    
    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).with.offset(0);
        //距离左边是0
        make.left.equalTo(self.view.mas_left).with.offset(0);
        //距离右边是0
        make.right.equalTo(self.view.mas_right).with.offset(0);
        
        make.height.equalTo(@50);
        
    }];
    
    //    UITextField *textfield=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 35)];
    UITextField *textfield=[[UITextField alloc]init];
    textfield.placeholder=@"账号/名称/病史";
    
    textfield.borderStyle=UITextBorderStyleRoundedRect;
    [view0 addSubview:textfield];
    
    [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view0.mas_top).with.offset(10);
        //距离左边是0
        make.left.equalTo(view0.mas_left).with.offset(10);
        //距离右边是0
        make.right.equalTo(view0.mas_right).with.offset(-10);
        
        make.height.equalTo(@35);
        make.width.equalTo(@10);
        
    }];
    
    UIView *view1=[[UIView alloc]init];
    //  view1.backgroundColor=[UIColor redColor];
    [self.view addSubview:view1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view .mas_top).with.offset(50);
        //距离左边是0
        make.left.equalTo(self.view .mas_left).with.offset(0);
        //距离右边是0
        make.right.equalTo(self.view .mas_right).with.offset(0);
        
        make.height.equalTo(@70);
        
        
    }];
    UIButton *btn=[UIButton buttonWithType: UIButtonTypeCustom];
    btn.frame=CGRectMake(40, 50, 70, 30) ;
    [btn setTitle:@"通讯录" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(refreshBtn) forControlEvents:UIControlEventTouchUpInside];
    //   btn.backgroundColor=[UIColor yellowColor];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view1 addSubview:btn];
    
    UIButton *btn1=[UIButton buttonWithType: UIButtonTypeCustom];
    btn1.frame=CGRectMake(40, 50, 70, 30) ;
    [btn1 setTitle:@"朋友圈" forState:UIControlStateNormal];
    btn1.titleLabel.font=[UIFont systemFontOfSize:13];
    //   btn1.backgroundColor=[UIColor yellowColor];
    
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view1 addSubview:btn1];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1 .mas_top).with.offset(0);
        
        make.left.equalTo(view1 .mas_left).with.offset(10);
        
        make.right.equalTo(btn1 .mas_left).with.offset(-50);
        make.height.equalTo(@70);
        
    }];
    
    
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view1 .mas_top).with.offset(0);
        
        make.left.equalTo(btn .mas_right).with.offset(50);
        
        make.right.equalTo(view1 .mas_right).with.offset(-10);
        make.width.equalTo(btn.mas_width);
        make.height.equalTo(btn.mas_height);
        
    }];
    
    UIView *view3=[[UIView alloc]init];
    view3.frame=CGRectMake(0, 120, 320,2);
    view3.backgroundColor=[UIColor lightGrayColor];
    view3.alpha=0.3f;
    [self.view addSubview:view3];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view .mas_top).with.offset(120);
        //距离左边是0
        make.left.equalTo(self.view .mas_left).with.offset(0);
        //距离右边是0
        make.right.equalTo(self.view .mas_right).with.offset(0);
        
        make.height.equalTo(@1);
        make.width.equalTo(@320);
        
        
    }];
    
}

#pragma mark -- UITableViewDataSource,UITableViewDelegate

- ( NSInteger )numberOfSectionsInTableView:( UITableView *)tableView

{
    
    return _DataArray . count ;
    
}

- ( NSInteger )tableView:( UITableView *)tableView numberOfRowsInSection:( NSInteger )section

{
    
    NSMutableDictionary *dic=[ _DataArray objectAtIndex :section];
    
    NSArray *array=[dic objectForKey : DIC_ARARRY ];
    
    
    //判断是收缩还是展开
    
    if ([[dic objectForKey : DIC_EXPANDED ] intValue ]) {
        
        return array. count ;
        
    } else
        
    {
        
        return 0 ;
        
    }
    
}

- ( UITableViewCell *)tableView:( UITableView *)tableView cellForRowAtIndexPath:( NSIndexPath *)indexPath

{
    
    static NSString *acell= @"cell" ;
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier :acell];
    
    if (!cell) {
        
        cell=[[ UITableViewCell alloc ] initWithStyle : UITableViewCellStyleDefault reuseIdentifier :acell];
        
    }
    
    
    NSArray *array=[[ _DataArray objectAtIndex :indexPath. section ]  objectForKey : DIC_ARARRY ];
    
    cell. textLabel . text =[array objectAtIndex :indexPath. row ];
    
    
    return cell;
    
}

//设置分组头的视图

- ( UIView *)tableView:( UITableView *)tableView viewForHeaderInSection:( NSInteger )section

{
    
    UIView *hView = [[ UIView alloc ] initWithFrame : CGRectMake ( 0 , 0 , [UIScreen mainScreen].bounds.size.width , CELL_HEIGHT )];
    
    hView. backgroundColor =[ UIColor whiteColor ];
    
    UIButton * eButton = [[ UIButton alloc ] init ];
    
    //按钮填充整个视图
    
    eButton. frame = hView. frame ;
    
    [eButton addTarget : self action : @selector (expandButtonClicked:)
     
      forControlEvents : UIControlEventTouchUpInside ];
    
    
    //把节号保存到按钮tag，以便传递到expandButtonClicked方法
    
    eButton. tag = section;
    
    
    //设置图标
    
    //根据是否展开，切换按钮显示图片
    
    if ([ self isExpanded :section])
        
        [eButton setImage : [ UIImage imageNamed : @"anniu_xia(1)" ] forState : UIControlStateNormal ];
    
    else
        
        [eButton setImage : [ UIImage imageNamed : @"anniu_you(1)" ] forState : UIControlStateNormal ];
    
    //设置分组标题
    
    [eButton setTitle :[[ _DataArray objectAtIndex :section]  objectForKey : DIC_TITILESTRING ] forState : UIControlStateNormal ];
    
    [eButton setTitleColor :[ UIColor blackColor ] forState : UIControlStateNormal ];
    
    
    //设置button的图片和标题的相对位置
    
    //4个参数是到上边界，左边界，下边界，右边界的距离
    
    eButton. contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft  ;
    
//    [eButton setTitleEdgeInsets : UIEdgeInsetsMake ( 5 , 5 , 0 , 0 )];
    [eButton setTitleEdgeInsets : UIEdgeInsetsMake ( 0 , 0 , 0 , 0 )];
    
    [eButton setImageEdgeInsets : UIEdgeInsetsMake ( 5 , 5 , 5 , 0 )];
//
    
    //上显示线
    
    UILabel *label1=[[ UILabel alloc ] initWithFrame : CGRectMake ( 0 , - 1 , hView. frame . size . width , 1 )];
    
    label1. backgroundColor =[ UIColor lightGrayColor ];
    label1.alpha=0.5f;
    [hView addSubview :label1];
    
    
    //下显示线
    
    UILabel *label=[[ UILabel alloc ] initWithFrame : CGRectMake ( 0 , hView. frame . size . height - 1 , hView. frame . size . width , 1 )];
    
    label. backgroundColor =[ UIColor lightGrayColor ];
    label.alpha=0.5f;
    [hView addSubview :label];
    
    
    [hView addSubview : eButton];
    
    return hView;
    
    
}

//单元行内容递进

- ( NSInteger )tableView:( UITableView *)tableView indentationLevelForRowAtIndexPath:( NSIndexPath *)indexPath

{
    
    return 2 ;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//控制表头分组表头高度

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section

{
    
    return CELL_HEIGHT ;
    
}

#pragma mark -- 内部调用

//对指定的节进行“展开/折叠”操作,若原来是折叠的则展开，若原来是展开的则折叠

-( void )collapseOrExpand:( int )section{
    
    NSMutableDictionary *dic=[ _DataArray objectAtIndex :section];
    
    
    int expanded=[[dic objectForKey : DIC_EXPANDED ] intValue ];
    
    if (expanded) {
        
        [dic setValue :[ NSNumber numberWithInt : 0 ] forKey : DIC_EXPANDED ];
        
    } else
        
    {
        
        [dic setValue :[ NSNumber numberWithInt : 1 ] forKey : DIC_EXPANDED ];
        
    }
    
}

//返回指定节是否是展开的

-( int )isExpanded:( int )section{
    
    NSDictionary *dic=[ _DataArray objectAtIndex :section];
    
    int expanded=[[dic objectForKey : DIC_EXPANDED ] intValue ];
    
    return expanded;
    
}

//按钮被点击时触发

-( void )expandButtonClicked:( id )sender{
    
    
    UIButton * btn= ( UIButton *)sender;
    
    int section= btn. tag ; //取得tag知道点击对应哪个块
    
    
    [ self collapseOrExpand :section];
    
    
    //刷新tableview
    
    [ _tableVIew reloadData ];
    
    
}
@end
