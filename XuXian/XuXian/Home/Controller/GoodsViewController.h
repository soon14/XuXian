//
//  GoodsViewController.h
//  XuXian
//
//  Created by mac on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"


@interface GoodsViewController : UIViewController<UIScrollViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong)GoodsModel * model;
@end
