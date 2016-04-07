//
//  DownloadPatchManager.m
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import "DownloadPatchManager.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import "ZipArchive.h"
#import "CommonUtility.h"
#import "Constant.h"

@implementation DownloadPatchManager

+ (void)downloadAndUnzipPatchByVersion:(NSString *)version
                         byDownloadUrl:(NSString *)url
                          withComplete:(void(^)(BOOL success, NSString *msg))completeBlock
                             withError:(void(^)(NSError *error))errorBlock {
    NSString *localPatch = [[CommonUtility getLocalPatchPath] stringByAppendingString:[NSString stringWithFormat:@"/%@_%@.%@", kLocalPatchNamePrefix, version, kLocalPatchType]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:localPatch]) {
        completeBlock(YES, @"更新包已存在");
    } else {
        NSURL *patchUrl = [NSURL URLWithString:url];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:patchUrl];
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:localPatch append:NO]];
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *destinationPath = [[CommonUtility getLocalPatchPath] stringByAppendingPathComponent:kLocalPatchFolder];
            [[NSFileManager defaultManager] removeItemAtPath:destinationPath error:NULL];
            [[NSFileManager defaultManager] createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:NULL];
            
            ZipArchive *zip = [[ZipArchive alloc] init];
            [zip UnzipOpenFile:localPatch];
            [zip UnzipFileTo:destinationPath overWrite:YES];
            
            // 删除 zip
            [[NSFileManager defaultManager] removeItemAtPath:localPatch error:NULL];
            
            completeBlock(YES, @"更新包下载成功!");
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            errorBlock(error);
        }];
        [operation start];
    }
}

@end
