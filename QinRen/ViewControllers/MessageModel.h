//
//  MessageModel.h
//  QinRen
//
//  Created by Easaa on 15/4/17.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

//消息模型
#import <Foundation/Foundation.h>

typedef enum {

    MessageTypeMe=0 ,//自己发的
    MessageTypeOther=1//别人发的
    
}MessageType;

@interface MessageModel : NSObject

@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,assign)MessageType type;

@property (nonatomic,copy)NSDictionary *dict;


@end
