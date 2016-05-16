//
//  PriaseModel.h
//  QinRen
//
//  Created by Easaa on 15/4/21.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PriaseModel : NSObject
@property (nonatomic, copy) NSString *Icon;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *time;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
