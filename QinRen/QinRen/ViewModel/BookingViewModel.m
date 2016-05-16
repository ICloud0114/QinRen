//
//  BookingViewModel.m
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "BookingViewModel.h"

@implementation BookingViewModel

+ (NSString *)statusToString:(BookingStatus)status
{
    switch (status) {
        case BookingStatusProcessing:
            return @"处理中";
            break;
        case BookingStatusSuccess:
            return @"预约成功";
            break;
        case BookingStatusFailed:
            return @"预约失败";
            break;
        case BookingStatusDeleted:
            return @"已取消";
            break;
        default:
            return @"处理中";
            break;
    }
}

+ (NSString *)convertToTime:(NSString *)addTime
{
    addTime = [addTime stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:addTime];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}
@end
