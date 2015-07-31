//
//  NSString+Category.m
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import "NSString+Category.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Category)

+ (NSString *)formatPrice:(double)price {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formatString = [formatter stringFromNumber:@(price)];
    NSString *sympolString = [NSString stringWithFormat:@"￥%@", formatString];
    return sympolString;
}

- (NSString *)md5HexDigest {
    const char *encode_string = [self UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH];
    NSMutableString* result = [NSMutableString stringWithCapacity:10];
    
    CC_MD5(encode_string, strlen(encode_string), digist);
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [result appendFormat:@"%02x", digist[i]];
    }
    
    return result;
}

@end
