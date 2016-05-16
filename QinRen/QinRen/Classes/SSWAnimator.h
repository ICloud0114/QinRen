//
//  SSWAnimator.h
//  QinRen
//
//  Created by Donny on 15/3/9.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>

// Undocumented animation curve used for the navigation controller's transition.
FOUNDATION_EXPORT UIViewAnimationOptions const SSWNavigationTransitionCurve;


@interface SSWAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@end