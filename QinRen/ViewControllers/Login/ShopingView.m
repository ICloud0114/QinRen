//
//  ShopingView.m
//  QinRen
//
//  Created by Loly mac on 15-4-5.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "ShopingView.h"


@implementation ShopingView

- (IBAction)TotalPriceBtn:(id)sender {
    
    if([_delegate respondsToSelector:@selector(TakeintoAnotherUI)])
    {
        [self.delegate TakeintoAnotherUI];
    }
    
}



@end
