//
//  SplashViewController.m
//  WaxPatchTopic
//
//  Created by xu01 on 7/30/15.
//  Copyright (c) 2015 xu01. All rights reserved.
//

#import "SplashViewController.h"
#import <AFNetworking/AFHTTPRequestOperation.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"
#import "ZipArchive.h"

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
    _HUD.detailsLabelText = @"更新中";
    _HUD.square = YES;
    
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *patchZip = [doc stringByAppendingPathComponent:@"patch.zip"];
    NSURL *patchUrl = [NSURL URLWithString:@"http://lol.e7joy.com/patch1.zip"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:patchUrl];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:patchZip append:NO]];
    [_HUD show:YES];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [_HUD hide:YES];
        NSLog(@"下载成功");
        NSString *destinationPath = [doc stringByAppendingPathComponent:@"lua"];
        [[NSFileManager defaultManager] removeItemAtPath:destinationPath error:NULL];
        [[NSFileManager defaultManager] createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:NULL];
        
        ZipArchive *zip = [[ZipArchive alloc] init];
        [zip UnzipOpenFile:patchZip];
        [zip UnzipFileTo:destinationPath overWrite:YES];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate initWax];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [_HUD hide:YES];
        NSLog(@"下载失败");
    }];
    [operation start];
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
