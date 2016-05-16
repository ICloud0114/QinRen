//
//  Macro.h
//  CosBeautyMiZi
//
//  Created by Donny on 14-8-26.
//  Copyright (c) 2014年 CosBeauty. All rights reserved.
//




#define IS_IPHONE_5 (((double)[[UIScreen mainScreen] bounds].size.height) == ((double)568))
#define IS_IPHONE_4 (((double)[[UIScreen mainScreen] bounds].size.height) == ((double)480))
#define IS_IPHONE_6 (((double)[[UIScreen mainScreen] bounds].size.height) == ((double)667))
#define IS_IPHONE_6P (((double)[[UIScreen mainScreen] bounds].size.height) == ((double)736))
#define IS_IOS7 ([[[[UIDevice currentDevice] systemVersion] substringToIndex:1] intValue]>=7)

#define ORIGINAL_MAX_WIDTH 640.0f

//十六进制转RGB颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define ifLogin @"ifLogin"
#define accountInfo @"userInfo"
#define ifSavePassword @"savePassword"
#define ifSaveAccount @"saveAccount"
