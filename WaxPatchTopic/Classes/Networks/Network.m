//
//  Network.m
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import "Network.h"

static NSString *const kAPIDomain = @"http://1.waxpatchtopic.sinaapp.com";

@implementation Network

+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPRequestOperationManager manager];
    }
    return self;
}

- (void)getTopicPatchContentWithComplete:(void (^)(BOOL success, NSString *msg, TopicPatchModel *topicPatch))completeBlock
                               withError:(void (^)(NSError *error))errorBlock {
    [_manager GET:[NSString stringWithFormat:@"%@/api.php", kAPIDomain]
       parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              TopicPatchModel *model = [[TopicPatchModel alloc] init];
              if (operation.response.statusCode == 200 && [responseObject isKindOfClass:[NSDictionary class]] && [[responseObject allKeys] containsObject:@"version"] && [[responseObject allKeys] containsObject:@"image"] && [[responseObject allKeys] containsObject:@"patch"]) {
                  model.topicVersion = responseObject[@"version"];
                  model.topicImage = responseObject[@"image"];
                  model.topicPatchURL = responseObject[@"patch"];
                  
                  completeBlock(YES, @"获取更新包数据成功", model);
              } else {
                  completeBlock(NO, @"获取更新包数据失败", model);
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"请求错误");
              errorBlock(error);
          }
     ];
}

@end
