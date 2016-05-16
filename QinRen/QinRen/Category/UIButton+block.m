//
//  UIButton+block.m
//  MingXinHui
//
//  Created by easaa on 13-8-7.
//  Copyright (c) 2013年 easaa. All rights reserved.
//

#import "UIButton+Block.h"

@implementation UIButton(Block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}


//UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
- (void) setImage:(UIImage *)image withHorizontalTitle:(NSString *)title leftTitle:(BOOL)left forState:(UIControlState)stateType
{
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    UIEdgeInsets inset = UIEdgeInsetsMake(0.0, 0.0, 0.0, -titleSize.width);
    if (left) {
        inset = UIEdgeInsetsMake(0.0, -image.size.width * 2 - titleSize.width, 0.0, 0.0);
    }
    [self setTitleEdgeInsets:inset];
    [self setTitle:title forState:stateType];
}


- (void) setImage:(UIImage *)image withVerticalTitle:(NSString *)title topTitle:(BOOL)top  forState:(UIControlState)stateType
{
    [self.imageView setContentMode:UIViewContentModeCenter];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    UIEdgeInsets inset = UIEdgeInsetsMake(0.0, -image.size.width, -(image.size.height + titleSize.height), 0.0);
    if (top) {
        inset = UIEdgeInsetsMake(-(image.size.height + titleSize.height), -image.size.width, 0.0, 0.0);
    }
    [self setTitleEdgeInsets:inset];
    [self setTitle:title forState:stateType];
}

@end


@implementation UIControl (Block)

static char overviewKey;

@dynamic event;

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}


- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &overviewKey);
    if (block) {
        block();
    }
}

@end
