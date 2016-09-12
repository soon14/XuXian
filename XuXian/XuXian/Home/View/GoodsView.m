//
//  GoodsView.m
//  XuXian
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "GoodsView.h"
#import "GoodsModel.h"
#import "Common.h"
#import "YYModel.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"

@implementation GoodsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.buyAddBtn.hidden =YES;
        self.buyTagImgView.hidden = YES;
        self.buySubstractBtn.hidden = YES;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)setModel:(GoodsModel *)model{
    _model = model;
    _icon.frame = CGRectMake(10, 5, 100, self.height - 20);
    NSLog(@"--%f--", self.height);
    [_icon sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    if (_model.show_imgs) {
        _show_imgs.frame = CGRectMake(60, 5, 30, 35);
        [_show_imgs sd_setImageWithURL:[NSURL URLWithString:_model.show_imgs[0]]];
    } else {_show_imgs.frame = CGRectZero;}
    
    _category_tips_txt.frame = CGRectMake(15, _icon.bottom +5, 35, 10);
    _category_tips_txt.text = model.category_tips[@"txt"];

    if (_model.tipsimg) {
        _tipsimg.frame= CGRectMake(_category_tips_txt.right +5, _icon.bottom +2, 50, 13);
        [_tipsimg sd_setImageWithURL:[NSURL URLWithString:_model.tipsimg]];
    }else {_tipsimg.frame = CGRectZero;}

    
    _main_name.frame = CGRectMake(_icon.right+10, 5, kScreenWidth - _icon.right-20, _icon.height/5.0 -5);
    _main_name.text = _model.main_name;

    
    _main_name_title.frame = CGRectMake(_main_name.left, _main_name.bottom+5, _main_name.width, _icon.height/5.0 -5);
    _main_name_title.text = _model.title;
    
    _price_bg_imgview.frame = CGRectMake(_main_name_title.left, _main_name_title.bottom+5, kScreenWidth /2.0-50, _icon.height*2/5.0 -5);
    _price_bg_imgview.backgroundColor = [UIColor clearColor];

    _price_info_discount.frame = _price_bg_imgview.frame;
    _price_info_discount.text = _model.price;
    _price_info_discount.backgroundColor = [UIColor clearColor];
    
    _price_info.frame = CGRectMake(_price_bg_imgview.left, _price_bg_imgview.bottom +5, kScreenWidth -_icon.right-20, _icon.height/5.0 -5);
    _price_info.text = model.price_info;
    

    _buyButton.frame = CGRectMake(kScreenWidth -40, _icon.bottom - 20, 20, 20);
    [_buyButton setImage:[UIImage imageNamed:@"VipSelected.png"] forState:UIControlStateNormal];
}

@end
