//
//  ContactController.m
//  QinRen
//
//  Created by Easaa on 15/4/19.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "ContactController.h"
#import "ContactCell.h"
#import "ChineseString.h"



#define SWIDTH                  [[UIScreen mainScreen]bounds].size.width
#define AppColor            [UIColor colorWithRed:27/255.0 green:168/255.0 blue:185/255.0 alpha:1]
#define RGBA(R/*红*/, G/*绿*/, B/*蓝*/, A/*透明*/) \
[UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A]

@interface ContactController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
      UISearchBar *seach;
    
}

@property (nonatomic,strong)UITableView *table;
@property(nonatomic,retain)NSMutableArray *indexArray;
//设置每个section下的cell内容
@property(nonatomic,retain)NSMutableArray *LetterResultArr;
@property(nonatomic,retain)NSArray *stringsToSort;
@property(nonatomic,retain)NSArray *otherstringsToSort;
@property(strong, nonatomic)NSMutableArray * saveSearchArray;
@property(strong, nonatomic)NSMutableArray * saveShowArray;
@property(strong, nonatomic)NSArray * saveCurrentData;
@property(strong, nonatomic)NSMutableArray* saveDeleteData;
@end
static int flagTag = 0;
static NSString * CellIdentifier = @"cell";
@implementation ContactController
@synthesize indexArray;
@synthesize LetterResultArr;
- (void)viewDidLoad
{
    //    self.title = @"我的好友";
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = AppColor;
    
    self.view.backgroundColor = RGBA(242, 247, 250, 1);
//    //创建一个导航栏
//    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 22, 320, 44)];
//    //创建一个导航栏集合
//    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:nil];

//    
//    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(clickRight)];
//    //设置导航栏的内容
//    [navItem setTitle:@"通讯录"];
//    //把导航栏集合添加到导航栏中，设置动画关闭
//    [navBar pushNavigationItem:navItem animated:NO];
//    
//    //把左右两个按钮添加到导航栏集合中去
//    //    [navItem setLeftBarButtonItem:leftButton];
//    [navItem setRightBarButtonItem:right];
//    
//    //将标题栏中的内容全部添加到主视图当中
//    [self.view addSubview:navBar];

#pragma mark -----segmentedControl --设置分段控制器的字体颜色 和设置其他的属性
    
    UIColor *mTint = [[ UIColor alloc]initWithRed:0.66 green:1.0 blue:0.77 alpha:1.0];

    
#pragma mark ---- 进入应用开始加载数据源
    self.saveSearchArray = [[NSMutableArray alloc]init];
    self.saveShowArray = [[NSMutableArray alloc]init];
    
    // 数据源接口
    _stringsToSort=[NSArray arrayWithObjects:
                    @"￥hhh, .$",@"heihei",@" b{[}】【",@"移商网",@"廖利君 ",@"武警",
                    @"中国",@"1",@"2",@"loly",@"miss",
                    @"love",@"2013",@"2012",@"2011",@"2017",@"中国1",@"数据源",
                    @"传统", @"search",@"ios",@"哈哈",
                    nil];
    
    _otherstringsToSort=[NSArray arrayWithObjects:@"新的朋友",nil];
    
    self.indexArray = [ChineseString IndexArray:_stringsToSort];//加载数据源
    
    // 根据联系人的名称来区分
    self.LetterResultArr = [ChineseString LetterSortArray:_stringsToSort];
    CGRect rect=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-44);
    seach=[[UISearchBar alloc] initWithFrame:CGRectMake(0,20, self.view.frame.size.width,44)];
    _table = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _table.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    _table.backgroundColor = [UIColor clearColor];
    _table.delegate = self;
    _table.dataSource = self;
    //    _table.tableHeaderView=seach;
    seach.delegate=self;
    seach.backgroundColor=[UIColor blueColor];
    //    seach.autocorrectionType = UITextAutocorrectionTypeNo;
    seach.autocapitalizationType = UITextAutocapitalizationTypeNone;
    seach.placeholder=@"搜索";
    [self.view addSubview:seach];
    
    [self.view addSubview:_table];
    
    [self.table registerNib:[UINib nibWithNibName:@"ContactCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    
    UIView *va = [[UIView alloc] initWithFrame:CGRectZero];
    [self.table setTableFooterView:va];
    
    
}

//-(void)controlPressed:(id)sender{
//    UISegmentedControl *control = (UISegmentedControl *)sender;
//    }
//-(void)segmentFirst
//{
//    NSLog(@"first");
//    _stringsToSort=[NSArray arrayWithObjects:
//                    @"￥hhh, .$",@"a::; ：；：",@" b{[}】【",@" ￥Chin ese ",@"开源中国 ",@"www.oschina.net",
//                    @"开源技术",@"社区",@"开发者",@"传播",@"2015",@"中国",@"暑假作业",
//                    @"键盘", @"鼠标",@"hello",@"world",
//                    nil];
//    
//    _otherstringsToSort=[NSArray arrayWithObjects:@"新的朋友",nil];
//    self.indexArray = [ChineseString IndexArray:_stringsToSort];//加载数据源
//    
//    // 根据联系人的名称来区分
//    self.LetterResultArr = [ChineseString LetterSortArray:_stringsToSort];
//    
//    
//    [self.table reloadData];
//    
//}
//-(void)segmentSecend
//{
//    NSLog(@"second");
//    // 数据源接口
//    _stringsToSort=[NSArray arrayWithObjects:
//                    @"￥hhh, .$",@"w::; ：；：",@" e{[}】【",@" ￥Chin ese ",@"www.oschina.net",
//                    @"￥hhh, .$",@"t::; ：；：",@" n{[}】【 ",@"2015",@"rwechina",@"fdenet",@"gsfs",
//                    @"hello",@"world",
//                    nil];
//    
//    _otherstringsToSort=[NSArray arrayWithObjects:@"新的朋友",nil];
//    self.indexArray = [ChineseString IndexArray:_stringsToSort];//加载数据源
//    
//    // 根据联系人的名称来区分
//    self.LetterResultArr = [ChineseString LetterSortArray:_stringsToSort];
//    
//    [self.table reloadData];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma mark - tableView
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.0f;
}
#pragma mark -Section的Header的值
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [indexArray objectAtIndex:section];
    
    return key;
}
//#pragma mark - Section header view
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 320, 20.0f)];
//    lab.backgroundColor =[UIColor grayColor];
//    //RGBA(96.86f, 119.97f, 119.97f, 1);
//    lab.text = [indexArray objectAtIndex:section];
//    lab.textColor = [UIColor whiteColor];//改变索引的颜色
//
//
//    //    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 320, 20)];
//    //    bgView.backgroundColor = [UIColor lightGrayColor];
//
//    //    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 320, 20)];
//    //    titleLabel.backgroundColor = [UIColor clearColor];
//    //    titleLabel.textColor = [UIColor blackColor];
//    //    titleLabel.font = [UIFont systemFontOfSize:12];
//
//        NSString *key = [indexArray objectAtIndex:section];
//        if ([key rangeOfString:@"#"].location != NSNotFound) {
////            titleLabel.text = @"热门城市";
//        }
//    //    else
//    //        titleLabel.text = key;
//    //
//    //    [lab addSubview:titleLabel];
//    return lab;
//}
#pragma mark - row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0f;
}

