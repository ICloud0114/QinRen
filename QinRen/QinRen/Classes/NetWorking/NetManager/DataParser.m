//
//  DataParser.m
//  Cherries
//
//  Created by Donny on 5/22/14.
//  Copyright (c) 2014 Donny. All rights reserved.
//

#import "DataParser.h"
#import "FBEncryptorDES.h"
#import "JSONKit.h"
#import "NSString+URLEncoding.h"
const NSString *key = @"SDFL#)@F";

@implementation DataParser
+ (NSString *)parseString:(NSString *)responseString
{
    NSString *keyString = [NSString stringWithFormat:@"%@",key];
    NSString *jsonString = [FBEncryptorDES decrypt:responseString keyString:keyString];
    jsonString = [jsonString URLDecodedString];
    return jsonString;
}
@end
