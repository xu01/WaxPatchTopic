//
//  MainViewController.m
//  WaxPatchTopic
//
//  Created by xu01 on 7/31/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import "MainViewController.h"
#import "TopicViewController.h"
#import "CommonUtility.h"
#import "Constant.h"
#import "wax.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *destinationPath = [[CommonUtility getLocalPatchPath] stringByAppendingPathComponent:kLocalPatchFolder];
        NSString *env = [[NSString alloc ] initWithFormat:@"%@/?.lua;%@/?/init.lua;", destinationPath, destinationPath];
        setenv(LUA_PATH, [env UTF8String], 1);
        wax_start("patch", nil);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"WaxPatchTopic";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnTopicImage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTopicImage.frame = CGRectMake(0.0, 44.0, self.view.frame.size.width, 200.0);
    [btnTopicImage setImage:[UIImage imageWithData:[CommonUtility cachedImageFromURL:[[NSUserDefaults standardUserDefaults] valueForKey:udTopicImageURL]]] forState:UIControlStateNormal];
    [btnTopicImage addTarget:self action:@selector(gotoTopicAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnTopicImage];
}

- (void)gotoTopicAction:(UIButton *)sender {
    TopicViewController *topicViewController = [[TopicViewController alloc] init];
    [self.navigationController pushViewController:topicViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
