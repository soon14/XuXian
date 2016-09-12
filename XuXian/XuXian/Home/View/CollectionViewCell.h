//
//  CollectionViewCell.h
//  XuXian
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GoodsModel;
@interface CollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *main_name;


@property (strong, nonatomic) IBOutlet UILabel *main_name_title;
@property (strong, nonatomic) IBOutlet UIImageView *bgImgView;
@property (strong, nonatomic) IBOutlet UILabel *market_price;

@property (strong, nonatomic) IBOutlet UILabel *price_info;
@property (strong, nonatomic) IBOutlet UIImageView *tipsimg;

@property(strong,nonatomic)GoodsModel *model;

@end
