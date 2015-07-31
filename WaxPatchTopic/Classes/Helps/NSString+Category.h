//
//  NSString+Category.h
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

+ (NSString *)formatPrice:(double)price;
- (NSString *)md5HexDigest;

@end
