//
//  ZZTool.m
//  ZZQuickPrinting
//
//  Created by Lemon on 14-8-4.
//  Copyright (c) 2014年 wangshaosheng. All rights reserved.
//

#import "ZZTool.h"
#import "MBProgressHUD.h"
#import "SDWebImageManager.h"
//#import <POP.h>

@implementation ZZTool

//弹出弹框
+ (void)showAlertViewWithTitle:(NSString*)title  messsage:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil,nil];
    [alert show];
    [self performSelector:@selector(dimissAlert:) withObject:alert afterDelay:1.0];
}
//消失
+ (void)dimissAlert:(UIAlertView *)alert
{
    if(alert)
    {
        [alert dismissWithClickedButtonIndex:[alert cancelButtonIndex] animated:YES];
    }

}
+ (void)showAlert:(NSString*)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
    [alert show];
}
//
//
//+(void)showNote:(UIView *)views
//{
//        CGRect frame = [UIScreen mainScreen].bounds;
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width / 2 - 140 / 2,frame.size.height / 2 - 70 / 2 , 160 , 80)];
//        label.text = @"网络不给力呀";
//        label.clipsToBounds = YES;
//        label.alpha = 0.5;
//        label.numberOfLines = 0;
//        label.layer.cornerRadius = 9;
//        label.textAlignment = NSTextAlignmentCenter;
//        label.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.502 alpha:1.000];
//        label.textColor = [UIColor whiteColor];
//        [views addSubview:label];
//        //    [UIView animateWithDuration:1 animations:^{
//        //        POPSpringAnimation *upAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
//        //        upAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(160, 80)];
//        //        upAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(120, 50)];
//        //        upAnimation.springBounciness = 15;
//        //        upAnimation.springSpeed = 14;
//        //
//        //        [label.layer pop_addAnimation:upAnimation forKey:@"upForRemove"];
//        //    } completion:^(BOOL finished) {
//        //        if (finished) {
//        POPSpringAnimation *upAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
//        upAnimation1.fromValue = [NSValue valueWithCGSize:CGSizeMake(160, 80)];
//        upAnimation1.toValue = [NSValue valueWithCGSize:CGSizeMake(120, 40)];
//        upAnimation1.springBounciness = 15;
//        upAnimation1.springSpeed = 14;
//        [label.layer pop_addAnimation:upAnimation1 forKey:@"upForRemove2"];
//        
//        POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
//        
//        
//        ani.fromValue = @0;
//        ani.toValue = @0.4;
//        [label pop_addAnimation:ani forKey:@"upForRgemo"];
//        label.textAlignment = NSTextAlignmentCenter;
//        
//        
//        
//        [self performSelector:@selector(remos:) withObject:label afterDelay:0.8];
//        
//        //        }
//        //
//        //    }];
//        
//        
//        
//        
//        
//        
//        
//        
//        
//        
//   
//}
//    
//
//+ (void)remos:(UILabel *)label
//    {
//        
//        POPSpringAnimation *upAnimation1 = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
//        upAnimation1.fromValue = [NSValue valueWithCGSize:CGSizeMake(120, 40)];
//        upAnimation1.toValue = [NSValue valueWithCGSize:CGSizeMake(145, 60)];
//        upAnimation1.springBounciness = 15;
//        upAnimation1.springSpeed = 14;
//        [label.layer pop_addAnimation:upAnimation1 forKey:@"upForRemove2"];
//        
//        POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewAlpha];
//        
//        ani.fromValue = @0.4;
//        ani.toValue = @0;
//        [label pop_addAnimation:ani forKey:@"upForRemo"];
//        label.textAlignment = NSTextAlignmentCenter;
//        
//        
//        [self performSelector:@selector(remos2:) withObject:label afterDelay:2];
//        
//        
//   
//    }
//    
//
//
//+ (void)remos2:(UILabel *)label
//{
//    [label removeFromSuperview];
//}
//


+(void)showMessage:(UIView *)views withMessage:(NSString *)message
{
    [ZZTool showMessage:views];
    UIView *v = [views viewWithTag:189];
    UILabel *la = (UILabel *)v;
    la.text = message;
}

/**
 *  @author guilin, 15-03-15 22:03:36
 *
 *  显示网络不给力，变小再变大的动画，然后自动淡出移除
 *
 *  @param views 传入要在显示的view
 */
+ (void)showMessage:(UIView *)views
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(views.center.x - 120 / 2,views.center.y - 80 /2, 160 , 80)];
    label.text = @"网络不给力呀";
    label.clipsToBounds = YES;
    label.alpha = 0.2;
    label.tag = 189;
    label.numberOfLines = 0;
    label.layer.cornerRadius = 9;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithWhite:0.298 alpha:1.000];
    label.textColor = [UIColor whiteColor];
    [views addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        [UIView animateWithDuration:0.4 animations:^{
            label.alpha = 0.5;
            
            label.frame = CGRectMake(views.center.x - 120 /2,views.center.y - 50 /2, 120 , 50);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.4 animations:^{
                label.alpha = 0.0;

                label.frame = CGRectMake(views.center.x - 140 /2,views.center.y - 60 /2, 140 , 60);

            } completion:^(BOOL finished) {
                if(finished) {
                    [label removeFromSuperview];
                }
            }];
            
        }];

    } ];

    

    
}





+ (UIImage *)getImageWithUrl:(NSString *)strUrl
{
    UIImage *image = nil;
    
    [[SDWebImageManager sharedManager] setCacheKeyFilter:^(NSURL *url) {
        url = [[NSURL alloc] initWithScheme:url.scheme host:url.host path:url.path];
        return [url absoluteString];
    }];
    
    return image;
}

+ (void)showHud:(UIView *)view title:(NSString *)title animated:(BOOL)isAnimated
{
//    dispatch_main_async_safe(^{
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:isAnimated];
//        hud.labelText = title;
//        hud.dimBackground = NO;
//    });
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:isAnimated];
    hud.labelText = title;
    hud.dimBackground = NO;
}

+ (void)hideHud:(UIView *)view animated:(BOOL)animated
{
//    dispatch_main_async_safe(^{
//        [MBProgressHUD hideHUDForView:view animated:animated];
//    });
    [MBProgressHUD hideHUDForView:view animated:animated];
}


+ (NSString *)convertToTime:(NSString *)addTime;
{
    addTime = [addTime stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:addTime];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}
+ (NSString *)convertToTimeWithSecond:(NSString *)addTime
{
    addTime = [addTime stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:addTime];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSString *)convertToUTCTime:(NSString *)addTime
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[addTime integerValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
    
}
#pragma mark --计算Lable高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
    //    if(iOS7)
    //    {
    //        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    //
    //        rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //        return ceil(rtSize.height) + 0.5;
    //    }
    //    else
    //    {
    //#pragma clang diagnostic push
    //#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //FIXME: kkkk
    rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    //#pragma clang diagnostic pop
    
    return rtSize.height;
    // }
}


#pragma mark --  Lable单行文字宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font
{
    CGSize rtSize;
    //    if(iOS7)
    //    {
    //        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    //        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    //
    //        rtSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    //        return ceil(rtSize.width) + 0.5;
    //    }
    //    else
    //    {
    rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return rtSize.width;
    //  }
}


@end
