//
//  CollectionViewCell.m
//  XuXian
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "CollectionViewCell.h"
#import "GoodsModel.h"
#import "Common.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"


@implementation CollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"CollectionViewCell" owner:self options:nil]firstObject];
//        self.width= (kScreenWidth -5)/2;
//        self.height = (kScrennHeight -64-44-10)/2.0;
//         _flowLayout.itemSize = CGSizeMake((kScreenWidth -5)/2, (kScrennHeight -64-44-5)/2.0);
        _icon.frame =CGRectMake(0, 0, (kScreenWidth -5)/2, (kScrennHeight -64-44)/2.0*5/9.0);
        _main_name.frame = CGRectMake(5, _icon.bottom+5, _icon.width - 5, 20);
        _main_name_title.frame = CGRectMake(5, _main_name.bottom, _main_name.width, 30);
        _bgImgView.frame = CGRectMake(5, _main_name_title.bottom, _main_name.width/2, 20);
        _market_price.frame =_bgImgView.frame;
        _tipsimg.frame = CGRectMake(_icon.right - 65, _bgImgView.top +5, 60, 20);
        _price_info.frame =CGRectMake(5, _bgImgView.bottom, _main_name.width, 20);
        _model = [[GoodsModel alloc]init];
 
    }
    return self;
}
-(void)setModel:(GoodsModel *)model{
    _model = model;
    NSLog(@"%@",_model);
    [_icon sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    _main_name.text = _model.main_name;
    _main_name_title.text = _model.title;
    _market_price.text = _model.price;
    _price_info.text = _model.price_info;
    if (_model.tipsimg) {

        [_tipsimg  sd_setImageWithURL:[NSURL URLWithString:_model.tipsimg]];
    } else{
        _tipsimg.image =nil;
    }
    
}
@end
