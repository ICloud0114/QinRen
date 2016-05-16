//
//  MessageFrameModel.m
//  QinRen
//
//  Created by Easaa on 15/4/17.
//  Copyright (c) 2015年 Donny. All rights reserved.
//
//聊天距离模型

#import "MessageFrameModel.h"


@implementation MessageFrameModel

-(void)setMessage:(MessageModel *)message
{
    _message=message;
    CGFloat screenW=[UIScreen mainScreen].bounds.size.width;
    //计算时间的位置
    if(_showTime)
    {
        //获取间距
        CGFloat TimeY=Kmargin;
        CGSize timeSize=[_message.time sizeWithFont:KTimeFont];
        
        CGFloat timeX=(screenW-timeSize.width)/2;
        _TimeF = CGRectMake(timeX, TimeY, timeSize.width + KTimeMarginW, timeSize.height + KTimeMarginH);
    }
    //计算头像位置
    CGFloat iconX=Kmargin;
    if(_message.type==MessageTypeMe)
    {
        iconX=screenW-Kmargin-KIconWH;
    }
    CGFloat iconY=CGRectGetMaxY(_TimeF)+Kmargin;
    _IconF=CGRectMake(iconX, iconY, KIconWH, KIconWH);
    
    //计算内容位置
    CGFloat contentX=CGRectGetMaxX(_IconF)+Kmargin;
    CGFloat contentY=iconY;
     CGSize contentSize = [_message.content sizeWithFont:kContentFont constrainedToSize:CGSizeMake(kContentW, CGFLOAT_MAX)];
    
    if(_message.type==MessageTypeMe)
    {
       contentX = iconX - Kmargin - contentSize.width - KContentLeft - KContentRight;
    }
    _contentF = CGRectMake(contentX, contentY, contentSize.width + KContentLeft + KContentRight, contentSize.height + KContentTop + KContentBotton);
    
    // 4、计算高度

    _CellHeight = MAX(CGRectGetMaxY(_contentF), CGRectGetMaxY(_IconF))  + Kmargin;

}

@end
