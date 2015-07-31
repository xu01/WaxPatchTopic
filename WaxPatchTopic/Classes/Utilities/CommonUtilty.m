//
//  CommonUtility.m
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import "CommonUtility.h"
#import "Constant.h"
#import "NSString+Category.h"

@implementation CommonUtility

+ (NSString *)getLocalPatchPath {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSData *)cachedImageFromURL:(NSString *)urlStr
{
    NSString *md5Str = [urlStr md5HexDigest];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *cachePath = [[[[self getLocalPatchPath] stringByAppendingString:kImgCacheFolder] stringByAppendingPathComponent:md5Str] stringByAppendingString:@".jpg"];
    if ([fileManager fileExistsAtPath:cachePath]) {
        return [NSData dataWithContentsOfFile:cachePath];
    }
    else {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
        [imageData writeToFile:cachePath atomically:YES];
        return imageData;
    }
}

@end
