//
//  MineViewController.m
//  XuXian
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "MineViewController.h"
#import "Common.h"
#import "SYTableViewHeader.h"
#import "CellView.h"
#import "CellModel.h"
#import "WebViewController.h"
#import "settingViewController.h"

@interface MineViewController ()
{
    UIImageView * _bgView;
    WebViewController * _webViewCtr;
    SYTableView * _table;
}

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithPatternImage:[UIImage imageNamed:@"aa_78"]]};
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"aa_78"]];
    self.view.backgroundColor = [UIColor whiteColor];
    self.hidesBottomBarWhenPushed = YES;
    
    [self _creatBgView];
    [self _creatTableView];
    [self _createTopView];
    [self _creatVIPButton];
}



- (void)_createTopView{
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(20, 30, 30, 45)];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 30 , 30);
    leftButton.tag = 101;
    [leftButton setImage:[UIImage imageNamed:@"shezhi.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftButton];
    UILabel * leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 30, 15)];
    leftLabel.text = @"设置";
    leftLabel.textColor = [UIColor whiteColor];
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.font = [UIFont systemFontOfSize:12];
    [leftView addSubview:leftLabel];
    [topView addSubview:leftView];
    
    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, 30, 45)];
    rightView.right = kScreenWidth - 20;
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30 , 30);
    [rightButton setImage:[UIImage imageNamed:@"dingwei2.png"] forState:UIControlStateNormal];
    [rightView addSubview:rightButton];
    UILabel * rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(-15, 30, 60, 15)];
    rightLabel.text = @"地址管理";
    rightLabel.textColor = [UIColor whiteColor];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.font = [UIFont systemFontOfSize:12];
    [rightView addSubview:rightLabel];
    [topView addSubview:rightView];
    
}

- (void) _creatBgView{
    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    [self.view addSubview:_bgView];
    _bgView.image = [UIImage imageNamed:@"wodebeijng.png"];
    
    
}

- (void)_creatVIPButton{
    UIButton * VIPButton = [UIButton buttonWithType:UIButtonTypeCustom];
    VIPButton.frame = CGRectMake(kScreenWidth - 80, 200, 80, 20);
    [VIPButton setImage:[UIImage imageNamed:@"aa_81"] forState:UIControlStateNormal];
    [self.view addSubview:VIPButton];
    VIPButton.tag = 203;
    [VIPButton addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, VIPButton.width - 20, VIPButton.height)];
    label.text = @"开通会员";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:12];
    [VIPButton addSubview:label];
    
    
    UIImageView * imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    imgview.image = [UIImage imageNamed:@"6.2menberImage5"];
    [VIPButton addSubview:imgview];
}

- (void) _creatTableView{
    CGRect rect = CGRectMake(0, 0, kScreenWidth, kScrennHeight);
    NSString * cellname = NSStringFromClass([CellView class]);
    
    NSMutableArray * dataArr = [NSMutableArray array];
    NSArray * imgNames = @[@"account订单.png", @"account团订单.png", @"account会员.png", @"account分享.png", @"account积分商城.png", @"account加入许鲜.png"];
    NSArray * labelTexts = @[@"我的订单", @"我的鲜拼", @"我的会员", @"邀请好友", @"积分商城", @"加入许鲜"];
    for (NSInteger i  = 0; i < 6; i++) {
        CellModel * model = [[CellModel alloc] init];
        model.imgName = imgNames[i];
        model.labelText = labelTexts[i];
        [dataArr addObject:model];
    }
    
    _table = [[SYTableView alloc] initWithFrame:rect customerViewName:cellname columnNumber:3 leftMargin:5 apartMargin:1 target:self action:@selector(setupData:)];
    _table.rowHeight = 100;
    _table.arrayDatas = dataArr;
    _table.backgroundColor = [UIColor clearColor];
    _table.tableHeaderView = self.HeaderView;
    _table.tableFooterView = self.FooterView;
    _table.showsVerticalScrollIndicator = NO;
    _table.delegate = self;
    [self.view addSubview:_table];
    
    
    
}

