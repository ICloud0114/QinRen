//
//  PayView.h
//  车主省钱宝
//
//  Created by chenghao on 15/3/31.
//  Copyright (c) 2015年 ebaochina. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PayViewviewdelegate <NSObject>

-(void)TakeintoAnotherUI;
-(void)TakeintoAnotherUI1;

@end
@interface PayView : UIView
@property(weak,nonatomic)id<PayViewviewdelegate> delegate;

- (IBAction)lijijiesuanBtn:(id)sender;
@end
