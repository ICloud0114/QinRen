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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupLoginView];
    
//    [self setupTabbar];
//    self.window.rootViewController = self.tabbarController;
    [self.window makeKeyAndVisible];
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

@end
