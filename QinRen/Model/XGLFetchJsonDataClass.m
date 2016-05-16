//
//  XGLFetchJsonDataClass.m
//  HEBINEWS
//
//  Created by guilin on 15/3/31.
//  Copyright (c) 2015年 LXH. All rights reserved.
//

#import "XGLFetchJsonDataClass.h"

@interface XGLFetchJsonDataClass ()
@property(nonatomic, strong) id data;
@property BOOL fl;


@end

@implementation XGLFetchJsonDataClass


#pragma - mark 解析数据，返回id 数据解析完后的类型，由对象决定返回类型
/**
 *  解析数据
 *
 *  @param endString 如果解析的字为空，直接返回
 *  @param obj       原始数据
 *
 *  @return 返回解析的数据
 */
- (id)parserJsonToArraywithEndString:(NSString *)endString data:(id )obj {
    NSDictionary *dic = obj;
    if (!endString) {
        return dic;
    }
    [self test2dic:dic withEndString:endString];
    return self.data;
}

#pragma - mark 解析数据

- (id)test2dic:(NSDictionary *)dic withEndString:(NSString *)endString {
    if (!self.fl) {
        
        for (id oo in dic.allKeys) {
            //直接取出
            if ([oo isEqualToString:endString]) {
                self.data = dic[oo];
                self.fl = YES;
                break;
            } else {
                //解析元素
                [self test2dicValues:dic withEndString:endString];
            }
        }
    }
    return nil;
}

- (id)test2dicValues:(NSDictionary *)dicValues
       withEndString:(NSString *)endString {
    if (!self.fl) {
        
        
        for (id oo in dicValues.allValues) {
            if ([oo isKindOfClass:[NSDictionary class]]) {
                [self test2dic:oo withEndString:endString];
            } else if ([oo isKindOfClass:[NSArray class]]) {
                [self testArrat:oo endString:endString];
            }
        }
    }
    return nil;
}

- (id)testArrat:(NSArray *)arr endString:(NSString *)endString
{
    if (!self.fl) {
        
        
        for (id obj in  arr) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                [self  test2dic:obj withEndString:endString];
            } else if ([obj isKindOfClass:[NSArray class]]) {
                [self testArrat:obj endString:endString];
            }
        }
    }
    return nil;
}





- (id)mulityElementJustGetFirst:(BOOL)flag parserJsonToArraywithEndString:(NSString *)endString data:(id )obj {
    NSDictionary *dic = obj;
    if (!endString) {
        return dic;
    }
    [self test2dic:dic withEndString:endString];
    return self.data;
}


@end
