//
//  AddressViewController.h
//  XuXian
//
//  Created by Macx on 16/8/17.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "BaseViewController.h"
@class DataService;
@interface AddressViewController : BaseViewController

@property(nonatomic,strong)NSString *selectedCity;
@property(nonatomic,strong)DataService *dataService;

@end
