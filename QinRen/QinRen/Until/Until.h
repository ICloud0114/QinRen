//
//  Until.h
//  QinRen
//
//  Created by Donny on 15/3/16.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Until : NSObject

+ (NSString *)convertToTime:(NSString *)addTime;
+ (NSString *)convertToTimeWithSecond:(NSString *)addTime;
+ (NSString *)convertToUTCTime:(NSString *)addTime;

@end
