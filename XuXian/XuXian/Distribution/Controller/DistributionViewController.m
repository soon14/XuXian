//
//  DistributionViewController.m
//  XuXian
//
//  Created by 吴旭健 on 16/8/16.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "DistributionViewController.h"
#import "ShareView.h"
#import "Common.h"
#import "MJRefresh.h"
#import "UIViewController+Example.h"
#import "AnimationImageView.h"

@interface DistributionViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *DistributionWebView;
@property (strong,nonatomic)ShareView *shareView;
@property (assign,nonatomic)BOOL creat;

@property(strong,nonatomic)AnimationImageView *imgView;

@end

@implementation DistributionViewController
-(ShareView *)shareView{
    if (_creat==NO) {
        _shareView = [[ShareView alloc] init];
    }
    return _shareView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"全国送";
    //创建导航栏上的分享按键
    [self _createNavigationViews];
    
    _creat =NO;
    
    _imgView= [[AnimationImageView alloc] initWithFrame:CGRectMake(0, -40, _DistributionWebView.scrollView.frame.size.width, _DistributionWebView.scrollView.frame.size.height/15)];
    [self.DistributionWebView.scrollView addSubview:_imgView];
    
    NSURL *url = [NSURL URLWithString:@"http://mobile.xuxian.com/goods/getallsend?ver=2016072801&kill=1&user_id=1350719&store_id=1156"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.DistributionWebView loadRequest:request];
    
    
    __weak UIWebView *webView = self.DistributionWebView;
    
    webView.delegate =self;
    
    __weak UIScrollView *scrollView = self.DistributionWebView.scrollView;
    
    // 添加下拉刷新控件
    scrollView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [_imgView startAnimating];
        [webView reload];
    }];
    
}
#pragma mark - webViewDelegate
- (void)webViewDidFinishLoad:(nonnull UIWebView *)webView
{
    [_imgView stopAnimating];
    [self.DistributionWebView.scrollView.mj_header endRefreshing];
}




//创建右侧上的分享button
- (void)_createNavigationViews {
    //2.发送按钮
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    sendButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fenxiang.png"]];
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    [self.navigationItem setRightBarButtonItem:sendItem];
}

//分享
- (void)sendAction:(UIButton *)button{
    
    //创建分享视图
    [self _creatShareView];
    
}

-(void)_creatShareView{
    
    
    //存在一个问题，无法判断_shareView是否存在
    if (_creat==NO) {
        [UIView animateWithDuration:1 animations:^{
            
            _shareView = [[ShareView alloc] initWithFrame:CGRectMake(kScreenWidth/6, kScrennHeight, 0, 0)];
            _shareView.transform = CGAffineTransformScale(_shareView.transform, 0.65, 0.65);
            
            UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(_shareView.frame.origin.x+_shareView.frame.size.width, _shareView.frame.origin.y-80, 44, 44)];
            
            cancelButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shareClose"]];
            [cancelButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
            [_shareView addSubview:cancelButton];
            [self.view addSubview:_shareView];
            _creat=YES;
        }];
    }
    
}
//关闭分享视图
-(void)closeAction:(UIButton *)button{
    
    [UIView animateWithDuration:1 animations:^{
        
        [_shareView removeFromSuperview];
        _shareView =nil;
        _creat =NO;
    }];
    
}

@end
