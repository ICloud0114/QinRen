//
//  SSWDirectionalPanGestureRecognizer.h
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, SSWPanDirection) {
    SSWPanDirectionRight,
    SSWPanDirectionDown,
    SSWPanDirectionLeft,
    SSWPanDirectionUp
};

/**
 *  `SSWDirectionalPanGestureRecognizer` is a subclass of `UIPanGestureRecognizer`. It adds `direction` property and checks if the pan gesture started in the correct direction; it fails otherwise.
 */
@interface SSWDirectionalPanGestureRecognizer : UIPanGestureRecognizer

@property (nonatomic) SSWPanDirection direction;

@end