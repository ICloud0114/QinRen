//
//  XGLFetchJsonDataClass.h
//  HEBINEWS
//
//  Created by guilin on 15/3/31.
//  Copyright (c) 2015年 LXH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGLFetchJsonDataClass : NSObject

/**
 *  解析数据
 *
 *  @param endString 解析的结束的key
 *  @param obj       下载的原始数据
 *
 *  @return 返回key对应的values，通常是数组
 */
- (id)parserJsonToArraywithEndString:(NSString *)endString data:(id)obj;
@end
