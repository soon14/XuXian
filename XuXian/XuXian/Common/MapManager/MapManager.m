//
//  MapManager.m
//  XuXian
//
//  Created by Michael Luo on 8/17/16.
//  Copyright © 2016 Fxxx. All rights reserved.
//

#import "MapManager.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapAnnotion.h"
#import "AnnotationModel.h"
@interface MapManager()<CLLocationManagerDelegate,MKMapViewDelegate>
{
    BOOL isCity;//判断是否请求到当前城市
}

@property (nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation MapManager
static MapManager * instance =nil;

+ (instancetype)shareManager{
    if (instance ==nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc]init];
        });
    }
    return instance;
}

-(instancetype)init{
    if (self = [super init]) {
        isCity = NO;
        _mapView = [[MKMapView alloc] init];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;
    }
    return self;
}

//get user location
- (void)getUserLocation{
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    _locationManager.distanceFilter = 50.0f;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8) {
        //请求用户授权
        [_locationManager requestWhenInUseAuthorization];
    }
    [_locationManager startUpdatingLocation];
}
//用户的位置已经更新(定位成功)
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    [_locationManager stopUpdatingLocation];
    CLLocationCoordinate2D coordinate = userLocation.coordinate;
    //跨度,传入的参数越小,越精确
    MKCoordinateSpan span = MKCoordinateSpanMake(.05, .05);
    
    [mapView setRegion:MKCoordinateRegionMake(coordinate, span)];
    CLLocation *newLocation = userLocation.location;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0  && error == nil){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //因为四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市
            if (placemark.locality){
                _cityName = [placemark.locality substringToIndex:placemark.locality.length - 1];
            }else{
                _cityName  = [placemark.administrativeArea substringToIndex:placemark.administrativeArea.length - 1];
            }
            if (_cityName&&isCity!=YES) {
                isCity = YES;
                self.currentCityBlock(_cityName);
            }
        }
    }];
    
}
/*
 //用户的位置已经更新(定位成功)
 -(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
 
 CLLocation *newLocation = [locations lastObject];
 [manager stopUpdatingLocation];
 
 CLGeocoder *geocoder = [[CLGeocoder alloc] init];
 [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error) {
 if (array.count > 0  && error == nil){
 CLPlacemark *placemark = [array objectAtIndex:0];
 //因为四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市
 if (placemark.locality){
 _cityName = [placemark.locality substringToIndex:placemark.locality.length - 1];
 }else{
 _cityName  = [placemark.administrativeArea substringToIndex:placemark.administrativeArea.length - 1];
 }
 if (_cityName&&isCity!=YES) {
 isCity = YES;
 self.currentCityBlock(_cityName);
 }
 }
 }];
 }
 
 //-(void)_loadData{
 //
 //}
 
 
 // update fail
 - (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;{
 NSLog(@"%@",error);
 [_locationManager stopUpdatingLocation];
 }
 */

// 定位失败处理
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    [_locationManager stopUpdatingLocation];
    NSLog(@"%@",error);
}
-(void)setCoordinateArray:(NSMutableArray *)coordinateArray{
    _coordinateArray = coordinateArray;
    BOOL isFirst = YES;
    for (AnnotationModel *model in _coordinateArray) {
        float lat = model.lat;
        float lon = model.lon;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(lat, lon);
        MapAnnotion *annotation = [[MapAnnotion alloc] init];
        annotation.coordinate = coordinate;
        annotation.title = model.cityName;
        annotation.subtitle = model.address;
        [self.mapView addAnnotation:annotation];
        
        if (isFirst) {
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coordinate,10000, 10000);
            MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
            [self.mapView setRegion:adjustedRegion animated:YES];
            isFirst = NO;
        }
    }
    
}

@end
