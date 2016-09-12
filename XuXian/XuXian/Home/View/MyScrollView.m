//
//  MyScrollView.m
//  XuXian
//
//  Created by Macx on 16/8/24.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "MyScrollView.h"
#import "Common.h"
#import "UIImageView+WebCache.h"
#import "GoodsView.h"
#import "YYModel.h"
#import "GoodsModel.h"
#import "MyTableView.h"
#import "CollectionView.h"

@interface MyScrollView (){
    CGFloat _tbHeight;
    CGFloat _collectionViewHeight;
    
}
@property(nonatomic,strong)CollectionView *collectionView;

@end

@implementation MyScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _isList = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        self.scrollEnabled =YES;
        self.showsVerticalScrollIndicator =YES;
    }
    return self;
}
-(CollectionView*)collectionView{
    if (_collectionView ==nil) {
        _collectionView = [[CollectionView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, kScrennHeight)];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self insertSubview:_collectionView belowSubview:_tbView];
    }
    return _collectionView;
}

-(void)setBlockArr:(NSArray *)blockArr{
    _blockArr = blockArr;
    _height =0;
    for (NSInteger i = 0; i<blockArr.count; i++) {
        NSArray *adArr =blockArr[i];
        if (i == 0) {
            NSDictionary *adDic = adArr[0];
            NSString *ht = adDic[@"allheight"];
            UIScrollView *adScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [ht floatValue] * kScrennHeight -69-18)];
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:adScrollView.bounds];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            NSArray *saleAsArr =adDic[@"sale_as"];
            NSDictionary *saleAsDic =saleAsArr[0];
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:saleAsDic[@"bannerimg"]]];
            [adScrollView addSubview:imgView];
            [self addSubview:adScrollView];
            _height +=adScrollView.bottom;
        } else if (i == 1) {
            
        } else {
            if (adArr.count ==2) {
                NSDictionary *dic0 =adArr[0];
                NSString *ht =dic0[@"allheight"];
//                NSLog(@"%@",ht);
                UIView *sectionItemview = [[UIView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth,[ht floatValue] *(kScrennHeight /2.0))];
                
                sectionItemview.backgroundColor = [UIColor whiteColor];
                [self addSubview:sectionItemview];

                NSString *imgHt= dic0[@"height"];
                UIImageView *adImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, [imgHt floatValue] *kScrennHeight/2.0)];
                NSArray *saleAsArr = dic0[@"sale_as"];
                NSDictionary *saleAsDic =saleAsArr[0];
                [adImgView sd_setImageWithURL:[NSURL URLWithString:saleAsDic[@"bannerimg"]]];
                [sectionItemview addSubview:adImgView];
                _height +=sectionItemview.height;
                
                NSDictionary *dic1 =adArr[1];
                NSArray *goodslistArr = dic1[@"goodslist"];
                
                CGFloat sectionHt = adImgView.height;
                
                CGFloat itemHt = [dic1[@"height"] floatValue]/3.0 *kScrennHeight/2.0;
                for (NSDictionary *goodsDic in goodslistArr) {
                    GoodsModel *model = [GoodsModel yy_modelWithDictionary:goodsDic];
                    GoodsView *goodsView = [[[NSBundle mainBundle] loadNibNamed:@"GoodsView" owner:nil options:nil]lastObject];
                    goodsView.frame = CGRectMake(0, sectionHt , kScreenWidth, itemHt );
                    goodsView.model = model;
                    goodsView.backgroundColor = [UIColor whiteColor];
                    [sectionItemview addSubview:goodsView];
                    sectionHt +=itemHt;
                }
            } else if(adArr.count ==1){
            }
        }
    }
    self.contentSize =CGSizeMake(kScreenWidth, _height);
//    self.height =height;
}

-(void)setGoodsArray:(NSArray *)goodsArray{
    _goodsArray = goodsArray;
    

    _tbView = [[MyTableView alloc]initWithFrame:CGRectMake(10, _height, kScreenWidth-10, 1.08/3.0 *kScrennHeight/2.0 * _goodsArray.count)];
    _tbView.goodsArray = _goodsArray;
    [self addSubview:_tbView];
    _tbHeight = 1.08/3.0 *kScrennHeight/2.0 * _goodsArray.count;
    self.contentSize =CGSizeMake(kScreenWidth, _height + _tbHeight);
    
    self.collectionView.goodsArray = _goodsArray;
    self.collectionView.height = _goodsArray.count/2 * (kScrennHeight -64-44)/2.0 -10;
    _collectionViewHeight = self.collectionView.height;
    self.collectionView.hidden = YES;

}
-(void)setIsList:(BOOL)isList{
    _isList = isList;
        if (!_isList) {
            self.tbView.hidden = NO;
            self.collectionView.hidden = YES;
            self.contentSize =CGSizeMake(kScreenWidth, _height + _tbHeight);
        } else{
            
            self.tbView.hidden = YES;
            self.collectionView.hidden = NO;
            self.contentSize =CGSizeMake(kScreenWidth,_height +_collectionViewHeight);
        }
}

@end
