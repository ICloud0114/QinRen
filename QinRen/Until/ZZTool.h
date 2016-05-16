//
//  ZZTool.h
//  ZZQuickPrinting
//
//  Created by Lemon on 14-8-4.
//  Copyright (c) 2014年 wangshaosheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZTool : NSObject

+ (void)showHud:(UIView *)view title:(NSString *)title animated:(BOOL)isAnimated;


+ (void)hideHud:(UIView *)view animated:(BOOL)animated;

+ (void)showAlertViewWithTitle:(NSString*)title  messsage:(NSString*)message;
/**
 *  利用SDWebImage去根据url获取本地缓存图片
 */
+ (UIImage *)getImageWithUrl:(NSString *)strUrl;

//显示提示框
+ (void)showAlert:(NSString*)message;



/**
 *  @author guilin, 15-03-15 22:03:35
 *
 *  显示网络不给力，然后自动移除
 *
 *  @param views 传入要显示的views
 */
+ (void)showMessage:(UIView *)views;

/**
 *  @author guilin, 15-03-14 10:03:36
 *
 *  没网络，动画
 *
 *  @param views 
 */
+(void)showNote:(UIView *)views;


/**
 *  @author guilin, 15-03-15 22:03:51
 *
 *  自定义显示，然后自动移除
 *
 *  @param views
 *  @param message 传入显示字符
 */
+(void)showMessage:(UIView *)views withMessage:(NSString *)message;


+ (NSString *)convertToTime:(NSString *)addTime;
+ (NSString *)convertToTimeWithSecond:(NSString *)addTime;
+ (NSString *)convertToUTCTime:(NSString *)addTime;
#pragma mark --计算Lable高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;


#pragma mark --  Lable单行文字宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;



@end
