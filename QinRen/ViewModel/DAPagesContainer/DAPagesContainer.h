//
//  DAPageContainerScrollView.h
//  DAPagesContainerScrollView
//
//  Created by Daria Kopaliani on 5/29/13.
//  Copyright (c) 2013 Daria Kopaliani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAPagesContainerTopBar.h"
#import "DAPageIndicatorView.h"
@class DAPagesContainer;

@protocol DAPagesContainerDelegate <NSObject>
- (void)itemChangeFrom:(NSUInteger)oldIndex To:(NSUInteger)newIndex DAPagesContainer:(DAPagesContainer *)container;
@end


@interface DAPagesContainer : UIViewController

@property (strong, nonatomic) NSArray *viewControllers;
@property (assign, nonatomic) NSUInteger selectedIndex;

@property (assign, nonatomic) NSUInteger topBarHeight;
@property (strong, nonatomic) UIColor *pageIndicatorColor;
@property (assign, nonatomic) CGSize pageIndicatorViewSize;
@property (strong, nonatomic) UIColor *topBarBackgroundColor;
@property (strong, nonatomic) UIFont *topBarItemLabelsFont;
@property (strong, nonatomic) UIColor *pageItemsTitleColor;
@property (strong, nonatomic) UIColor *selectedPageItemColor;

@property (strong, nonatomic) UIColor *topBarItemsTitleColor;
@property (strong, nonatomic) UIColor *topBarItemsSelectedTitleColor;

@property (nonatomic, weak) id<DAPagesContainerDelegate> delegate;

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;
- (void)updateLayoutForNewOrientation:(UIInterfaceOrientation)orientation;

@end