//
//  CollectionView.m
//  XuXian
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "CollectionView.h"
#import "CollectionViewCell.h"
#import "GoodsModel.h"
#import "Common.h"
#import "YYModel.h"

@interface CollectionView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    NSMutableArray *_dataArr;
}
@end


@implementation CollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self = [super initWithFrame:frame collectionViewLayout:_flowLayout];
    if (self) {
        _dataArr = [NSMutableArray array];
        _flowLayout.itemSize = CGSizeMake((kScreenWidth -5)/2, (kScrennHeight -64-44)/2.0 -10);
        _flowLayout.minimumInteritemSpacing =5;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    }
    return self;
}

-(void)setGoodsArray:(NSArray *)goodsArray{
    _goodsArray = goodsArray;
    for (NSDictionary *goodsDic in _goodsArray) {
        GoodsModel *model =[GoodsModel yy_modelWithDictionary:goodsDic];
        [_dataArr addObject:model];
    }
    
    [self reloadData];
}

#pragma mark - Navigation
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * collectionCell = @"CollectionCell";
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
    GoodsModel * model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

@end
