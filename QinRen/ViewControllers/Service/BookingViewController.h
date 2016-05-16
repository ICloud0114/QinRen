//
//  BookingViewController.h
//  QinRen
//
//  Created by Donny2g Hu on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//
/*
 {"verification":true,"total":2,"data":[{"bodys":"32","bewrite":"","subscribeTime":"2015/3/9 16:07:31","addTime":"2015/3/9 16:07:31","custodian":"f2","moble":"313","state":0,"subscribeid":4,"userid":516,"userName":"13576928795","body":"找不到该方案！"},{"bodys":"fe","bewrite":"","subscribeTime":"2015/3/9 15:04:01","addTime":"2015/3/9 15:04:01","custodian":"王府井","moble":"13576928795","state":1,"subscribeid":3,"userid":516,"userName":"13576928795","body":"找不到该方案！"}],"error":null}
 */

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, BookingType) {
    BookingType1          = 1, //疗养预约
    BookingType2    = 2,  //健康管理师预约
    BookingType3    = 3,  //团购预约
};


@class BookingViewController;
@protocol BookingViewControllerDelegate <NSObject>

- (void)bookingViewControllerDidFinishAdd:(BookingViewController *)controller;

@end

@interface BookingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic) BOOL modify;
@property (nonatomic, strong) id<BookingViewControllerDelegate> delegate;

@property (nonatomic) BookingType type;
@end
