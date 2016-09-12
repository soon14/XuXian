//
//  settingViewController.m
//  XuXian
//
//  Created by mac on 16/8/19.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "settingViewController.h"
#import "Common.h"
#import "CleanCache.h"

#define CachePath [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"]

@interface settingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *CacheLabel;
@property (weak, nonatomic) IBOutlet UILabel *VersionLabel;

@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
    //获取版本号
    self.VersionLabel.text = [NSString stringWithFormat:@"版本: %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    
    //刷新缓存数据
    float cacheSize = [CleanCache folderSizeAtPath:CachePath];
    dispatch_async(dispatch_get_main_queue(), ^{
        _CacheLabel.text = [NSString stringWithFormat:@"%.2fM",cacheSize];
    });
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //清楚缓存
    if ([indexPath isEqual:[NSIndexPath indexPathForRow:1 inSection:0]]) {
        UIAlertController * alertCtr = [UIAlertController alertControllerWithTitle:nil message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleAlert];
        [alertCtr addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [CleanCache cleanCache:CachePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                _CacheLabel.text = [NSString stringWithFormat:@"%.2fM",[CleanCache folderSizeAtPath:CachePath]];
            });
            
        }]];
        [alertCtr addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertCtr animated:YES completion:nil];
    }
}

@end
