//
//  HomeViewController.m
//  XuXian
//
//  Created by Macx on 16/8/16.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "HomeViewController.h"
#import "Common.h"
#import "AddressViewController.h"
#import "MMDrawerController.h"
#import "AFNetworking.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "GoodsModel.h"
#import "YYModel.h"
#import "MyScrollView.h"

@interface HomeViewController ()<UIScrollViewDelegate>
{
    UIImageView *_listImgView;
    UIScrollView *_sectionView;
    NSMutableArray *_sectionBarArr;
    UIButton *_customServiceBtn;
    BOOL inside;
    NSArray *blockArr;
    NSArray *goodsArr;
    UIScrollView *_contentScrollView;
    MyScrollView * eachScrollView;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.automaticallyAdjustsScrollViewInsets=NO;
    //  remove black bar
    self.hidesBottomBarWhenPushed = YES;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithPatternImage:[UIImage imageNamed:@"aa_78"]]};
    
    [self _loadSectionBarData];
    
    [self _createFirstPage];
    [self _createCustomServiceBtn];
    // Do any additional setup after loading the view
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
    [self _customNavigationItems];
    [self _listAndSearch];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    MMDrawerController *drawController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawController setOpenDrawerGestureModeMask: MMOpenDrawerGestureModeAll];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    MMDrawerController *drawController = (MMDrawerController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [drawController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

-(void)_createCustomServiceBtn{
    _customServiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _customServiceBtn.frame = CGRectMake(0, 157, 50, 50);
    _customServiceBtn.tag = 1100;
    [_customServiceBtn setImage:[UIImage imageNamed:@"首页联系客服.png"] forState:UIControlStateNormal];
    [_customServiceBtn setImage:[UIImage imageNamed:@"首页联系客服点中状态.png"] forState:UIControlStateHighlighted];
    [_customServiceBtn addTarget:self action:@selector(dragAction:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    //button长按事件
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [_customServiceBtn addGestureRecognizer:longPress];
    [self.view addSubview:_customServiceBtn];
}

- (void)dragAction: (UIButton *)btn withEvent:(UIEvent *)event{
    CGPoint locationP = [[[event allTouches] anyObject] locationInView:self.view];
    CGFloat x = locationP.x;
    CGFloat y = locationP.y;
    CGFloat btnx = btn.frame.size.width/2;
    CGFloat btny = btn.frame.size.height/2;
    if(x<=btnx){
        locationP.x = btnx;
    }
    if(x >= kScreenWidth - btnx){
        locationP.x = kScreenWidth - btnx;
    }
    if (y <= 157 + btny) {
        locationP.y = 157 + btny;
    } else if(locationP.y >= kScrennHeight - 49 - btny){
        locationP.y = kScrennHeight - 49 - btny;
    }
    _customServiceBtn.center =locationP;
}

-(void)btnLong:(UILongPressGestureRecognizer*)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        NSLog(@"长按事件");
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"联系客服" message:@"400-062-0113" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
}


-(void)_loadSectionBarData{
    id responseObject = nil;
    [self _processResponseData:responseObject];
    //    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    //    NSString *url = @"http://mobile.xuxian.com/index/config";
    //    NSMutableDictionary *param=[@{@"ver":@"2016072801",
    //                                 @"cityId":@"110000",
    //                                 @"storeId":@"990",
    //                                 @"userId":@"1654350"}mutableCopy];
    //    [manager POST:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
    //        [self _processResponseData:responseObject];
    //        dispatch_async(dispatch_get_main_queue(), ^{
    //            [self _createSectionBar];
    //        });
    //    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    //        NSLog(@"error :%@",error);
    //    }];
    [self _createSectionBar];
}

-(void)_processResponseData:(id)responseObject{
    _sectionBarArr =[NSMutableArray array];
    if (responseObject !=nil) {
        NSDictionary *responseDic = (NSDictionary *)responseObject;
        NSArray *sessionArr =responseDic[@"data"][@"section_info"];
        for (NSDictionary *dic in sessionArr) {
            NSString *sessionName = dic[@"name"];
            [_sectionBarArr addObject:sessionName];
        }
    } else{
        _sectionBarArr =[@[@"首页",@"水果",@"轻食",@"中秋礼品",@"储值卡"]mutableCopy];
    }
}
-(void)_customNavigationItems{
    UIImage *img = [UIImage imageNamed:@"aa_78.png"];
    //  top view
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 108)];
    [topView setBackgroundColor:[UIColor colorWithPatternImage:img]];
    [self.view addSubview:topView];
    //  left button
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 22, kScreenWidth/2, 44)];
    UIImageView *houseImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 3, 25, 25)];
    houseImgView.image = [UIImage imageNamed:@"60List@2x.png"];
    [leftButton addSubview:houseImgView];
    
    UILabel *selfLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 25, 10)];
    selfLabel.text = @"自提";
    selfLabel.font = [UIFont systemFontOfSize:10];
    selfLabel.backgroundColor = [UIColor clearColor];
    selfLabel.textAlignment = NSTextAlignmentCenter;
    [leftButton addSubview:selfLabel];
    
    UIImageView *lineImgView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 0, 2, 44)];
    lineImgView.backgroundColor = [UIColor clearColor];
    lineImgView.image = [UIImage imageNamed:@"tabbarBackground.png"];
    [leftButton addSubview:lineImgView];
    
    UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, 40, 22)];
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.font = [UIFont systemFontOfSize:13];
    cityLabel.text =@"北京市";
    [leftButton addSubview:cityLabel];
    //  arrow image
    UIImageView *arrowLabel = [[UIImageView alloc]initWithFrame:CGRectMake(75, 10, 5, 10)];
    arrowLabel.image = [UIImage imageNamed:@"提货点选择.png"];
    arrowLabel.backgroundColor = [UIColor clearColor];
    [leftButton addSubview:arrowLabel];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(35, 25, kScreenWidth/2-35, 19)];
    addressLabel.text =@"管村32院（华欣超市）";
    addressLabel.font =[UIFont systemFontOfSize:12];
    addressLabel.backgroundColor = [UIColor clearColor];
    [leftButton addSubview:addressLabel];
    //  leftButton.backgroundColor = [UIColor greenColor];
    [topView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    //  right button
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth -40, 22, 30 , 30)];
    _listImgView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 30, 30)];
    _listImgView.image = [UIImage imageNamed:@"列表切换@2x.png"];
    [rightButton addSubview:_listImgView];
    [self.view addSubview:rightButton];
    rightButton.selected = NO;
    [rightButton addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //    宫格@2x.png
}
-(void)_listAndSearch{
    //
    UIButton *listButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 69, (kScreenWidth -30)/4, 34)];
    listButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"aa_81.png"]];
    listButton.layer.cornerRadius = 5.0;
    [self.view addSubview:listButton];
    //  listArrow
    UIImageView *lstArrow = [[UIImageView alloc]initWithFrame:CGRectMake(5, 12, 10, 10)];
    lstArrow.image =[UIImage imageNamed:@"cardleft.png"];
    [listButton addSubview:lstArrow];
    
    UIImageView *categoryImg = [[UIImageView alloc]initWithFrame:CGRectMake(18, 7, 20, 20)];
    categoryImg.contentMode = UIViewContentModeScaleToFill;
    categoryImg.backgroundColor = [UIColor clearColor];
    categoryImg.image = [UIImage imageNamed:@"60fenlei@2x.png"];
    [listButton addSubview:categoryImg];
    
    UILabel *cateLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 7, 30, 20)];
    cateLabel.text = @"分类";
    cateLabel.font = [UIFont systemFontOfSize:11];
    cateLabel.backgroundColor = [UIColor clearColor];
    //    cateLabel.textAlignment = NSTextAlignmentCenter;
    [listButton addSubview:cateLabel];
    
    //  search button
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth -30)/4 +20, 69, (kScreenWidth -30)*3/4, 34)];
    searchButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"aa_81.png"]];
    searchButton.layer.cornerRadius = 5.0;
    [self.view addSubview:searchButton];
    
    UIImageView *searchImgView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 15, 15)];
    searchImgView.image = [UIImage imageNamed:@"首页搜索.png"];
    [searchButton addSubview:searchImgView];
    
    UILabel *textLbl = [[UILabel alloc]initWithFrame:CGRectMake(70, 7, (kScreenWidth -30)*3/4 - 70, 20)];
    textLbl.text = @"请输入名称搜索";
    textLbl.font = [UIFont systemFontOfSize:12];
    textLbl.textColor = [UIColor lightGrayColor];
    [searchButton addSubview:textLbl];
}
-(void)leftAction{
    AddressViewController *addressCtr = [[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"AddressCtr"];
    [self.navigationController pushViewController:addressCtr animated:YES];
}
-(void)rightBtnAction:(UIButton*)button{
    button.selected =!button.selected;
    if (button.selected) {
        _listImgView.image = [UIImage imageNamed:@"宫格@2x.png"];
    } else{
        _listImgView.image = [UIImage imageNamed:@"列表切换@2x.png"];
    }
    eachScrollView.isList = button.selected;
    
}

-(void)_createSectionBar{
    _sectionView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 69+34, kScreenWidth, 34)];
    _sectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_sectionView];
    
    CGFloat totolWidth = 0;
    for (NSInteger i = 0; i< _sectionBarArr.count; i++) {
        NSString *str = _sectionBarArr[i];
        CGFloat width = [self _calculateLabelHeight:str];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(20 *(i+1) +totolWidth, 5,width,24)];
        totolWidth +=width;
        button.userInteractionEnabled = YES;
        button.tag = 1000 +i;
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:str];
        NSRange titleRange = {0,[title length]};
        [title addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:titleRange];
        [button setAttributedTitle:title
                          forState:UIControlStateNormal];
        
        NSMutableAttributedString *title1 = [[NSMutableAttributedString alloc] initWithString:str];
        NSRange titleRange1 = {0,[title1 length]};
        [title1 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title1 addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} range:titleRange1];
        [button setAttributedTitle:title1 forState:UIControlStateSelected];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
        [_sectionView addSubview:button];
    }
}

