//
//  MyHeader.h
//  QinRen
//
//  Created by Easaa on 15/4/16.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kHeaderHeight 44
@class MyHeader;

@protocol MyHeaderDelegate <NSObject>

-(void)myHeaderDidSelectedHeader:(MyHeader *)header;

@end

@interface MyHeader : UITableViewHeaderFooterView

//设置代理
@property (nonatomic,strong)id<MyHeaderDelegate>delegate;

@property (nonatomic,strong)UIButton *BiaotiBtn;

//标题栏分组
@property(nonatomic,assign)NSInteger sections;

@property (nonatomic,assign)BOOL isOpen;


@end
