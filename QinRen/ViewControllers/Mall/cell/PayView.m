//
//  PayView.m
//  车主省钱宝
//
//  Created by chenghao on 15/3/31.
//  Copyright (c) 2015年 ebaochina. All rights reserved.
//

#import "PayView.h"

@implementation PayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)shoucangBtn:(id)sender {
}
- (IBAction)jiarugouwucheBtn:(id)sender {
    
    if([_delegate respondsToSelector:@selector(TakeintoAnotherUI1)])
    {
        [self.delegate TakeintoAnotherUI1];
    }
    
}

- (IBAction)lijijiesuanBtn:(id)sender {
    
    
    if([_delegate respondsToSelector:@selector(TakeintoAnotherUI)])
    {
        [self.delegate TakeintoAnotherUI];
    }
    
}
@end
