//
//  MessageModel.m
//  QinRen
//
//  Created by Easaa on 15/4/17.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel


-(void)setDict:(NSDictionary *)dict
{
    _dict=dict;
    self.icon = dict[@"icon"];
    self.time = dict[@"time"];
    self.content = dict[@"content"];
    self.type = [dict[@"type"] intValue];
}
@end
