//
//  ShoppingCartViewController.m
//  XuXian
//
//  Created by 吴旭健 on 16/8/16.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "ShoppingCarCell.h"
#import "ShoppingModel.h"
#import "Common.h"
@interface ShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate,ShoppingCarCellDelegate>
@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UIButton *selectAllBtn;//全选按钮

@property (nonatomic,strong) UIButton *jieSuanBtn;//结算按钮
@property (nonatomic,strong) UILabel *totalMoneyLab;//总金额

@property(nonatomic,assign) float allPrice;

@end

@implementation ShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.dataArray = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.allPrice = 0.00;
    [self createSubViews];
    [self initData];
}
/**
 * 初始化假数据
 */

-(void)initData{
    
    
    for (int i = 0; i<10; i++)
    {
        NSMutableDictionary *infoDict = [[NSMutableDictionary alloc]init];
        [infoDict setValue:@"img.png" forKey:@"imageName"];
        [infoDict setValue:@"小皮皮" forKey:@"goodsTitle"];
        [infoDict setValue:@"Miss?怎么可能..." forKey:@"goodsType"];
        [infoDict setValue:@"50.00" forKey:@"goodsPrice"];
        [infoDict setValue:[NSNumber numberWithBool:NO] forKey:@"selectState"];
        [infoDict setValue:[NSNumber numberWithInt:1] forKey:@"goodsNum"];
        
        ShoppingModel *goodsModel = [[ShoppingModel alloc]initWithShopDict:infoDict];
        
        [self.dataArray addObject:goodsModel];
    }
    
    
}

-(void)createSubViews{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , kScreenWidth, kScrennHeight-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake(10,self.tableView.bottom+(50-20)/2.0, 60, 20);
    [self.selectAllBtn setImage:IMAGENAMED(@"check_n") forState:UIControlStateNormal];
    [self.selectAllBtn setImage:IMAGENAMED(@"check_p") forState:UIControlStateSelected];
    [self.selectAllBtn addTarget:self action:@selector(selectAllaction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
    [self.selectAllBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.selectAllBtn.titleLabel.font = SYSTEMFONT(15.0);
    self.selectAllBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.selectAllBtn];
    
    
    
    self.totalMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(self.selectAllBtn.right+10, self.selectAllBtn.top, kScreenWidth-self.selectAllBtn.right-30-GetWidth(184),20)];
    
    self.totalMoneyLab.textAlignment = NSTextAlignmentCenter;
    self.totalMoneyLab.font = SYSTEMFONT(13.0);
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:SYSTEMFONT(17) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    
    
    [self.view addSubview:self.totalMoneyLab];
    
    
    self.jieSuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jieSuanBtn.frame = CGRectMake(kScreenWidth-GetWidth(184)-10,self.tableView.bottom+(50-GetHeight(74))/2.0,GetWidth(184), GetHeight(74));
    [self.jieSuanBtn setBackgroundColor:RGBACOLOR(0, 189, 155, 1)];
    [self.jieSuanBtn addTarget:self action:@selector(jieSuanAction) forControlEvents:UIControlEventTouchUpInside];
    self.jieSuanBtn.layer.masksToBounds = YES;
    self.jieSuanBtn.layer.cornerRadius = GetHeight(74)/2.0;
    [self.jieSuanBtn setTitle:@"结算" forState:UIControlStateNormal];
    
    [self.jieSuanBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.jieSuanBtn.titleLabel.font = SYSTEMFONT(15.0);
    self.jieSuanBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self.view addSubview:self.jieSuanBtn];
    
    
    
}
//结算
-(void)jieSuanAction{
    
    NSLog(@"结算");
    
}

//全选
-(void)selectAllaction:(UIButton *)sender{
    
    
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        sender.selected = YES;
    }else{
        sender.selected = NO;
        
    }
    //改变单元格选中状态
    for (int i=0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        model.selectState = sender.tag;
    }
    
    [self CalculationPrice];
    
    [self.tableView reloadData];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellStr = @"ShopCarCell";
    
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
    if(!cell){
        
        cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        
        
    }
    
    
    
    cell.delegate = self;
    cell.shoppingModel = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return 110;
}



//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     * 判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    ShoppingModel *model = self.dataArray[indexPath.row];
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }
    
    //刷新当前行
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self CalculationPrice];
}

#pragma mark -- 实现加减按钮点击代理事件
/**
 * 实现加减按钮点击代理事件
 *
 * @param cell 当前单元格
 * @param flag 按钮标识，11 为减按钮，12为加按钮
 */



-(void)btnClick:(UITableViewCell *)cell andFlag:(int)flag
{
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    switch (flag) {
        case 11:
        {
            //做减法
            //先获取到当期行数据源内容，改变数据源内容，刷新表格
            ShoppingModel *model = self.dataArray[index.row];
            if (model.goodsNum > 1)
            {
                model.goodsNum --;
            }
        }
            break;
        case 12:
        {
            //做加法
            ShoppingModel *model = self.dataArray[index.row];
            model.goodsNum ++;
        }
            break;
        default:
            break;
    }
    //刷新表格
    [self.tableView reloadData];
    //计算总价
    [self CalculationPrice];
}
//计算价格
-(void)CalculationPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格(单价 * 商品数量)
    for ( int i =0; i<self.dataArray.count;i++)
    {
        ShoppingModel *model = self.dataArray[i];
        if (model.selectState)
        {
            self.allPrice = self.allPrice + model.goodsNum *[model.goodsPrice intValue];
        }
    }
    //给总价赋值
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"总金额:￥%.2f元",self.allPrice]];
    [str addAttribute:NSFontAttributeName value:SYSTEMFONT(17) range:NSMakeRange(4,str.length-4)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(4,str.length-4)];
    self.totalMoneyLab.attributedText = str;
    
    NSLog(@"%f",self.allPrice);
    
    self.allPrice = 0.0;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor whiteColor];
}


@end
