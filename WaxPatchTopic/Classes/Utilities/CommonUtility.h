//
//  CommonUtility.h
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtility : NSObject

/* 获取本地Patch路径 */
+ (NSString *)getLocalPatchPath;

/* 根据图片URL缓存图片 */
+ (NSData *)cachedImageFromURL:(NSString *)urlStr;

@end
