//
//  AppDelegate.m
//  QinRen
//
//  Created by Donny on 15/2/27.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "GroupViewController.h"
#import "AddFriendsViewController.h"
#import "ShoppingCarViewController.h"
#import "MineViewController.h"
#import "MyNavigationController.h"
#import "SloppySwiper.h"
#import "emojiViewController.h"

#import "TESTUser.h"

@implementation AppDelegate
@synthesize window,faceView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupLoginView];
    
//    [self setupTabbar];
//    self.window.rootViewController = self.tabbarController;
   //  faceView = [[emojiViewController alloc]initWithFrame:CGRectMake(0, JX_SCREEN_HEIGHT-218, WIDTH, 218)];
    //
   faceView = [[emojiViewController alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-280, WIDTH, 218)];
    //这个是设置qq表情的
  //  faceView = [[emojiViewController alloc]initWithFrame:CGRectMake(0, JX_SCREEN_HEIGHT-218, 320, 218)];
    [self.window makeKeyAndVisible];
    

    
    /**
     *  @author guilin, 15-04-02 09:04:50
     *
     *  测试
     */
  

//    NSDictionary *parameters = @{@"name":@"",@"sn":@"",@"pagesize":@"",@"pageindex":@""};
//    
////    [manager GetWithParameters:parameters method:@"get.goods.list"
//    [QRModelGetClient dataClass:[TESTUser class] parameters:parameters methodApi:@"get.goods.list" attributeEndString:@"data" paserCompeleteBlock:^(NSArray *datas, id oringinData, NSError *error) {
//        if (!error) {
//            QRModelGetClient *get = [datas firstObject];
//            TESTUser *test = get.data;
//            
//            DLog(@"%@",test.name);
//            DLog(@"%@",oringinData);
//        } else {
//            DLog(@"%@",error);
//        }
//     
//        
//    }];
    
    return YES;
}


- (void)setupLoginView
{
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    MyNavigationController *navgation = [board instantiateViewControllerWithIdentifier:@"navgation"];
    self.window.rootViewController = navgation;
}

- (void)setupTabbar
{
    self.tabbarController = [[BaseTabBarController alloc]init];
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MyNavigationController *navgation1 =  [main instantiateViewControllerWithIdentifier:@"nav1"];
 
    MyNavigationController *navgation2 = [main instantiateViewControllerWithIdentifier:@"nav2"];
  
    MyNavigationController *navgation3 = [main instantiateViewControllerWithIdentifier:@"nav3"];
    
 
    MyNavigationController *navgation4 = [main instantiateViewControllerWithIdentifier:@"nav4"];
    
    MyNavigationController *navgation5 = [main instantiateViewControllerWithIdentifier:@"nav5"];
 
    
    self.tabbarController.viewControllers = @[navgation1,navgation2,navgation3,navgation4,navgation5];
    
    UITabBarItem *trainEnquiryItem1  = [self.tabbarController.tabBar.items objectAtIndex:0];
    [trainEnquiryItem1 setImage:[UIImage imageNamed:@"tab_default_57"]];
    [trainEnquiryItem1 setSelectedImage:[UIImage imageNamed:@"tab_hover_40"]];
    trainEnquiryItem1.title = @"首页";
    
    UITabBarItem *trainEnquiryItem2  = [self.tabbarController.tabBar.items objectAtIndex:1];
    [trainEnquiryItem2 setImage:[UIImage imageNamed:@"tab_default_59"]];
    [trainEnquiryItem2 setSelectedImage:[UIImage imageNamed:@"tab_hover_43"]];
    trainEnquiryItem2.title = @"交流群";
    
    UITabBarItem *trainEnquiryItem3  = [self.tabbarController.tabBar.items objectAtIndex:2];
    [trainEnquiryItem3 setImage:[UIImage imageNamed:@"tab_default_60"]];
    [trainEnquiryItem3 setSelectedImage:[UIImage imageNamed:@"tab_hover_45"]];
    trainEnquiryItem3.title = @"加朋友";
    
    UITabBarItem *trainEnquiryItem4  = [self.tabbarController.tabBar.items objectAtIndex:3];
    [trainEnquiryItem4 setImage:[UIImage imageNamed:@"tab_default_61"]];
    [trainEnquiryItem4 setSelectedImage:[UIImage imageNamed:@"tab_hover_48"]];
    trainEnquiryItem4.title = @"购物车";
    
    UITabBarItem *trainEnquiryItem5  = [self.tabbarController.tabBar.items objectAtIndex:4];
    [trainEnquiryItem5 setImage:[UIImage imageNamed:@"tab_default_62"]];
    [trainEnquiryItem5 setSelectedImage:[UIImage imageNamed:@"tab_hover_50"]];
    trainEnquiryItem5.title = @"我的";
    
    [self.tabbarController.tabBar setBackgroundColor:[UIColor colorWithRed:105/255.0 green:197/255.0 blue:94/255.0 alpha:1]];
    self.tabbarController.tabBar.translucent = NO;
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithRed:104/255.0 green:199/255.0 blue:91/255.0 alpha:1]];
 
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:105/255.0 green:197/255.0 blue:94/255.0 alpha:1],                                                                                                              NSForegroundColorAttributeName, nil]
                                             forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1],
      NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) showAlert: (NSString *) message
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [av show];

    //[self showMsg:message];
}

