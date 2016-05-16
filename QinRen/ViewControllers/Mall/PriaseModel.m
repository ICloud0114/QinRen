//
//  PriaseModel.m
//  QinRen
//
//  Created by Easaa on 15/4/21.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "PriaseModel.h"

@implementation PriaseModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = super.init;
    if (self) {
    self.username = dictionary[@"commtime"];
      self.content = dictionary[@"content"];
////        self.username = dictionary[@"username"];
      self.time = dictionary[@"commtime"];
//        self.imageName = dictionary[@"imageName"];
    }
    return self;
}
@end
