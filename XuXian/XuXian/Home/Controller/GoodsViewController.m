//
//  GoodsViewController.m
//  XuXian
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "GoodsViewController.h"
#import "UIImageView+WebCache.h"
#import "Common.h"

@interface GoodsViewController()<UIScrollViewDelegate>
@property (strong, nonatomic) UIImageView *bgImgView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *price_infoLabel;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIImageView *tipsimg;
@property (strong, nonatomic) UIImageView *show_imgs;
@property (strong, nonatomic) UIView *bottomBar;
@property (strong, nonatomic) UILabel * countLabel;
@property (assign, nonatomic) NSInteger count;

@end
@implementation GoodsViewController

- (void)loadView {
    NSLog(@"aaa");
    self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}


-(void)viewDidLoad{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    _count = 0;
    [self creatUI];
}

-(void)setModel:(GoodsModel *)model{
    _model = model;
    
}

- (void)creatButton{
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(20, 40, 30, 30);
    [leftButton setImage:[UIImage imageNamed:@"cha11"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(disAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(kScreenWidth - 50, 40, 30, 30);
    [rightButton setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [self.view addSubview:rightButton];
}


- (void)creatUI{
    //创建bgimgView
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 200)];
    //_bgImgView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_bgImgView];
    
    //创建showimgs
    _show_imgs = [[UIImageView alloc] initWithFrame:CGRectMake(50, 0, 200, 240)];
    [_bgImgView addSubview:_show_imgs];
    
    //创建scrollView
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrennHeight)];
    _scrollView.contentSize = CGSizeMake(kScreenWidth, 10000);
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    UIImageView * nocolorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 200)];
    [_scrollView addSubview:nocolorView];
    
    //创建showView
    UIView * showView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nocolorView.frame), kScreenWidth, 200)];
    showView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"aa_81"]];
    [_scrollView addSubview:showView];
    UIView * view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    view1.backgroundColor = [UIColor whiteColor];
    [showView addSubview:view1];
    UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view1.frame) + 5, kScreenWidth, 30)];
    view2.backgroundColor = [UIColor whiteColor];
    [showView addSubview:view2];
    UIView * view3 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view2.frame) + 5, kScreenWidth, 7)];
    view3.backgroundColor = [UIColor whiteColor];
    [showView addSubview:view3];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 20)];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.font = [UIFont systemFontOfSize:15 weight:3];
    [view1 addSubview:_nameLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_nameLabel.frame) + 5, 300, 15)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.font = [UIFont systemFontOfSize:13];
    [view1 addSubview:_titleLabel];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_titleLabel.frame) + 10, 300, 15)];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = [UIColor redColor];
    [view1 addSubview:_priceLabel];
    
    _price_infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_priceLabel.frame) + 5, 300, 15)];
    _price_infoLabel.textAlignment = NSTextAlignmentLeft;
    _price_infoLabel.font = [UIFont systemFontOfSize:15];
    _price_infoLabel.textColor = [UIColor grayColor];
    [view1 addSubview:_price_infoLabel];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 50, 20)];
    label1.text = @"规格";
    label1.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:label1];
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame), 5, 100, 20)];
    label2.textColor = [UIColor redColor];
    label2.text = @"约300g";
    label2.font = [UIFont systemFontOfSize:15];
    [view2 addSubview:label2];
    
    UILabel * label3 = [[UILabel alloc] initWithFrame: CGRectMake( 20, showView.height - 45, 300, 20)];
    label3.text = @"商品详情";
    label3.font = [UIFont systemFontOfSize:15];
    [showView addSubview:label3];
    
    //创建tipsimg
    _tipsimg = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 5, 60, 20)];
    [view2 addSubview:_tipsimg];
    
    //创建webView
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 400, kScreenWidth, 1000)];
    _webView.backgroundColor = [UIColor grayColor];
    _webView.scrollView.scrollEnabled = NO;
    _webView.delegate = self;
    [_scrollView addSubview:_webView];
    
    //创建返回button和分享button
    [self creatButton];
    
    //创建bottomBar
    _bottomBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScrennHeight - 44, kScreenWidth, 44)];
    _bottomBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomBar];
    UIButton * joinCar = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 100, 0, 100, 44)];
    [joinCar setTintColor:[UIColor whiteColor]];
    [joinCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    joinCar.backgroundColor = [UIColor orangeColor];
    [_bottomBar addSubview:joinCar];
    _bottomBar.tag = 3;
    [joinCar addTarget:self action:@selector(countAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView * buttonView = [[UIView alloc] initWithFrame:CGRectMake(40, 7, 100, 30)];
    buttonView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor blackColor]);
    buttonView.layer.borderWidth = 1.0;
    
    [_bottomBar addSubview:buttonView];
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 40, 30)];
    _countLabel.textAlignment = NSTextAlignmentCenter;
    _countLabel.font = [UIFont systemFontOfSize:15];
    _countLabel.text = [NSString stringWithFormat:@"%li",_count];
    [buttonView addSubview:_countLabel];
    
    UIButton * subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    subButton.frame = CGRectMake(0, 0, 30, 30);
    [subButton setImage:[UIImage imageNamed:@"jian_icon"] forState:UIControlStateNormal];
    subButton.tag = 101;
    [subButton addTarget:self action:@selector(countAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:subButton];
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(100 - 30, 0, 30, 30);
    [addButton setImage:[UIImage imageNamed:@"add_icon"] forState:UIControlStateNormal];
    addButton.tag = 102;
    [addButton addTarget:self action:@selector(countAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:addButton];
    
    //界面赋值
    [_bgImgView sd_setImageWithURL:[NSURL URLWithString:_model.newimg]];
    _titleLabel.text = _model.title;
    _nameLabel.text = _model.main_name;
    _priceLabel.text = [NSString stringWithFormat:@"会员价:￥%@/份", _model.price];
    _price_infoLabel.text = _model.price_info;
    [_tipsimg sd_setImageWithURL:[NSURL URLWithString:_model.tipsimg]];
    NSString * imgStr = [_model.show_imgs lastObject];
    [_show_imgs sd_setImageWithURL:[NSURL URLWithString:imgStr]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_model.details2]]];
}


//数量加减点击操作
- (void)countAction:(UIButton *)btn{
    if (btn.tag == 101) {
        if (_count > 0) {
            _count--;
            _countLabel.text = [NSString stringWithFormat:@"%li",_count];
        }
    }else if (btn.tag == 102){
        _count++;
        _countLabel.text = [NSString stringWithFormat:@"%li",_count];
    }else if (btn.tag == 103){
        //加入购物车操作
    }
}


- (void)disAction:(UIButton *)btn{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y <= 0) {
        CGFloat height = 200 - y;
        CGFloat width = (200 - y)/200 * kScreenWidth;
        _bgImgView.frame = CGRectMake((kScreenWidth - width)/2, 0, width, height);
    }else{
        _bgImgView.frame = CGRectMake(0, 0 - y, kScreenWidth, 200);
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    _webView.height = _webView.scrollView.contentSize.height;
    _scrollView.contentSize = CGSizeMake(kScreenWidth, _webView.scrollView.contentSize.height +464);
}

@end
