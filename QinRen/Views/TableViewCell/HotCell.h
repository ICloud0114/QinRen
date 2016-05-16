//
//  HotCell.h
//  shiwei
//
//  Created by yunxuan on 15/4/1.
//  Copyright (c) 2015年 ludy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  HotCell;

@protocol NIDropDownDelegate

- (void) niDropDownDelegateMethod:(HotCell *) sender ID:(NSString *)ID;

@end


@interface HotCell : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic, retain) id<NIDropDownDelegate> delegate;

-(void)hideDropDown:(UIButton *)b;

-(id)initShowDropDown:(UIButton *)b :(CGFloat *)height :(NSArray *)arr :(BOOL)isSave;

@end
