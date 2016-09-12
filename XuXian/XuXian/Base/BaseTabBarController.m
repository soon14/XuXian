//
//  BaseTabBarController.m
//  XuXian
//
//  Created by mac on 16/8/16.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "BaseTabBarController.h"
#import "Common.h"


@interface BaseTabBarController ()
{
    UIImageView * _selectView;
}
@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createCtrs];
    [self _removeSubViews];
    [self _createTabBarItem];
}

- (void) _createCtrs{
    NSArray * names = @[@"Home", @"Distribution", @"ShoppingCart", @"Scan", @"Mine"];
    NSMutableArray * subCtrs = [NSMutableArray array];
    for (NSString * name in names) {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:name bundle:nil];
        [subCtrs addObject:sb.instantiateInitialViewController];
    }
    self.viewControllers = subCtrs;
}

- (void) _removeSubViews{
    Class tabBarButton = NSClassFromString(@"UITabBarButton");
    for (UIView * view in self.tabBar.subviews) {
        if ([view isKindOfClass:tabBarButton]) {
            [view removeFromSuperview];
        }
    }
}

- (void) _createTabBarItem{
    self.tabBar.backgroundImage = [UIImage imageNamed:@"aa_81.png"];
    self.tabBar.clipsToBounds = YES;
    NSArray * imgNames = @[@"60首页@2x.png", @"60附近@2x.png", @"60购物车@2x.png", @"60付款@2x.png", @"60我的@2x.png"];
    NSArray * labelNames = @[@"首页", @"全国送", @"购物车", @"扫码", @"我的"];
    CGFloat width = kScreenWidth / 5;
    CGFloat height = self.tabBar.bounds.size.height;
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _selectView.image = [UIImage imageNamed:@"aa_78.png"];
    [self.tabBar addSubview:_selectView];
    
    for (NSInteger i = 0; i < 5; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * width, 0, width, height - 10);
        button.tag = i;
        [button setImage:[UIImage imageNamed:imgNames[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:button];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(i * width, CGRectGetMaxY(button.frame), width, 7)];
        label.text = labelNames[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [self.tabBar addSubview:label];
        
    }
    
    
}

- (void) _buttonAction:(UIButton *)button{
    self.selectedIndex = button.tag;
    self.tabBar.hidden = NO;
    [UIView animateWithDuration:.3 animations:^{
        _selectView.center = CGPointMake(button.center.x, self.tabBar.bounds.size.height / 2);
    }];
}

@end
