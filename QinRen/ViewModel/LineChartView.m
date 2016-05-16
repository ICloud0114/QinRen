//
//  LineChartView.m
//  DrawDemo
//
//  Created by 东子 Adam on 12-5-31.
//  Copyright (c) 2012年 热频科技. All rights reserved.
//

#import "LineChartView.h"

@interface LineChartView()
{
    CALayer *linesLayer;
    
    
    UIView *popView;
    UILabel *disLabel;
}

@end

@implementation LineChartView

@synthesize array;

@synthesize hInterval,vInterval;

@synthesize hDesc,vDesc;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        hInterval = 100;
        vInterval = 50;
        
        linesLayer = [[CALayer alloc] init];
        linesLayer.masksToBounds = YES;
        linesLayer.contentsGravity = kCAGravityLeft;
        linesLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        
        [self.layer addSublayer:linesLayer];
     //  [UIScreen mainScreen].bounds.size.height>568?800:568)
        
        //PopView
//        popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        popView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        [popView setBackgroundColor:[UIColor whiteColor]];
        [popView setAlpha:0.0f];
        
        disLabel = [[UILabel alloc]initWithFrame:popView.frame];
        [disLabel setTextAlignment:UITextAlignmentCenter];
        
        [popView addSubview:disLabel];
        [self addSubview:popView];
    }
    return self;
}

#define ZeroPoint CGPointMake(30,460)

- (void)drawRect:(CGRect)rect
{
    [self setClearsContextBeforeDrawing: YES];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画背景线条------------------
    CGColorRef backColorRef = [UIColor blackColor].CGColor;
    CGFloat backLineWidth = 2.f;
    CGFloat backMiterLimit = 0.f;
    
    CGContextSetLineWidth(context, backLineWidth);//主线宽度
    CGContextSetMiterLimit(context, backMiterLimit);//投影角度  
    
  //  CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 8, backColorRef);//设置双条线
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineCap(context, kCGLineCapRound );
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    

    
//    int x = 320 ;
//    int y = 460 ;
    int x = [UIScreen mainScreen].bounds.size.width ;
    int y = [UIScreen mainScreen].bounds.size.height ;


    for (int i=0; i<vDesc.count; i++) {
        
        CGPoint bPoint = CGPointMake(30, y);
        CGPoint ePoint = CGPointMake(x, y);
        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, 30, 30)];
         UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 30, 30)];
        [label setCenter:CGPointMake(bPoint.x-15, bPoint.y-135)];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        label.font=[UIFont systemFontOfSize:13];
        [label setText:[vDesc objectAtIndex:i]];
        [self addSubview:label];
//        CGContextMoveToPoint(context, bPoint.x, bPoint.y-30);
//        CGContextAddLineToPoint(context, ePoint.x, ePoint.y-30);
        CGContextMoveToPoint(context, bPoint.x, bPoint.y-138);
         CGContextAddLineToPoint(context, ePoint.x, ePoint.y-138);
//        CGContextMoveToPoint(context, bPoint.x, bPoint.y-[UIScreen mainScreen].bounds.size.height>568?138:138);
//        CGContextAddLineToPoint(context, ePoint.x, ePoint.y-[UIScreen mainScreen].bounds.size.height>568?138:138);
        
    // y -= 55;
        y -= [UIScreen mainScreen].bounds.size.height>568?52:40;
        
        
    }
   // [UIScreen mainScreen].bounds.size.height>568?800:568)
    //for (int i=0; i<array.count-1; i++)
    for (int i=0; i<array.count-1; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i*vInterval+30, [UIScreen mainScreen].bounds.size.height>568?620:430 , 40, 30)];
       
        [label setTextAlignment:UITextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        label.numberOfLines = 1;
        label.adjustsFontSizeToFitWidth = YES;
        label.minimumFontSize = 1.0f;
        label.font=[UIFont systemFontOfSize:10];
        [label setText:[hDesc objectAtIndex:i]];
        
        [self addSubview:label];
    }
    
    
//    //画点线条------------------
    CGColorRef pointColorRef = [UIColor colorWithRed:24.0f/255.0f green:116.0f/255.0f blue:205.0f/255.0f alpha:1.0].CGColor;
    CGFloat pointLineWidth = 1.5f;
    CGFloat pointMiterLimit = 5.0f;
    
    CGContextSetLineWidth(context, pointLineWidth);//主线宽度
    CGContextSetMiterLimit(context, pointMiterLimit);//投影角度  
    
    
  //  CGContextSetShadowWithColor(context, CGSizeMake(3, 5), 8, pointColorRef);//设置双条线
    
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextSetLineCap(context, kCGLineCapRound );
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);

	//绘图
	CGPoint p1 = [[array objectAtIndex:0] CGPointValue];
	int i = 1;
	CGContextMoveToPoint(context, p1.x+30, 430-p1.y);
	for (; i<[array count]; i++)
	{
		p1 = [[array objectAtIndex:i] CGPointValue];
        CGPoint goPoint = CGPointMake(p1.x, 430-p1.y*vInterval/20);
		CGContextAddLineToPoint(context, goPoint.x, goPoint.y);;
        
        //添加触摸点
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [bt setBackgroundColor:[UIColor redColor]];
        
//        [bt setFrame:CGRectMake(0, 0, 10, 10)];
         [bt setFrame:CGRectMake([UIScreen mainScreen].bounds.origin.x, [UIScreen mainScreen].bounds.origin.y, 10, 10)];
        
        [bt setCenter:goPoint];
        
        [bt addTarget:self 
               action:@selector(btAction:) 
     forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:bt];
	}
	CGContextStrokePath(context);
    
}

- (void)btAction:(id)sender{
    [disLabel setText:@"100"];
    
    UIButton *bt = (UIButton*)sender;
    popView.center = CGPointMake(bt.center.x, bt.center.y - popView.frame.size.height/2);
    [popView setAlpha:1.0f];
}

@end
