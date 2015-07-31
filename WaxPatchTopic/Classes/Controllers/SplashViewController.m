//
//  SplashViewController.m
//  WaxPatchTopic
//
//  Created by xu01 on 7/30/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import "SplashViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"
#import "Network.h"
#import "DownloadPatchManager.h"
#import "Model.h"
#import "Constant.h"

@interface SplashViewController ()
{
    MBProgressHUD   *_HUD;
}
@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
    _HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.square = YES;
    [_HUD show:YES];
    _HUD.detailsLabelText = @"检查更新中";
    [[Network sharedInstance] getTopicPatchContentWithComplete:^(BOOL success, NSString *msg, TopicPatchModel *topicPatch) {
        if (success) {
            _HUD.detailsLabelText = @"更新中";
            [DownloadPatchManager downloadAndUnzipPatchByVersion:topicPatch.topicVersion byDownloadUrl:topicPatch.topicPatchURL withComplete:^(BOOL success, NSString *msg) {
                [_HUD hide:YES];
                if (success) {
                    [[NSUserDefaults standardUserDefaults] setValue:topicPatch.topicImage forKey:udTopicImageURL];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    [(AppDelegate *)[UIApplication sharedApplication].delegate loadMainView];
                }
            } withError:^(NSError *error) {
                [_HUD hide:YES];
            }];
        } else {
            [_HUD hide:YES];
        }
    } withError:^(NSError *error) {
        [_HUD hide:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
