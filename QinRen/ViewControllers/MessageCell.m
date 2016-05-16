//
//  MessageCell.m
//  QinRen
//
//  Created by Easaa on 15/4/17.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MessageCell.h"
#import "MessageModel.h"

@implementation MessageCell
{
    UIButton     *_timeBtn;
    UIImageView *_iconView;
    UIButton    *_contentBtn;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
#warning 必须先设置为clearColor，否则tableView的背景会被遮住
        self.backgroundColor = [UIColor clearColor];
        _timeBtn=[[UIButton alloc]init];
        [_timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _timeBtn.enabled=NO;
        _timeBtn.titleLabel.font=KTimeFont;
          [_timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_timeBtn];
        
        //创建头像
        _iconView=[[UIImageView alloc]init];
        [self.contentView addSubview:_iconView];
        
        //创建内容
        _contentBtn=[[UIButton alloc]init];
        [_contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _contentBtn.titleLabel.font=kContentFont;
        _contentBtn.titleLabel.numberOfLines=0;
        [self.contentView addSubview:_contentBtn];

      
    }
    return self;
}

//懒加载
-(void)setMessageFrame:(MessageFrameModel *)messageFrame
{
    _messageFrame=messageFrame;
    MessageModel *message=_messageFrame.message;
    //设置时间
    
    [_timeBtn setTitle:message.time forState:UIControlStateNormal];
    _timeBtn.frame=_messageFrame.TimeF;
    
    //设置头像
    _iconView.image=[UIImage imageNamed:message.icon];
    _iconView.frame=_messageFrame.IconF;
    
    
    //设置内容
    [_contentBtn setTitle:message.content forState:UIControlStateNormal];
    _contentBtn.contentEdgeInsets=UIEdgeInsetsMake(KContentTop, KContentLeft, KContentBotton, KContentRight) ;
    _contentBtn.frame=_messageFrame.contentF;
    
    
    UIImage *normal , *focused;
    if (message.type == MessageTypeMe) {
        
        normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }else{
        
        normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
        
    }
    [_contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [_contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];

    
}
@end
