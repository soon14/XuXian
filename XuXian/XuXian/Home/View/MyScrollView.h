//
//  MyScrollView.h
//  XuXian
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyTableView;
@class CollectionView;

@interface MyScrollView : UIScrollView
@property(nonatomic,strong)NSArray *blockArr;
@property(nonatomic,strong)NSArray *goodsArray;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)BOOL isList;

@property(nonatomic,strong)MyTableView *tbView;


@end
