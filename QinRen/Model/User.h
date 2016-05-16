//
//  User.h
//  QinRen
//
//  Created by Donny on 15/3/16.
//  Copyright (c) 2015年 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 uid":"516","username":"13576928795","realname":"1","icon":"","funds":"0.00","Integral":"40.00","mshopid":"0","paypwd":"","groupid":"1","groupname":"普通会员组","discount":"100.00",
 */
@interface User : NSObject

@property (nonatomic ,strong) NSString *uid;
@property (nonatomic ,strong) NSString *username;
@property (nonatomic ,strong) NSString *realname;
@property (nonatomic ,strong) NSString *icon;
@property (nonatomic ,strong) NSString *funds;
@property (nonatomic ,strong) NSString *integral;
@property (nonatomic ,strong) NSString *mshopid;
@property (nonatomic ,strong) NSString *paypwd;
@property (nonatomic ,strong) NSString *groupid;
@property (nonatomic ,strong) NSString *groupname;
@property (nonatomic ,strong) NSString *discount;
@property (nonatomic ,strong) NSString *goodname;
@property (nonatomic ,strong) NSString *pics;

+ (User *)sharedUser;

- (void)setUserInfo:(NSDictionary *)userinfo;
@end
