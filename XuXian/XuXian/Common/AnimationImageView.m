//
//  AnimationImageView.m
//  XuXian
//
//  Created by 吴旭健 on 16/8/20.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "AnimationImageView.h"

@implementation AnimationImageView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _creatImageView];
    }
    return self;
}

-(void)_creatImageView{
    // 设置正在刷新状态的动画图片
    NSMutableArray *imgArr = [NSMutableArray array];
    for (NSInteger i = 0; i<24; i++) {
        NSString *imgName = [NSString stringWithFormat:@"loading跑步00%lu.png",i+1];
        UIImage *img = [UIImage imageNamed:imgName];
        [imgArr addObject:img];
    }
    
    self.animationImages = imgArr;
    self.animationDuration = 1.5;
    self.animationRepeatCount = 3;
}

@end
