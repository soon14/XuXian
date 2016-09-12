//
//  LeftViewController.m
//  XuXian
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "LeftViewController.h"
#import "AFNetworking.h"
#import "LeftModel.h"
#import "YYModel.h"
#import "Common.h"
#import "FruitCell.h"

@interface LeftViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    UICollectionViewFlowLayout *_flowLayout;
    UICollectionView *_collectionView;
    NSMutableArray *_imgArr;
    //创建一个翻转的方向
    BOOL left;
}
@property(nonatomic,strong)UIView *fruitView;
@property(nonatomic,strong)UIView *foodView;

@end

@implementation LeftViewController
//-(UIView *)_fruitView{
//    if (_fruitView ==nil) {
//        _fruitView =[[UIView alloc]initWithFrame:CGRectMake(0, 108, 220, kScrennHeight - 123)];
//        _fruitView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"底纹.jpg"]];
//
//
//        [self.view insertSubview:_fruitView belowSubview:_collectionView];
//    }
//    return _fruitView;
//}

//-(UIView *)_foodView{
//    if (_foodView ==nil) {
//        _foodView =[[UIView alloc]initWithFrame:CGRectMake(0, 108, 220, kScrennHeight - 123)];
//        _foodView.backgroundColor = [UIColor yellowColor];
//        [self.view insertSubview:_foodView belowSubview:self.fruitView];
//    }
//    return _foodView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    left = YES;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self _createCollection];
    _fruitView =[[UIView alloc]initWithFrame:CGRectMake(0, 108, 245, kScrennHeight - 123)];
    _fruitView.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:_fruitView belowSubview:_collectionView];
    NSString *url = @"http://mobile.xuxian.com/category/getInfos/1";
    [self _loadData:url];
    
    
}

-(void)_loadData:(NSString *)url{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    NSMutableDictionary *param=[@{@"ver":@"2016072801",
                                  @"__t":@"1471487983.224587"}mutableCopy];
    [manager GET:url parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [self _processLeftResponse:responseObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"failed");
    }];
}

-(void)_createCollection{
    _flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _flowLayout.itemSize =CGSizeMake(60, 70);
    _flowLayout.minimumLineSpacing = 10;
    _flowLayout.minimumInteritemSpacing = 10;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(15, 123, 220, kScrennHeight - 123) collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
    [_collectionView registerClass:[FruitCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:_collectionView];
}

-(void)_processLeftResponse:(id)response{
    _imgArr = [NSMutableArray array];
    NSDictionary *respDic = (NSDictionary*)response;
    NSArray *tempArr = respDic[@"data"];
    NSDictionary *firstDic =[tempArr firstObject];
    NSArray *dataArr = firstDic[@"data"];
    for (NSDictionary *dic in dataArr) {
        LeftModel *model = [[LeftModel alloc]init];
        model = [LeftModel yy_modelWithDictionary:dic];
        [_imgArr addObject:model];
    }
}
- (IBAction)ButtonAction:(UIButton *)sender {
    //获取buttonView
    left =! left;
    UIView *buttonView = sender.superview;
    UIButton * button1 = (UIButton *)[buttonView viewWithTag:1000];
    UIButton * button2 = (UIButton *)[buttonView viewWithTag:1001];
    if (sender.tag == 1000) {
        button1.backgroundColor = [UIColor grayColor];
        button2.backgroundColor = [UIColor lightGrayColor];
        NSString *url =@"http://mobile.xuxian.com/category/getInfos/1";
        [self _loadData:url];
        //选择选择的方向
        [self flip:_collectionView left:left];
    }
    
    if (sender.tag == 1001) {
        button1.backgroundColor = [UIColor lightGrayColor];
        button2.backgroundColor = [UIColor grayColor];
        NSString *url =@"http://mobile.xuxian.com/category/getInfos/188";
        [self _loadData:url];
        [self flip:_collectionView left:left];
    }
}

//把代码抽出来 实现翻转
- (void)flip:(UIView *)forView left:(BOOL)flag{
    //判断翻转的方向
    UIViewAnimationOptions filp = flag?
UIViewAnimationOptionTransitionFlipFromLeft:
    UIViewAnimationOptionTransitionFlipFromRight;
    
    [UIView transitionWithView:forView duration:1
                       options:filp
                    animations:^{
                        [forView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
                    } completion:NULL];
    
}
#pragma mark - collectionView delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imgArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FruitCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    LeftModel *model = _imgArr[indexPath.row];
    cell.imageURl =model.icon;
    return cell;
}

@end