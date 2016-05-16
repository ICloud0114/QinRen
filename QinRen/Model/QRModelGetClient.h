//
//  QRModelGetClient.h
//  HEBINEWS
//
//  Created by guilin on 15/3/31.
//  Copyright (c) 2015年 LXH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRModelGetClient : NSObject
@property (nonatomic,strong) id data;


+ (void)dataClass:(Class)className parameters:(NSDictionary *)pararmeter methodApi:(NSString *)api attributeEndString:(NSString *)endString paserCompeleteBlock:(void (^)(NSArray *datas, id originData,NSError *error))block;


@end
