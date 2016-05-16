//
//  SloppySwiper.h
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  `SloppySwiper` is a class conforming to `UINavigationControllerDelegate` protocol that allows pan back gesture to be started from anywhere on the screen (not only from the left edge).
 */
@interface SloppySwiper : NSObject <UINavigationControllerDelegate>

/// Gesture recognizer used to recognize swiping to the right.
@property (weak, readonly, nonatomic) UIPanGestureRecognizer *panRecognizer;

/// Designated initializer if the class isn't used from the Interface Builder.
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController;

@end