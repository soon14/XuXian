//
//  ShareView.m
//  XuXian
//
//  Created by 吴旭健 on 16/8/17.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "ShareView.h"
#import "Common.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDKUI.h>

@implementation ShareView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _createShareView];
    }
    return self;
}

-(void)_createShareView{
    
    
    
    self.frame = CGRectMake(0, 0, kScreenWidth, kScrennHeight);
    //    self.backgroundColor = [UIColor blueColor];
    /*
     UIView *view = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/6/2, kScrennHeight/6/2, kScreenWidth/6*5, kScrennHeight/6*5)];
     view.backgroundColor = [UIColor yellowColor];
     */
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth/6/2, kScrennHeight/6/2, kScreenWidth/6*5, kScrennHeight/6*5)];
    imgView.image = [UIImage imageNamed:@"shareBGimg"];
    imgView.userInteractionEnabled = YES;
    
    
    //分享给微信好友
    UIButton *friendButton = [[UIButton alloc] initWithFrame:CGRectMake(imgView.frame.origin.x+10, imgView.frame.size.height/9*6, imgView.frame.size.width-60, imgView.frame.size.height/9)];
    [friendButton setTitle:@"分享好友" forState:UIControlStateNormal];
    [friendButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    friendButton.titleLabel.font = [UIFont boldSystemFontOfSize:23];
    friendButton.backgroundColor = [UIColor blueColor];
    
    [friendButton addTarget:self action:@selector(shareFriendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //分享给微信朋友圈
    UIButton *circleButton = [[UIButton alloc] initWithFrame:CGRectMake(imgView.frame.origin.x+10, imgView.frame.size.height/9*7.5, imgView.frame.size.width-60, imgView.frame.size.height/9)];
    [circleButton setTitle:@"分享朋友圈" forState:UIControlStateNormal];
    [circleButton setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    circleButton.titleLabel.font = [UIFont boldSystemFontOfSize:23];
    circleButton.backgroundColor = [UIColor blueColor];
    
    [imgView addSubview:friendButton];
    [imgView addSubview:circleButton];
    [self addSubview:imgView];
    
    
}


//分享给好友
-(void)shareFriendAction:(UIButton *)button{
    
    NSLog(@"------------");
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"2-132.png"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    
    
}


@end
