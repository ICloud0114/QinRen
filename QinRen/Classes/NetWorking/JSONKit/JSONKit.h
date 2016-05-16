//
//  JSONKit.h
//  Cherries
//
//  Created by Donny on 5/22/14.
//  Copyright (c) 2014 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONKit : NSObject

+ (NSString *)toJson:(id)theData;
+ (id)jsonToArrayOrDictionary:(NSString *)jsonString;

@end


@interface NSString(JSONCategories)

- (id)JSONValue;

@end

@interface NSArray (JSONCategories)

- (NSString *)JSONString;

@end


@interface NSDictionary (JSONCategories)

- (NSString *)JSONString;

@end
