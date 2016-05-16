//
//  MessageFrameModel.h
//  QinRen
//
//  Created by Easaa on 15/4/17.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessageModel.h"

#define Kmargin 10//间距
#define KIconWH 40//头像宽高
#define kContentW 180 //内容宽度
#define KTimeMarginW 15//时间与边框间隔宽度方向
#define KTimeMarginH 10//时间与边框间隔高度方向

#define KContentTop 10//文本与按钮上边缘间隔
#define KContentLeft 25 //文本内容与按钮左边缘间隔
#define KContentBotton 15//文本内容与按钮下边缘间隔
#define KContentRight 15//文本内容与按钮右边边缘间隔

#define KTimeFont [UIFont systemFontOfSize:12] //时间字体
#define kContentFont [UIFont systemFontOfSize:16] //内容字体


@interface MessageFrameModel : NSObject

@property (nonatomic,assign,readonly)CGRect IconF;
@property (nonatomic,assign,readonly)CGRect TimeF;
@property (nonatomic,assign,readonly)CGFloat CellHeight;
@property (nonatomic,assign,readonly)CGRect contentF;
@property (nonatomic,strong)MessageModel *message;
@property (nonatomic,assign)BOOL showTime;


@end
