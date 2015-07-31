//
//  DownloadPatchManager.h
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadPatchManager : NSObject

+ (void)downloadAndUnzipPatchByVersion:(NSString *)version
                         byDownloadUrl:(NSString *)url
                          withComplete:(void(^)(BOOL success, NSString *msg))completeBlock
                             withError:(void(^)(NSError *error))errorBlock;

@end
