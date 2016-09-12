//
//  AnnotationModel.h
//  XuXian
//
//  Created by Michael Luo on 8/19/16.
//  Copyright © 2016 Fxxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnnotationModel : NSObject

@property (nonatomic,strong)NSString *cityName;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,assign)float lat;
@property (nonatomic,assign)float lon;

@end
