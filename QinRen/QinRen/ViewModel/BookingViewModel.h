//
//  BookingViewModel.h
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BookingStatus) {
    BookingStatusProcessing = 0,
    BookingStatusSuccess,
    BookingStatusFailed,
    BookingStatusDeleted
};


@interface BookingViewModel : NSObject


+ (NSString *)statusToString:(BookingStatus)status;

+ (NSString *)convertToTime:(NSString *)addTime;

@end
