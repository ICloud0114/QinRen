//
//  CycleScrollView.m
//  PagedScrollView
//
//  Created by 陈政 on 14-1-23.
//  Copyright (c) 2014年 Apple Inc. All rights reserved.
//

#import "CycleScrollView.h"
#import "NSTimer+Addition.h"
#import "ZZPageControl.h"
#import "UIImageView+WebCache.h"
#import "UIViewAdditions.h"

@interface CycleScrollView () <UIScrollViewDelegate>
{
    UILabel *titleLabel;
    ZZPageControl *pageControl;
}
@property (nonatomic , assign) NSInteger currentPageIndex;
@property (nonatomic , assign) NSInteger totalPageCount;
@property (nonatomic , strong) NSMutableArray *contentViews;
@property (nonatomic , strong) UIScrollView *scrollView;

@property (nonatomic , strong) NSMutableArray *viewsArray;

@property (nonatomic , strong) NSTimer *animationTimer;
@property (nonatomic , assign) NSTimeInterval animationDuration;


@property (nonatomic) NSInteger totalPagesCount;

@end

@implementation CycleScrollView



- (void)setDataSource:(NSArray *)dataSource
{
    _dataSource = dataSource;
    
    if (dataSource == nil || dataSource.count == 0) {
        return;
    }
    if (_viewsArray) {
        [_viewsArray removeAllObjects];
    }else
        _viewsArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < dataSource.count; i ++)
    {
        NSDictionary *dictionary = [dataSource objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        if (![[dictionary objectForKey:@"picture"]isEqual:[NSNull null]])
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"picture"]]];
        }
         [_viewsArray addObject:imageView];
    }
    
    if (dataSource.count == 2)
    {
        NSDictionary *dictionary = [dataSource objectAtIndex:0];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        if (![[dictionary objectForKey:@"picture"]isEqual:[NSNull null]])
        {
            [imageView sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"picture"]]];
        }
        [_viewsArray addObject:imageView];
    }
    
    _totalPageCount = dataSource.count;
    
    if (_totalPageCount > 0) {
        pageControl.numberOfPages = dataSource.count;
        
        if (_totalPageCount >= 2)
        {
            self.scrollView.contentSize = CGSizeMake(3 * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
            self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame), 0);
        }else
        {
            self.scrollView.contentSize = CGSizeMake(_totalPageCount * CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
            self.scrollView.contentOffset = CGPointMake(0, 0);

        }
        self.scrollView.delegate = self;
        pageControl.hidden = NO;
        [self configContentViews];
        
        if (_totalPageCount == 1)
        {
            [self.animationTimer pauseTimer];
        }else
        {
            [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
        }
    }
    
}

- (id)initWithFrame:(CGRect)frame animationDuration:(NSTimeInterval)animationDuration
{
    self = [self initWithFrame:frame];
    if (animationDuration > 0.0) {
        
        self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:(self.animationDuration = animationDuration)
                                                               target:self
                                                             selector:@selector(animationTimerDidFired:)
                                                             userInfo:nil
                                                              repeats:YES];
        [self.animationTimer pauseTimer];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizesSubviews = YES;
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        UIImage *placeHolderImage = [UIImage imageNamed:@"pic_jieshao"];
        UIImageView *backgroundView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 216, 104)];
        backgroundView.image = placeHolderImage;
        [self addSubview:backgroundView];
        backgroundView.center = CGPointMake(self.width/2.0f, self.height/2.0f);
        
        self.scrollView.autoresizingMask = 0xFF;
        self.scrollView.contentMode = UIViewContentModeCenter;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        self.currentPageIndex = 0;
        
        pageControl = [[ZZPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        pageControl.backgroundColor = [UIColor clearColor];
        pageControl.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
        pageControl.hidden = YES;
        [pageControl setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [self addSubview:pageControl];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 20, self.bounds.size.width, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont fontWithName:@"Arial" size:15];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithRed:185/255.0 green:135/255.0 blue:133/255.0 alpha:1];
        [self addSubview:titleLabel];
    }
    return self;
}

#pragma mark -
#pragma mark - 私有函数

