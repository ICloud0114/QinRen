//
//  AddDetectViewController.h
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AddType) {
    AddType1          = 0, //基本检测
    AddType2    = 1,  //血脂检测
    AddType3    = 2,  //心电监测
    AddType4    = 3,  //运动能耗
    
};

@interface AddDetectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic) AddType type;
@property (nonatomic) BOOL ifCheck;
@property (nonatomic ,strong) NSDictionary *checkDictionary;
@end
