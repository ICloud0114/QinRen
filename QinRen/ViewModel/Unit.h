//
//  Unit.h
//  FMDB-demo
//
//  Created by apple on 14-11-12.
//  Copyright (c) 2014年 LXH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Unit : NSObject

+ (void)showAlert:(NSString *)message;
+ (void)removeAlert:(NSTimer *)timer;
+ (void)showNetFail;

//创建UILabel
+ (UILabel*)createLable:(CGRect)frame withName:(NSString *)name withFont:(CGFloat)font;
//创建UIButton
+(UIButton*)creatButton:(CGRect)frame withName:(NSString*)name normalImg:(UIImage*)normalImg highlightImg:(UIImage*)highlightImg selectImg:(UIImage*)selectImg;
//创建UITextField
+ (UITextField *)createTextField:(CGRect)frame withPlaceholder:(NSString *)placeholder;
//创建UITableView
+ (UITableView *)createTableView:(CGRect)frame withDelegate:(id)delegate;
//创建UIImageView
+ (UIImageView *)createImageView:(CGRect)frame isRound:(BOOL)isRound;
//创建UIScrollView
+ (UIScrollView *)createScrollView:(CGRect)frame withDelegate:(id)delegate withContentSize:(CGSize)contentSize;
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width;
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font;
#pragma mark -- image的翻转
+ (UIImage *)rotateImage:(UIImage *)aImage;
//判断手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
