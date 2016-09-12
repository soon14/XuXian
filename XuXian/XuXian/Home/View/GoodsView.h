//
//  GoodsView.h
//  XuXian
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@interface GoodsView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UIImageView *show_imgs;
@property (strong, nonatomic) IBOutlet UILabel *category_tips_txt;
@property (strong, nonatomic) IBOutlet UIImageView *tipsimg;
@property (strong, nonatomic) IBOutlet UILabel *main_name;
@property (strong, nonatomic) IBOutlet UILabel *main_name_title;
@property (strong, nonatomic) IBOutlet UIImageView *price_bg_imgview;
@property (strong, nonatomic) IBOutlet UILabel *price_info_discount;

@property (strong, nonatomic) IBOutlet UILabel *price_info;

@property (strong, nonatomic) IBOutlet UIButton *buyButton;
@property (strong, nonatomic) IBOutlet UIImageView *buyTagImgView;
@property (strong, nonatomic) IBOutlet UILabel *price_label;
@property (strong, nonatomic) IBOutlet UIButton *buyAddBtn;
@property (strong, nonatomic) IBOutlet UIButton *buySubstractBtn;

@property (strong, nonatomic)GoodsModel *model;
@end