-(void)buttonSelected:(UIButton *)button{
    NSArray *arr =[button.superview subviews];
    for (id btn in arr) {
        if ([btn isKindOfClass:[UIButton class]]) {
            UIButton *selectedBtn = (UIButton *)btn;
            selectedBtn.selected =NO;
        }
    }
    button.selected = !button.selected;
}

-(CGFloat)_calculateLabelHeight:(NSString*)text{
    NSDictionary *attrs=@{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGRect rect =[text boundingRectWithSize:CGSizeMake(999, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
    return rect.size.width;
}

#pragma mark - firstpage content
-(void)_createFirstPage{
    blockArr = [NSArray array];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"blocks" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSDictionary *data = dic[@"data"];
    blockArr = data[@"blocks"];
    
    goodsArr = [NSArray array];
    NSString *filePath1 = [[NSBundle mainBundle]pathForResource:@"goods" ofType:@"plist"];
    NSDictionary *dic1 = [NSDictionary dictionaryWithContentsOfFile:filePath1];
    NSDictionary *data1 = dic1[@"data"];
    goodsArr = data1[@"goods"];
    [self _createContentScrollView];
}

-(void)_createContentScrollView{
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _sectionView.bottom, kScreenWidth, kScrennHeight - 69-34 -49)];
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    _contentScrollView.delegate =self;
    _contentScrollView.userInteractionEnabled = YES;
    _contentScrollView.scrollEnabled =YES;
    _contentScrollView.showsVerticalScrollIndicator =YES;
    [self.view addSubview: _contentScrollView];
    
    eachScrollView = [[MyScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScrennHeight - _contentScrollView.top)];
    eachScrollView.blockArr = blockArr;
    eachScrollView.goodsArray = goodsArr;
    [_contentScrollView addSubview:eachScrollView];
    _contentScrollView.contentSize = CGSizeMake(kScreenWidth *5, 0);
}

/*
 "newimg":"http://imgcdn.xuxian.com/upload/2016/04/11/20160411101951550.jpg",
 "id":"800",
 "main_name":"串红西红柿",
 "title":"串红西红柿，比普通西红柿甜N倍！",
 "price":"6.50",
 "sold_img":"",
 "icon":"http://imgcdn.xuxian.com/upload/2016/04/08/20160408122252663_400_300.jpg",
 "store_nums":"2147483647",
 "sold_num":"48",
 "category_id":"137",
 "store_num":2147483599,
 "corver":[ ],
 "details2":"http://mobile.xuxian.com/goods/getGoodsDetail/800?ver=2015121401",
 "selltype":"",
 "tipsimg":"http://imgcdn.xuxian.com/upload/2016/05/16/20160516165329905.png",
 "phonetips":"http://imgcdn.xuxian.com/upload/2016/05/16/20160516165329931.png",
 "show":"1",
 "starttime":"2016-08-20 01:00:00",
 "endtime":"2016-08-29 01:00:00",
 "laouser":"6.66",
 "fromid":"53",
 "category_tips":{
 "txt":"圣女果",
 "f_color":"ffd040",
 "b_color":"ffffff"
 },
 "newuserprice":"0.00",
 "group_price":[
 ],
 "show_imgs":[
 "http://imgcdn.xuxian.com/upload/2016/08/09/20160809111005917.png"
 ],
 "price_info":"非会员价:￥6.66/份",
 "rulestips":"",
 "bannertype":1,
 "is_directlyadd":"0",
 "message":"800",
 "goods_sort":"0"
 
 */

@end