- (NSString *)docFilePath {
    NSString* s = [NSString stringWithFormat:@"%@/Documents/",NSHomeDirectory()];
    //NSLog(@"%@",s);
    return s;
}

- (NSString *)dataFilePath {
    NSString* s = [NSString stringWithFormat:@"%@/Library/Caches/",NSHomeDirectory()];
    //NSLog(@"%@",s);
    return s;
}

- (NSString *)tempFilePath {
    NSString* s = [NSString stringWithFormat:@"%@/tmp/",NSHomeDirectory()];
    //NSLog(@"%@",s);
    return s;
}

- (NSString *)imageFilePath {
    NSString *s=[[NSBundle mainBundle] bundlePath];
    s = [s stringByAppendingString:@"/"];
    //NSLog(@"%@",s);
    return s;
}

-(UIButton*)createFooterButton:(NSString*)s action:(SEL)action target:(id)target{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame   = CGRectMake((320-76)/2, (49-36)/2, 152/2, 72/2);
    
    //    UIImage* jpg = [[UIImage alloc]initWithContentsOfFile:[[self imageFilePath] stringByAppendingPathComponent:@"button@2x.png"]];
    UIImage* jpg = [UIImage imageWithContentsOfFile:[[self imageFilePath] stringByAppendingPathComponent:@"tabbar_button_normal@2x.png"]];
    jpg = [jpg stretchableImageWithLeftCapWidth:21 topCapHeight:14];
    [btn setBackgroundImage:jpg forState:UIControlStateNormal];
    
    jpg = [UIImage imageWithContentsOfFile:[[self imageFilePath] stringByAppendingPathComponent:@"tabbar_button_normal@2x.png"]];
    jpg = [jpg stretchableImageWithLeftCapWidth:21 topCapHeight:14];
    [btn setBackgroundImage:jpg forState:UIControlStateHighlighted];
    
    btn.showsTouchWhenHighlighted = YES;
    [btn setTitle:s forState:UIControlStateNormal];
    btn.font = [UIFont systemFontOfSize:13];
    //btn.titleLabel.textColor = [UIColor yellowColor];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

-(NSString*)formatdateFromStr:(NSString*)s format:(NSString*)str{
    NSDateFormatter* f=[[NSDateFormatter alloc]init];
    [f setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate* d = [f dateFromString:s];
    
    f.dateFormat = str;
    NSString* s1 = [f stringFromDate:d];

    return  s1;
}

-(NSString*)formatdate:(NSDate*)d format:(NSString*)str{
    NSDateFormatter* f=[[NSDateFormatter alloc]init];
    f.dateFormat = str;
    NSString* s = [f stringFromDate:d];
 
    return  s;
}
@end
