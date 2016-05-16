//
//  XGLModelClass.h
//  HEBINEWS
//
//  Created by guilin on 15/3/31.
//  Copyright (c) 2015年 LXH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XGLModelClass : NSObject


/**
 *  子类自动调用设置属性方法，关键字可以重写undefineKey
 *
 *  @param attributes <#attributes description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithAttribute:(NSDictionary *)attributes;



@end