#pragma mark -
#pragma mark Table View Data Source Methods
#pragma mark -设置右方表格的索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return indexArray;
}
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSLog(@"title===%@",title);
    return index;
}

#pragma mark -允许数据源告知必须加载到Table View中的表的Section数。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (flagTag)
    {
        if (self.saveSearchArray.count == 0) {
            return 0;
        }
        return 1;
    }
    return [indexArray count];
}
#pragma mark -设置表格的行数为数组的元素个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (flagTag)
    {
        return self.saveSearchArray.count;
    }
    if (section==0) {
        return self.otherstringsToSort.count;
    }
    return [[self.LetterResultArr objectAtIndex:section] count];
}
#pragma mark -每一行的内容为数组相应索引的值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (flagTag) {
        cell.NameLab.text = [self.saveSearchArray objectAtIndex:indexPath.row];
        cell.HeadView.image=[UIImage imageNamed:@"2.jpg"];
    }else
    {
        if (indexPath.section==0) {
            cell.NameLab.text=[ _otherstringsToSort objectAtIndex:indexPath.row];
             cell.HeadView.image=[UIImage imageNamed:@"2.jpg"];
            return cell;
        }
        cell.NameLab.text = [[self.LetterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
         cell.HeadView.image=[UIImage imageNamed:@"2.jpg"];
    }
    
    return cell;
}
#pragma mark ---searchBarDelegate  搜索栏方法调用
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //获取输入的首字母
    if([searchText isEqualToString:@""])
    {
        flagTag = 0;
        [self.table reloadData];
        return;
    }
    
    [self.saveSearchArray removeAllObjects];
    [self.saveShowArray removeAllObjects];
    flagTag = 1;
    
    //截取第一个文字，判断是否为汉字进行匹配
    if ([searchText substringToIndex:1].length > 0) {
        int utfCode = 0;
        void *buffer = &utfCode;
        NSRange range = NSMakeRange([searchText substringToIndex:1].length - 1, 1);
        NSString *word = [[searchText substringToIndex:1] substringWithRange:range];
        BOOL b = [word getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
        if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5))
        {
            //表示汉字,需要转换成拼音
            //            unichar firstPinYin = pinyinFirstLetter([[searchText substringToIndex:1] characterAtIndex:0]);
            //            saveFirstData = [NSString stringWithFormat:@"%c",firstPinYin];
            
            for (int i = 0; i < _stringsToSort.count;i++)
            {
                if([[_stringsToSort objectAtIndex:i] rangeOfString:searchText].location != NSNotFound)
                {
                    [self.saveSearchArray addObject:[_stringsToSort objectAtIndex:i]];
                }
            }
        }
        else
        {
            if ([indexArray containsObject:[[searchText substringToIndex:1] uppercaseString]])
            {
                NSInteger index = [indexArray indexOfObject:[[searchText substringToIndex:1] uppercaseString]];
                for (int i = 0; i < [[self.LetterResultArr objectAtIndex:index] count]; i++) {
                    //self.LetterResultArr 表示所有的数据此字符的数组
                    [self.saveShowArray addObject:[[self.LetterResultArr objectAtIndex:index]objectAtIndex:i]];
                }
                for (int i = 0; i < self.saveShowArray.count;i++)
                {
                    //将所有的都转换成拼音？？？？？？
                    NSLog(@"把所有的转换成拼音 然后进行匹配");
                    [self.saveSearchArray addObject:[self.saveShowArray objectAtIndex:i]];
                }
            }
            
        }
    }
    [self.table reloadData];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    SeachViewController *search=[[SeachViewController alloc]init];
//    [self.navigationController pushViewController:search animated:YES   ];
    
    return YES;
}

//当滚动的时候需要隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [seach resignFirstResponder];
}

#pragma mark - Select内容为数组相应索引的值  每个cell点击触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [seach resignFirstResponder];
    NSString * str = [[NSString alloc]init];
    if (flagTag) {
        str =  [self.saveSearchArray objectAtIndex:indexPath.row];
    }
    else
    {
        if(indexPath.section == 0)
        {
            str = [_otherstringsToSort objectAtIndex:indexPath.row];
        }else
        {
            str = [[self.LetterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        }
    }
    
    if ([str isEqualToString:@"新的朋友"]) {
        
    }
    
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                    message:str
                                                   delegate:nil
                                          cancelButtonTitle:@"YES" otherButtonTitles:nil];
    [alert show];
}


@end
