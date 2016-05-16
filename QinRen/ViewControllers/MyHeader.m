//
//  MyHeader.m
//  QinRen
//
//  Created by Easaa on 15/4/16.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "MyHeader.h"

@implementation MyHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setFrame:CGRectMake(0, 0, 320, kHeaderHeight)];
        [self setTintColor:[UIColor orangeColor]];
        
        // 增加按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        NSLog(@"实例化标题行 %@", NSStringFromCGRect(self.bounds));
        
        [button setFrame:self.bounds];
        
        // 设置按钮的图片
        UIImage *image = [UIImage imageNamed:@"disclosure.png"];
        [button setImage:image forState:UIControlStateNormal];
        
        // 设置按钮内容的显示位置
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        
        // 给按钮添加监听事件
        [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:button];
        
        self.BiaotiBtn = button;

    }
    return self;
}
- (void)clickButton
{
    // 通知代理执行协议方法
    [self.delegate myHeaderDidSelectedHeader:self];
}

-(void)setIsOpen:(BOOL)isOpen
{
    _isOpen=isOpen;
    CGFloat angle=isOpen?M_PI_2:0;
    [UIView animateWithDuration:0.5f animations:^{
        
         [self.BiaotiBtn.imageView setTransform:CGAffineTransformMakeRotation(angle)];
    }];
}

@end
