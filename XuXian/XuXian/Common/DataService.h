//
//  DataService.h
//  XuXian
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject

@property (nonatomic,strong)NSString *fileName;

@property (nonatomic,assign)NSInteger newStore;

@property (nonatomic,strong)NSMutableArray *storeArray;

@property (nonatomic,strong)NSMutableArray *annotionArray;


@end
