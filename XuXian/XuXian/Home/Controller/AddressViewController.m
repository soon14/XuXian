//
//  AddressViewController.m
//  XuXian
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "AddressViewController.h"
#import "SelectCityViewController.h"
#import <MapKit/MapKit.h>
#import "Common.h"
#import "MapManager.h"
#import "DataService.h"
#import "AnnotationModel.h"
#import "StoreList.h"
#import "StoreItem.h"

@interface AddressViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIButton * button1;
    UIButton * button2;
    UIPickerView *_pickerView;
}

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市列表";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    //  remove black bar under tabBar
    self.hidesBottomBarWhenPushed = YES;
    
    UIImage *img = [UIImage imageNamed:@"aa_78.png"];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
    MapManager *manager = [MapManager shareManager];
    manager.mapView.frame = CGRectMake(0, 64, kScreenWidth, 200);
    if (_dataService.annotionArray) {
        manager.coordinateArray = _dataService.annotionArray;
    }
    [self.view addSubview: manager.mapView];
    [self _createSegmentedControl];
    [self _createSearchButton];
    [self _createCityList];
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden =YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    self.tabBarController.tabBar.hidden =NO;
}
#pragma mark - Segmented Control Creation
-(void)_createSegmentedControl{
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"自提点",@"配送",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    segmentedControl.frame = CGRectMake(70, 5,100, 30);
    //color when pressed
    segmentedControl.tintColor = [UIColor blackColor];
    segmentedControl.selectedSegmentIndex = 0;
    //font
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor blackColor], NSForegroundColorAttributeName, nil];
    [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    //设置分段控件点击相应事件
    [segmentedControl addTarget:self action:@selector(segmentAction:)forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentedControl];
    [self _loadNavigationItem];
}

-(void)segmentAction:(UISegmentedControl *)seg{
    NSInteger Index = seg.selectedSegmentIndex;
    switch (Index){
        case 0:
            button1.hidden = NO;
            button2.hidden = YES;
            break;
        case 1:
            button2.hidden = NO;
            button1.hidden = YES;
            break;
        default:
            break;
    }
}
- (void)_loadNavigationItem{
    //1:翻转的父视图
    UIView * buttonView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth - 60, 0, 60, 30)];
    //2:创建右侧的两个Button
    button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = buttonView.bounds;
    [button1 setBackgroundColor:[UIColor clearColor]];
    //添加点击事件
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button1.tag = 200;
    //ImageView
    UIImageView *locateImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 20, 20)];
    locateImgView.backgroundColor = [UIColor clearColor];
    locateImgView.image = [UIImage imageNamed:@"XXaddressMap1.png"];
    [button1 addSubview:locateImgView];
    UILabel *cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 60-20, 20)];
    cityLabel.text = @"北京市";
    cityLabel.font = [UIFont systemFontOfSize:12];
    cityLabel.backgroundColor = [UIColor clearColor];
    [button1 addSubview:cityLabel];
    [buttonView addSubview:button1];
    button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = buttonView.bounds;
    [button2.layer setMasksToBounds:YES];
    [button2.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    //边框宽度
    [button2.layer setBorderWidth:1.0];
    button2.hidden = YES;
    button2.backgroundColor = [UIColor clearColor];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    button2.tag = 201;
    UILabel *cityListLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 20)];
    cityListLabel.text = @"城市列表";
    cityLabel.textAlignment = NSTextAlignmentCenter;
    cityListLabel.font = [UIFont systemFontOfSize:13];
    cityListLabel.backgroundColor = [UIColor clearColor];
    [button2 addSubview:cityListLabel];
    [buttonView addSubview:button2];
    //把父视图添加到导航栏的右边
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:buttonView];
    self.navigationItem.rightBarButtonItem  = rightItem;
}

-(void)buttonAction:(UIButton *)button{
    if (button.tag == 201) {
        SelectCityViewController *cityCtr = [[UIStoryboard storyboardWithName:@"Home" bundle:nil]instantiateViewControllerWithIdentifier:@"selectCityCtr"];
        [self.navigationController pushViewController:cityCtr animated:YES];
    }
    
}

#pragma mark - search button creation
-(void)_createSearchButton{
    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 269, kScreenWidth -20, 30)];
    searchButton.backgroundColor = [UIColor clearColor];
    searchButton.layer.cornerRadius = 5.0;
    searchButton.userInteractionEnabled = YES;
    searchButton.layer.borderWidth =1.0;
    searchButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:searchButton];
    UILabel *searchLbl = [[UILabel alloc]initWithFrame:searchButton.bounds];
    searchLbl.backgroundColor = [UIColor clearColor];
    searchLbl.font = [UIFont systemFontOfSize:12];
    searchLbl.textColor =[UIColor lightGrayColor];
    searchLbl.text =@"搜索提货点";
    searchLbl.textAlignment =NSTextAlignmentCenter;
    [searchButton addSubview:searchLbl];
    [searchButton addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)searchAction{
    NSLog(@"search button clicked");
}

#pragma mark - City List Creation
-(void)_createCityList{
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 300, kScreenWidth, kScrennHeight - 300)];
    
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self.view addSubview:_pickerView];
}

#pragma mark - pickerView Delegate Method
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}



// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return _dataService.storeArray.count;
    }
    NSInteger row = [pickerView selectedRowInComponent:0];
    StoreList *storeList = _dataService.storeArray[row];
    return storeList.storeArr.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component ==0) {
        StoreList *storeList = _dataService.storeArray[row];
        return storeList.area_name;
    }
    NSInteger index = [pickerView selectedRowInComponent:0];
    StoreList *storeList = _dataService.storeArray[index];
    StoreItem *storeItem = storeList.storeArr[row];
    return storeItem.area;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

#pragma mark - city selected method
-(void)setSelectedCity:(NSString *)selectedCity{
    
    _selectedCity = selectedCity;
    if ([_selectedCity isEqualToString:@"北京市"]) {
        _dataService = [[DataService alloc]init];
        _dataService.fileName = @"110000";
        [_pickerView reloadAllComponents];
        if (_dataService.annotionArray) {
           [MapManager shareManager].coordinateArray = _dataService.annotionArray;
        }
    }
}

@end