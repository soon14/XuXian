//
//  MapAnnotion.h
//  XuXian
//
//  Created by Michael Luo on 8/19/16.
//  Copyright © 2016 Fxxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MapAnnotion : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//标题（可选）
@property (nonatomic, copy) NSString *title;
//子标题（可选）
@property (nonatomic, copy) NSString *subtitle;

@end
