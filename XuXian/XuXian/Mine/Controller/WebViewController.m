//
//  WebViewController.m
//  XuXian
//
//  Created by Fxxx on 16/8/17.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "WebViewController.h"
#import "Common.h"
@interface WebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = _rightItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

-(void)setUrl:(NSURL *)url{
    _url = url;
    [self.webView loadRequest:[NSURLRequest requestWithURL:_url]];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = YES;
}


@end
