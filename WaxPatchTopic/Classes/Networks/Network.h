//
//  Network.h
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "Model.h"

@interface Network : NSObject

@property (nonatomic, retain) AFHTTPRequestOperationManager *manager;

+ (instancetype)sharedInstance;

/*
 *  获取当前首页专题数据
 */
- (void)getTopicPatchContentWithComplete:(void (^)(BOOL success, NSString *msg, TopicPatchModel *topicPatch))completeBlock
                               withError:(void (^)(NSError *error))errorBlock;

@end
