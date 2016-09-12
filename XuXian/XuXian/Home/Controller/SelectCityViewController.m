//
//  SelectCityViewController.m
//  XuXian
//
//  Created by Macx on 16/8/18.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "SelectCityViewController.h"
#import "MapManager.h"
#import "Common.h"
#import <CoreLocation/CoreLocation.h>
#import "AddressViewController.h"
@interface SelectCityViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //    CLLocationManager *_cllocationManager;
    //    double lati;
    //    double longi;
    NSDictionary * _dic;
    NSArray *_sortedKeys;
    NSString *_cityName;
}

@property (strong, nonatomic) IBOutlet UITableView *cityTableView;

@end

@implementation SelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.title = @"城市列表";
    // Do any additional setup after loading the view.
    //    [self setMap];

    [self _loadCityList];
    [self _createHeadView];
}

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden =NO;
}

-(void)_loadCityList{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
    _dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSArray *keys = [_dic allKeys];
    _sortedKeys = [NSArray array];
    _sortedKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
}

-(void)_createHeadView{
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    //    定位@2x.png
    UIImageView *locateImgView = [[UIImageView alloc]initWithFrame:CGRectMake(30, 10, 15, 20)];
    locateImgView.backgroundColor = [UIColor clearColor];
    locateImgView.image = [UIImage imageNamed:@"定位@2x.png"];
    [headView addSubview:locateImgView];
    
    UILabel *gpsLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10, 70, 20)];
    gpsLabel.backgroundColor = [UIColor clearColor];
    gpsLabel.text = @"GPS 定位";
    gpsLabel.textColor = [UIColor grayColor];
    gpsLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:gpsLabel];
    
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 10, 150, 20)];
    
    _cityLabel.backgroundColor = [UIColor clearColor];
    MapManager *mapManager =[MapManager shareManager];
    
    _cityLabel.text = mapManager.cityName;
    _cityLabel.font = [UIFont systemFontOfSize:14];
    [headView addSubview:_cityLabel];
    
    _cityTableView.tableHeaderView = headView;
}

#pragma mark - tableView Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sortedKeys.count;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return _sortedKeys;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *valueArr = [_dic valueForKey:_sortedKeys[section]];
    return valueArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return _sortedKeys[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID =@"cellID";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSArray *valueArr = [_dic valueForKey:_sortedKeys[indexPath.section]];
    cell.textLabel.text =valueArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AddressViewController *addressCtr =  [self.navigationController.viewControllers objectAtIndex:1];
    NSArray *valueArr = [_dic valueForKey:_sortedKeys[indexPath.section]];
    addressCtr.selectedCity =valueArr[indexPath.row];
    NSLog(@"%@",valueArr[indexPath.row]);
    [self.navigationController popToViewController:addressCtr  animated:YES];
    
}

@end
