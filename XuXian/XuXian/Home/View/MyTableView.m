//
//  MyTableView.m
//  XuXian
//
//  Created by Michael Luo on 8/24/16.
//  Copyright © 2016 Fxxx. All rights reserved.
//

#import "MyTableView.h"
#import "YYModel.h"
#import "GoodsView.h"
#import "GoodsModel.h"
#import "Common.h"
#import "GoodsViewController.h"
#import "HomeViewController.h"


@interface MyTableView  ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArr;
}

@end

@implementation MyTableView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.rowHeight =1.08/3.0 *kScrennHeight/2.0;
        _dataArr = [NSMutableArray array];
    }
    return self;
}

-(void)setGoodsArray:(NSArray *)goodsArray{
    _goodsArray =goodsArray;
    
    for (NSDictionary *goodsDic in _goodsArray) {
        GoodsModel *model =[GoodsModel yy_modelWithDictionary:goodsDic];
        [_dataArr addObject:model];
    }
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];

        GoodsView *goodsView = [[[NSBundle mainBundle] loadNibNamed:@"GoodsView" owner:nil options:nil]lastObject];
        goodsView.frame = CGRectMake(10, 0, kScreenWidth-10, 1.08/3.0 *kScrennHeight/2.0);
        goodsView.model = _dataArr[indexPath.row];
        goodsView.userInteractionEnabled = NO;
        
        cell.accessoryView = goodsView;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsViewController *ctr = [[GoodsViewController alloc]init];
    ctr.model = _dataArr[indexPath.row];
    [self.viewCtl  presentViewController:ctr animated:YES completion:nil];
//    [self.viewCtl.navigationController pushViewController:ctr animated:YES];
}

- (UIViewController *)viewCtl{
    UIResponder *responder = self.nextResponder;
    
    do {
        if ([responder isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)responder;
        }
        
        responder = responder.nextResponder;
        
    } while (responder!= nil);
    
    
    return nil;
}

@end
