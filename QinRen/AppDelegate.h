//
//  AppDelegate.h
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"


@class emojiViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) BaseTabBarController *tabbarController;
- (void) showAlert: (NSString *) message;

- (NSString *)docFilePath;
- (NSString *)dataFilePath;
- (NSString *)tempFilePath;
- (NSString *)imageFilePath;
-(UIButton*)createFooterButton:(NSString*)s action:(SEL)action target:(id)target;

-(NSString*)formatdateFromStr:(NSString*)s format:(NSString*)str;
-(NSString*)formatdate:(NSDate*)d format:(NSString*)str;

- (void)setupTabbar;

@property (retain, nonatomic) emojiViewController* faceView;
//@property (retain, nonatomic) JXGroupViewController* groupVC;
//@property (retain, nonatomic) JXMainViewController *mainVc;
@end
