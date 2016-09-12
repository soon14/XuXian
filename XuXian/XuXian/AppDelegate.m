//
//  AppDelegate.m
//  XuXian
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "BaseTabBarController.h"

//分享第三方
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//微信
#import "WXApi.h"
//新浪
#import "WeiboSDK.h"
//定位
#import "MapManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Start location Service
    MapManager *mapManager = [MapManager shareManager];
    [mapManager getUserLocation];
    
    mapManager.currentCityBlock =^(NSString *currentCity){
        NSLog(@"*******%@",currentCity);
    };
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    BaseTabBarController *base = [[BaseTabBarController alloc]init];
    [_window makeKeyAndVisible];
    
    //左侧控制器
    LeftViewController *left = [[UIStoryboard storyboardWithName:@"Left" bundle:nil]instantiateInitialViewController];
    MMDrawerController *drawController = [[MMDrawerController alloc]initWithCenterViewController:base leftDrawerViewController:left];
    
    //设置左右控制器显示的范围
    
    [drawController setMaximumLeftDrawerWidth:250.0];
    
    //设置打开的区域
    [drawController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    //设置关闭的区域
    [drawController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    self.window.rootViewController = drawController;
    
    
    [ShareSDK registerApp:@"163b6bc7902fc" activePlatforms:@[@(SSDKPlatformTypeWechat),@(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType) {
            case SSDKPlatformTypeWechat:
                
                [ShareSDKConnector connectWeChat:[WXApi class]];
                
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType) {
                //微信需要账户，暂时没有拿到
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx4868b35061f87885"
                                      appSecret:@"fe5cf9d700e71d81c482161ea9fc1fd1"];
                break;
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:@"163b6bc7902fc"
                                          appSecret:@"fe5cf9d700e71d81c482161ea9fc1fd1"
                                        redirectUri:@"http://www.sharesdk.cn"
                                           authType:SSDKAuthTypeBoth];
            default:
                break;
        }
        
        
    }];
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