- (void)configContentViews
{
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger counter = 0;
    for (UIView *contentView in self.contentViews) {
        contentView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewTapAction:)];
        [contentView addGestureRecognizer:tapGesture];
        CGRect rightRect = contentView.frame;
        
        rightRect.origin = CGPointMake(CGRectGetWidth(self.scrollView.frame) * (counter ++), 0);
        
        contentView.frame = rightRect;
        [self.scrollView addSubview:contentView];
    }
    if (_totalPageCount >= 3)
    {
        [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
    }else
    {
        if (_totalPageCount == 2)
        {
            [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width, 0)];
        }else
        {
            [_scrollView setContentOffset:CGPointMake(0, 0)];
        }
    }
}

/**
 *  设置scrollView的content数据源，即contentViews
 */
- (void)setScrollViewContentDataSource
{
    NSInteger previousPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
    NSInteger rearPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
    if (self.contentViews == nil) {
        self.contentViews = [@[] mutableCopy];
    }
    [self.contentViews removeAllObjects];
    
    if (_totalPageCount >= 3)
    {
        [self.contentViews addObject:[_viewsArray objectAtIndex:previousPageIndex]];
        [self.contentViews addObject:[_viewsArray objectAtIndex:_currentPageIndex]];
        [self.contentViews addObject:[_viewsArray objectAtIndex:rearPageIndex]];
    }else
    {
        if (_totalPageCount == 2)
        {
            [self.contentViews addObject:[_viewsArray objectAtIndex:previousPageIndex]];
            [self.contentViews addObject:[_viewsArray objectAtIndex:_currentPageIndex]];
            [self.contentViews addObject:[_viewsArray objectAtIndex:previousPageIndex]];

        }else
        {
            [self.contentViews addObject:[_viewsArray objectAtIndex:_currentPageIndex]];
        }
    }
    
    
    NSDictionary *dictionary = [self.dataSource objectAtIndex:_currentPageIndex];
    if (![[dictionary objectForKey:@"title"]isEqual:[NSNull null]])
    {
        titleLabel.text = [dictionary objectForKey:@"title"];
    }
    pageControl.currentPage = _currentPageIndex;
}

- (NSInteger)getValidNextPageIndexWithPageIndex:(NSInteger)currentPageIndex;
{
    if(currentPageIndex == -1) {
        return self.totalPageCount - 1;
    } else if (currentPageIndex == self.totalPageCount) {
        return 0;
    } else {
        return currentPageIndex;
    }
}

#pragma mark -
#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.animationTimer pauseTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int contentOffsetX = scrollView.contentOffset.x;
    if(contentOffsetX >= (2 * CGRectGetWidth(scrollView.frame))) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex + 1];
        NSLog(@"next，当前页:%ld",(long)self.currentPageIndex);
        [self configContentViews];
    }
    if(contentOffsetX <= 0) {
        self.currentPageIndex = [self getValidNextPageIndexWithPageIndex:self.currentPageIndex - 1];
        NSLog(@"previous，当前页:%ld",(long)self.currentPageIndex);
        [self configContentViews];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(scrollView.frame), 0) animated:YES];
}

#pragma mark -
#pragma mark - 响应事件

- (void)animationTimerDidFired:(NSTimer *)timer
{
    if (_dataSource.count > 1)
    {
        CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x + CGRectGetWidth(self.scrollView.frame), self.scrollView.contentOffset.y);
        [self.scrollView setContentOffset:newOffset animated:YES];
    }
   
}

- (void)contentViewTapAction:(UITapGestureRecognizer *)tap
{
    if (self.TapActionBlock) {
        self.TapActionBlock(self.currentPageIndex);
    }
    
    if ([self.vDelegate respondsToSelector:@selector(cycleScrollView:didTapAtIndex:url:)]) {
        NSDictionary *dictionary = [_dataSource objectAtIndex:self.currentPageIndex];

        [self.vDelegate cycleScrollView:self didTapAtIndex:self.currentPageIndex url:[dictionary objectForKey:@"url"]];
    }
}

- (void)pauseTimer
{
    [self.animationTimer pauseTimer];
}

- (void)resumeTimer
{
    [self.animationTimer resumeTimerAfterTimeInterval:self.animationDuration];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
