//
//  XGLModelClass.m
//  HEBINEWS
//
//  Created by guilin on 15/3/31.
//  Copyright (c) 2015年 LXH. All rights reserved.
//

#import "XGLModelClass.h"

@implementation XGLModelClass

- (instancetype)initWithAttribute:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:attributes];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
