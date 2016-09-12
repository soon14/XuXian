//
//  CleanCache.h
//  XuXian
//
//  Created by Fxxx on 16/8/19.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CleanCache : NSObject

+(float)fileSizeAtPath:(NSString *)path;
+(float)folderSizeAtPath:(NSString *)path;
+(void)cleanCache:(NSString *)path;

@end
