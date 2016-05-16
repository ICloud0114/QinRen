//
//  UIButton+block.h
//  MingXinHui
//
//  Created by easaa on 13-8-7.
//  Copyright (c) 2013年 easaa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)();

@interface UIButton(Block)

@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;


- (void) setImage:(UIImage *)image withHorizontalTitle:(NSString *)title leftTitle:(BOOL)left forState:(UIControlState)stateType ;
- (void) setImage:(UIImage *)image withVerticalTitle:(NSString *)title topTitle:(BOOL)top  forState:(UIControlState)stateType;
@end


@interface UIControl (Block)
@property (readonly) NSMutableDictionary *event;

- (void) handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end