//
//  MapManager.h
//  XuXian
//
//  Created by Michael Luo on 8/17/16.
//  Copyright © 2016 Fxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void (^LocationBlock)(NSString *currentCity);
@class MKMapView;
@interface MapManager : NSObject

+ (instancetype)shareManager;
//MapView
@property (nonatomic, strong) MKMapView *mapView;
//city name
@property(nonatomic,strong)NSString *cityName;
//store address
@property(nonatomic,strong)NSString *address;

//coordinate array
@property(nonatomic,strong)NSMutableArray *coordinateArray;

//block
@property(nonatomic,copy)LocationBlock currentCityBlock;

//init user location
- (void)getUserLocation;


@end
