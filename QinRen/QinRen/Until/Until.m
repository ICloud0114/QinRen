//
//  Until.m
//  QinRen
//
//  Created by Donny on 15/3/16.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "Until.h"

@implementation Until

+ (NSString *)convertToTime:(NSString *)addTime;
{
    addTime = [addTime stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:addTime];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}
+ (NSString *)convertToTimeWithSecond:(NSString *)addTime
{
    addTime = [addTime stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:addTime];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)convertToUTCTime:(NSString *)addTime
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[addTime integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}
@end
