//
//  HotCell.m
//  shiwei
//
//  Created by yunxuan on 15/4/1.
//  Copyright (c) 2015年 ludy. All rights reserved.
//---------------------------------------------------
//        继承于UIVIew 用于点击下拉列表效果
//----------------------------------------------------

#import "HotCell.h"

@interface HotCell()

@property (nonatomic, strong) UITableView *table;

@property (nonatomic, retain) NSArray *list;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, readwrite) BOOL isSave;

@end


@implementation HotCell

-(void)hideDropDown:(UIButton *)b
{
    CGRect btn = b.frame;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.frame = CGRectMake(btn.origin.x, btn.origin.y + btn.size.height, btn.size.width, 0);
   
    _table.frame = CGRectMake(0, 0, btn.size.width, 0);
    _table.backgroundColor = [UIColor clearColor];
    _table.tableFooterView=[[UIView alloc]init];
    [UIView commitAnimations];
}

- (id)initShowDropDown:(UIButton *)b :(CGFloat *)height :(NSArray *)arr :(BOOL)isSave
{
    self.isSave = isSave;
    self.btn = b;
    self = [super init];
    if (self) {
        CGRect btn = b.frame;
        self.frame = CGRectMake(btn.origin.x, btn.origin.y + btn.size.height, btn.size.width, 0);
      //  self.backgroundColor = [UIColor yellowColor];
        self.list = [NSArray arrayWithArray:arr];
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 8;
        self.layer.shadowOffset = CGSizeMake(-5, 5);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, btn.size.width, 0)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.layer.cornerRadius = 5;
      //  _table.backgroundColor = [UIColor colorWithRed:0.239 green:0.239 blue:0.239 alpha:1];
        _table.backgroundColor=[UIColor clearColor];
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.separatorColor = [UIColor grayColor];
        _table.showsVerticalScrollIndicator = NO;
        _table.tableFooterView=[[UIView alloc]init];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        self.frame = CGRectMake(btn.origin.x, btn.origin.y + btn.size.height, btn.size.width, *height);
        _table.frame = CGRectMake(0, 0, btn.size.width, *height);
        [UIView commitAnimations];
        
        [b.superview addSubview:self];
        [self addSubview:_table];
        
        //解决cell分割线左边部分缺少一些问题1
        if ([self.table respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.table setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.table respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.table setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;
}

#pragma mark - 解决cell分割线左边部分缺少一些问题2
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - UITableViewDataSource  UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    id value = [_list objectAtIndex:indexPath.row];
    if ([value isKindOfClass: [NSString class]]) {
        cell.textLabel.text = value;
    }else
    {   //下拉列表的值
        cell.textLabel.text =[value objectForKey:@"name"];
    }
    cell.textLabel.textColor = [UIColor blackColor];
    UIView * v = [[UIView alloc] init];
    v.backgroundColor = [UIColor grayColor];
    cell.selectedBackgroundView = v;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self hideDropDown:self.btn];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (self.isSave) {
        NSDictionary *dict = self.list[indexPath.row];
        
        if ([dict isKindOfClass: [NSString class]])
        {
            NSInteger x = indexPath.row;
            self.ID = [NSString stringWithFormat:@"%ld",(long)x];
        }else{
            self.ID =  [dict objectForKey:@"id"];
            
            
            
        }
       // _btn.text=cell.textLabel.text;
 [self.btn setTitle:cell.textLabel.text forState:UIControlStateNormal];
        [self.delegate niDropDownDelegateMethod:self ID:self.ID];
    }else{
       // _btn.text=cell.textLabel.text;
        [self.btn setTitle:cell.textLabel.text forState:UIControlStateNormal];
        [self.delegate niDropDownDelegateMethod:self ID:nil];
    }
}






@end
