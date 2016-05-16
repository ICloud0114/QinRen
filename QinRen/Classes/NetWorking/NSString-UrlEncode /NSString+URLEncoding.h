//
//  NSString+URLEncoding.h
//  Cherries
//
//  Created by Donny on 5/22/14.
//  Copyright (c) 2014 Donny. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)
- (NSString *)URLEncodedString;
- (NSString*)URLDecodedString;
@end
