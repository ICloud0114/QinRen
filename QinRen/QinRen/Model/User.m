//
//  User.m
//  QinRen
//
//  Created by Donny on 15/3/16.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import "User.h"

@implementation User

/*
 uid":"516","username":"13576928795","realname":"1","icon":"","funds":"0.00","Integral":"40.00","mshopid":"0","paypwd":"","groupid":"1","groupname":"普通会员组","discount":"100.00",

 */

+ (User *)sharedUser
{
    static User *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}

- (void)setUserInfo:(NSDictionary *)userinfo
{
    self.uid = [userinfo objectForKey:@"uid"];
    self.username = [userinfo objectForKey:@"username"];
    self.realname = [userinfo objectForKey:@"realname"];
    self.icon = [userinfo objectForKey:@"icon"];
    self.funds = [userinfo objectForKey:@"funds"];
    self.integral = [userinfo objectForKey:@"integral"];
    self.mshopid = [userinfo objectForKey:@"mshopid"];
    self.paypwd = [userinfo objectForKey:@"paypwd"];
    self.groupid = [userinfo objectForKey:@"groupid"];
    self.groupname = [userinfo objectForKey:@"groupname"];
    self.discount = [userinfo objectForKey:@"discount"];
}


@end
