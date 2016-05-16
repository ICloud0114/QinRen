//
//  EAHttpAPIClient.m
//  Cherries
//
//  Created by Donny on 5/22/14.
//  Copyright (c) 2014 Donny. All rights reserved.
//

const NSString *baseUrl = @"http://113.105.159.115:6026/";
const NSString *keyString = @"SDFL#)@F";

#import "EAHttpAPIClient.h"
#import "JSONKit.h"
#import "FBEncryptorDES.h"

@implementation EAHttpAPIClient




- (AFHTTPRequestOperation *)GetWithParameters:(NSDictionary *)parameters
                                       method:(NSString *)method
                                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    

    NSString *requestStr = [self requestStringWithParameters:parameters method:method];
    
    NSLog(@"requestStr:%@",requestStr);
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:requestStr relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    [self.operationQueue addOperation:operation];
    
    return operation;
}



- (NSString *)requestStringWithParameters:(NSDictionary *)parameters
                                   method:(NSString *)method
{
    NSString *tempKeyString = [NSString stringWithFormat:@"%@",keyString];
    NSString *paramsJson = [parameters JSONString];
    paramsJson = [[FBEncryptorDES encrypt:paramsJson
                   
                                keyString:tempKeyString] uppercaseString];
    
    NSString *signs= [NSString stringWithFormat:@"%@Method%@Params%@%@",tempKeyString,method,paramsJson,tempKeyString];
    
    signs = [[FBEncryptorDES md5:signs] uppercaseString];
    
    NSString *requestStr = [NSString stringWithFormat:@"%@?Method=%@&Params=%@&Sign=%@",baseUrl,method,paramsJson,signs];
    
    return requestStr;
}

@end
