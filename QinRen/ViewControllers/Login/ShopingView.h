//
//  ShopingView.h
//  QinRen
//
//  Created by Loly mac on 15-4-5.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ShopingViewviewdelegate <NSObject>

-(void)TakeintoAnotherUI;

@end

@interface ShopingView : UIView

@property (weak, nonatomic) IBOutlet UILabel *TotalPriceLab;
@property (weak, nonatomic) IBOutlet UIButton *TotalPriceBtn;

@property(weak,nonatomic)id<ShopingViewviewdelegate> delegate;

- (IBAction)TotalPriceBtn:(id)sender;



@end
