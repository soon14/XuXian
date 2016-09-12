//
//  ShoppingModel.m
//  XuXian
//
//  Created by 吴旭健 on 16/8/21.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "ShoppingModel.h"

@implementation ShoppingModel



-(instancetype)initWithShopDict:(NSDictionary *)dict{
    
    self.imageName = dict[@"imageName"];
    self.goodsTitle = dict[@"goodsTitle"];
    self.goodsPrice = dict[@"goodsPrice"];
    self.goodsNum = [dict[@"goodsNum"]intValue];
    self.goodsType = dict[@"goodsType"];
    
    self.selectState = [dict[@"selectState"]boolValue];
    
    return self;
}


@end

