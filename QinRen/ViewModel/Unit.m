//
//  Unit.m
//  FMDB-demo
//
//  Created by apple on 14-11-12.
//  Copyright (c) 2014年 LXH. All rights reserved.
//

#import "Unit.h"

@implementation Unit

+ (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(removeAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alert, @"alert", nil] repeats:NO];
}

+ (void)removeAlert:(NSTimer *)timer
{
    UIAlertView *alert = (UIAlertView *)[timer.userInfo objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [timer invalidate];
    timer = nil;
}
//创建Label
+(UILabel*)createLable:(CGRect)frame withName:(NSString *)name withFont:(CGFloat)font
{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    if(!name)
    {
        lable.text = @"";
    }
    else
    {
        lable.text = name;
    }
    lable.font = [UIFont systemFontOfSize:font];
    lable.backgroundColor = [UIColor clearColor];
    lable.numberOfLines = 0;
    return lable;
}
//创建Button
+(UIButton*)creatButton:(CGRect)frame withName:(NSString*)name normalImg:(UIImage*)normalImg highlightImg:(UIImage*)highlightImg selectImg:(UIImage*)selectImg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:frame];
    if(!name)
    {
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    else
    {
        [button setTitle:name forState:UIControlStateNormal];
    }
    [button setBackgroundImage:normalImg forState:UIControlStateNormal];
    [button setBackgroundImage:selectImg forState:UIControlStateSelected];
    [button setBackgroundImage:highlightImg forState:UIControlStateHighlighted];
    return button;
}
//创建TextField
+ (UITextField *)createTextField:(CGRect)frame withPlaceholder:(NSString *)placeholder
{
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = placeholder;
    textField.font = [UIFont systemFontOfSize:14];
    return textField;
}
//创建Label
+ (UITableView *)createTableView:(CGRect)frame withDelegate:(id)delegate
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.delegate = delegate;
    tableView.dataSource = delegate;
    return tableView;
}
//创建图片
+ (UIImageView *)createImageView:(CGRect)frame isRound:(BOOL)isRound
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    if(isRound)
    {
        imageView.layer.cornerRadius = frame.size.height/2;
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = [UIColor clearColor].CGColor;
        imageView.layer.masksToBounds = YES;
    }
    return imageView;
}
//创建scrollerView
+ (UIScrollView *)createScrollView:(CGRect)frame withDelegate:(id)delegate withContentSize:(CGSize)contentSize
{
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:frame];
    scrollview.contentSize = contentSize;
    scrollview.delegate = delegate;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.bounces = NO;
    return scrollview;
}
#pragma mark --计算Lable高度
+ (CGFloat)heightWithString:(NSString *)string font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CGSize rtSize;
    if(iOS7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.height) + 0.5;
    }
    else
    {
        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return rtSize.height;
    }
}
#pragma mark --  Lable单行文字宽度
+ (CGFloat)widthWithString:(NSString *)string font:(UIFont *)font
{
    CGSize rtSize;
    if(iOS7)
    {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        rtSize = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        return ceil(rtSize.width) + 0.5;
    }
    else
    {
        rtSize = [string sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        return rtSize.width;
    }
}
#pragma mark -- 弹框
+ (void)showNetFail
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                    message:@"数据加载失败,请检查网络重新加载"
                                                   delegate:self
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark -- image的翻转
+ (UIImage *)rotateImage:(UIImage *)aImage
{
    CGImageRef imgRef = aImage.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGFloat scaleRatio = 1;
    CGFloat boundHeight;
    UIImageOrientation orient = aImage.imageOrientation;
    switch(orient)
    {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(width, height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            break;
    }
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft)
    {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else
    {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imageCopy;
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,181,189
     */
    NSString * MOBILES = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278]|47[0-8])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189
     22         */
    NSString * CT = @"^1((33|53|8[019]|76)[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILES];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
