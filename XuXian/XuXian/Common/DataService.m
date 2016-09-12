//
//  DataService.m
//  XuXian
//
//  Created by Macx on 16/8/19.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "DataService.h"
#import "StoreList.h"
#import "StoreItem.h"
#import "YYModel.h"
#import "AnnotationModel.h"
@interface DataService(){
    NSMutableDictionary *_distanceDict;
}
@end

@implementation DataService

-(void)setFileName:(NSString *)fileName{
    
    _fileName = fileName;
    _storeArray =[NSMutableArray array];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:_fileName ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSDictionary *data = dic[@"data"];
    
    _newStore = [data[@"new_store"] longValue];
    
    NSArray *storeInfoArr = data[@"store_info"];
    _distanceDict = [NSMutableDictionary dictionary];
    NSInteger i = 0;
    
    for (NSDictionary *storeDic in storeInfoArr) {
        StoreList *storeList = [[StoreList alloc]init];
        storeList.storeArr =[NSMutableArray array];
        
        storeList.area_id =storeDic[@"area_id"];
        storeList.area_name =storeDic[@"area_name"];
        NSArray *storeArr = storeDic[@"store_list"];
        NSString *minDistance = nil;
        for (NSDictionary *stDic in storeArr) {
            if ([stDic[@"distance"] caseInsensitiveCompare:minDistance] ==NSOrderedDescending) {
                minDistance =stDic[@"distance"];
            }
            StoreItem *storeItem = [[StoreItem alloc]init];
            storeItem = [StoreItem yy_modelWithDictionary:stDic];
            [storeList.storeArr addObject:storeItem];
        }
        [_distanceDict setObject:minDistance forKey:[NSNumber numberWithInteger:i++]];
        [_storeArray addObject:storeList];
    }
    NSLog(@"store array:**** %@", _storeArray);
}

-(NSMutableArray *)annotionArray{
    _annotionArray = [NSMutableArray array];
    NSArray *disArr = [[_distanceDict allValues] sortedArrayUsingSelector:@selector(compare:)];
    NSInteger i = 0;
    NSArray *keyArr =[_distanceDict allKeys];
    for (NSString *key in keyArr) {
        if ([_distanceDict[key] isEqualToString:disArr[0]]) {
            break;
        }
        i++;
    }
//    for (NSDictionary *dic in _distanceDict) {
//        NSString *key
//        NSString *value = [dic valueForKey:[NSString stringWithFormat:@"%li",i]];
//        if ([value isEqualToString:disArr[0]]) {
//            break;
//        }
//        i++;
//    }
    
    StoreList *storeList =_storeArray[i];
    NSArray *storeItems = storeList.storeArr;
    for (StoreItem *storeItem in storeItems) {
        AnnotationModel *model = [[AnnotationModel alloc]init];
        model.cityName =storeItem.city_area;
        model.address = storeItem.area;
        model.lat =[storeItem.lat floatValue];
        model.lon = [storeItem.lng floatValue];
        [_annotionArray addObject:model];
    }
    return _annotionArray;
}
@end
