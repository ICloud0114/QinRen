//
//  JSONKit.m
//  Cherries
//
//  Created by Donny on 5/22/14.
//  Copyright (c) 2014 Donny. All rights reserved.
//

#import "JSONKit.h"

@implementation JSONKit

+ (NSString *)toJson:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    if ([jsonData length] && error == nil){
        NSString *result = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
        return result;
    }else{
        return nil;
    }
}


+ (id)jsonToArrayOrDictionary:(NSString *)jsonString{
    NSRange range = [jsonString rangeOfString:@"}" options:NSBackwardsSearch];
    
    if(range.location != NSNotFound)
        jsonString = [jsonString substringWithRange:NSMakeRange(0,range.location+1)];
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        return nil;
    }
}

@end

@implementation NSString(JSONCategories)
- (id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

@end


@implementation NSArray (JSONCategories)

- (NSString *)JSONString
{
    NSError* error = nil;
    id jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];

    
    if ([jsonData length] && error == nil){
        NSString *result = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
        return result;
    }else{
        return nil;
    }
}

@end


@implementation NSDictionary(JSONCategories)

- (NSString *)JSONString
{
    NSError* error = nil;
    id jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                  options:kNilOptions error:&error];
    
    
    if ([jsonData length] && error == nil){
        NSString *result = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
        return result;
    }else{
        return nil;
    }
}

@end




