//
//  FruitCell.m
//  XuXian
//
//  Created by Macx on 16/8/21.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "FruitCell.h"
#import "UIImageView+WebCache.h"
@interface FruitCell(){
    UIImageView *imageView;
}
@end
@implementation FruitCell
//重写initWithFrame
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self _createSubViews];
    }
    return self;
}

//
- (void)_createSubViews
{
    //创建UIImageView
    imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    //设置imageView的显示模式,自适应比例显示
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //添加imageView到contentView
    [self.contentView addSubview:imageView];
}
- (void)setImageURl:(NSString *)imageURl
{
    _imageURl = imageURl;
    //加载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:_imageURl] placeholderImage:[UIImage imageNamed:@"个人信息.png"]];
}

@end