- (UIView *)HeaderView{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    view.backgroundColor = [UIColor clearColor];
    
    UIView * buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 60)];
    buttonView.backgroundColor = [UIColor whiteColor];
    buttonView.alpha = 0.5;
    buttonView.bottom = view.bottom;
    [view addSubview:buttonView];
    NSArray * buttonTitle = @[@"余额", @"优惠券", @"许鲜币"];
    NSArray * textArr = @[@"0.00元", @"0张", @"0个"];
    for(NSInteger i = 0; i < 3; i++){
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat width = kScreenWidth / 3;
        button.frame = CGRectMake(i * width, 0, width, 60);
        button.tag = 100 + i;
        NSDictionary * Attribute = @{ NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:14], NSStrokeWidthAttributeName: @-3};
        NSAttributedString * title = [[NSAttributedString alloc] initWithString:buttonTitle[i] attributes:Attribute];
        [button setAttributedTitle:title forState:UIControlStateNormal];
        [buttonView addSubview:button];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, button.height - 20, button.width, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        NSAttributedString * text = [[NSAttributedString alloc] initWithString:textArr[i] attributes:Attribute];
        label.attributedText = text;
        [button addSubview:label];
    }
    
    
    UIButton * userButton = [UIButton buttonWithType:UIButtonTypeCustom];
    userButton.frame = CGRectMake(0, 0, 100, 100);
    userButton.center = view.center;
    UIImageView * userimg = [[UIImageView alloc] initWithFrame:userButton.bounds];
    userimg.image = [UIImage imageNamed:@"VipNormal"];
    [userButton addSubview:userimg];
    [userButton addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:userButton];
    
    UIImageView * vipImg = [[UIImageView alloc] initWithFrame:CGRectMake(20, 85, 60, 15)];
    vipImg.image = [UIImage imageNamed:@"6.2VipImageNormal"];
    [userButton addSubview:vipImg];
    
    UILabel * userLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 100)/2, CGRectGetMaxY(userButton.frame) + 10, 100, 30)];
    userLabel.textAlignment = NSTextAlignmentCenter;
    userLabel.textColor = [UIColor whiteColor];
    userLabel.text = @"用户名";
    userLabel.font = [UIFont systemFontOfSize:14];
    [view addSubview:userLabel];
    
    return view;
}
- (UIView *)FooterView{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((kScreenWidth - 200)/2, 25, 200, 35);
    [button setImage:[UIImage imageNamed:@"kefudianhua.png"] forState:UIControlStateNormal];
    [view addSubview:button];
    [button addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
}

- (void) callPhone:(UIButton *)button{
    //NSLog(@"拨打电话");
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"4000620113"];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

}

- (void)setupData:(SYTableViewEntity *)ent{
    
    CellView * customView = (CellView *)ent.customView;
    customView.backgroundColor = [UIColor whiteColor];
    CellModel * model = ent.entity;
    [customView.button setImage:[UIImage imageNamed:model.imgName] forState:UIControlStateNormal];
    customView.label.text = model.labelText;
    
    if([model.labelText isEqualToString:@"加入许鲜"]){
        [customView.button addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        customView.button.tag = 206;
    }else if ([model.labelText isEqualToString:@"我的会员"]){
        [customView.button addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        customView.button.tag = 203;
    }
    UITableViewCell * cell = (UITableViewCell *)customView.superview.superview;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void) Action:(UIButton*) button{
    if (button.tag == 101) {
        settingViewController * settingViewCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"setting"];
        [self.navigationController pushViewController:settingViewCtr animated:YES];
    }
    if (button.tag == 206) {
        [self jumpToWebWithCtrTitle:@"许鲜网-加入我们" bittonItem:self.shareButtonItem URL:@"http://www.xuxian.com/index.php?controller=joinus&action=index"];
    }
    if (button.tag == 203){
        [self jumpToWebWithCtrTitle:@"许鲜会员" bittonItem:nil URL:@"http://www.xuxian.com/index.php?controller=site&action=member_info2"];
    }
}


- (void) jumpToWebWithCtrTitle:(NSString *)title bittonItem:(UIBarButtonItem *)item URL:(NSString *)url{
    _webViewCtr = [self.storyboard instantiateViewControllerWithIdentifier:@"webCtr"];
    _webViewCtr.title = title;
    _webViewCtr.rightItem = item;
    _webViewCtr.url = [NSURL URLWithString:url];
    [self.navigationController pushViewController:_webViewCtr animated:YES];
}

//创建右侧上的分享button
- (UIBarButtonItem *)shareButtonItem {
    //发送按钮
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [shareButton setImage:[UIImage imageNamed:@"fenxiang"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    return shareItem;
}

//分享
- (void)shareAction:(UIButton *)button{
    
    
    
    
}

#pragma  mark viewFuncation------
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidDisappear:(BOOL)animated{
    
    
}

#pragma mark ScrollViewDelegate----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y <= 0) {
        CGFloat height = 300 - y;
        CGFloat width = (300 - y)/300 * kScreenWidth;
        _bgView.frame = CGRectMake((kScreenWidth - width)/2, 0, width, height);
    }else{
        _bgView.frame = CGRectMake(0, 0 - y / 2, kScreenWidth, 300);
    }
}

@end
