//
//  GoodCell.m
//  QinRen
//
//  Created by Easaa on 15/4/3.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "GoodCell.h"

@interface GoodCell()
{
    UITableView *_myTableView;//表
    UIScrollView *_myScrollView;//顶部图片
    UILabel *_nameLab;//名字
    UILabel *_currentPriceLab;//现价
    UILabel *_priceLab;//价格
    UILabel *_discountLab;//折扣
    UILabel *_saleCount;//销量
    UIImageView *_currentPageView;//页码显示器
        UIView *_view;//表头
        NSArray *_scrArr;//图片数组
    UIImageView *_line1;
    UIImageView *_line2;
    UIImageView *_line3;
    NSArray*_userHeaderArr;//用户头像
    int _num;//计数
    UILabel *_brand1;
    UILabel *_brand2;
    int _type;//类型计数
    
    NSMutableArray *_type0Arr;//商品细节
    NSMutableArray *_type1Arr;//商品参数
    NSMutableArray *_type2Arr;//买家评论

}

@end
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
#define FENCOLOR [UIColor colorWithRed:220/255.0 green:84/255.0 blue:124/255.0 alpha:1]
@implementation GoodCell

- (void)awakeFromNib {
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _type0Arr = [[NSMutableArray alloc]init];
        _type1Arr = [[NSMutableArray alloc]init];
        _type2Arr = [[NSMutableArray alloc]init];
       // _picArr = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic=dataDic;
    
}
@end
