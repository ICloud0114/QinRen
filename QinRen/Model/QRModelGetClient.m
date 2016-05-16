//
//  QRModelGetClient.m
//  HEBINEWS
//
//  Created by guilin on 15/3/31.
//  Copyright (c) 2015年 LXH. All rights reserved.
//

#import "QRModelGetClient.h"

#import "XGLFetchJsonDataClass.h"


@implementation QRModelGetClient



- (instancetype)initWithAttribute:(NSDictionary *)attributes
{
    return nil;
}

- (instancetype)initWithAttribute:(NSDictionary *)attributes use:(Class)class;
{
    self = [super init];
    if (self) {
        self.data = [[class alloc]initWithAttribute:attributes];
    }
    return self;
    
}


+ (void)dataClass:(Class)className parameters:(NSDictionary *)pararmeter methodApi:(NSString *)api attributeEndString:(NSString *)endString paserCompeleteBlock:(void (^)(NSArray *datas, id originData,NSError *error))block
{
    
    
    EAHttpAPIClient *manager = [EAHttpAPIClient manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
//    NSDictionary *parameters = @{@"MemberId":user.username,@"codeno":codeno,@"pagesize":@"10",@"pageindex":[NSString stringWithFormat:@"%ld",(long)pageIndex],@"posttime":@"",@"endtime":@""};
    
    [manager GetWithParameters:pararmeter method:api success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *resposeString ;
        if ([responseObject isKindOfClass:[NSData class]]) {
            resposeString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        }else {
            resposeString = responseObject;
        }
        
        NSString *jsonString = [DataParser parseString:resposeString];
        id dictionary = [JSONKit jsonToArrayOrDictionary:jsonString];
        
        if ([[dictionary objectForKey:@"verification"]intValue] >= 1)
        {
            
            XGLFetchJsonDataClass *par = [[XGLFetchJsonDataClass alloc]init];

            id objs = [par parserJsonToArraywithEndString:endString data:dictionary];
            NSMutableArray *mutable;
            if ([objs isKindOfClass:[NSArray class]]) {
                NSArray *arr = objs;
                mutable = [[NSMutableArray alloc]initWithCapacity:arr.count];
                
                for (NSDictionary *att  in arr) {
                    QRModelGetClient *get = [[self alloc]initWithAttribute:att use:className];
                    [mutable addObject:get];
                }
                
            }
            
            
            
            if (block) {
                block(mutable,dictionary,nil);
            }

            
        }else {
            NSString *error = [dictionary objectForKey:@"error"];

            
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
            [SVProgressHUD showErrorWithStatus:error];
            if (block) {
                block(nil,dictionary,nil);
            }
            

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        if (block) {
            block(nil,nil,error);
        }
        
    }];
     
}
@end
