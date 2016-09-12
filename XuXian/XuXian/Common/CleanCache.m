//
//  CleanCache.m
//  XuXian
//
//  Created by Fxxx on 16/8/19.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "CleanCache.h"

@implementation CleanCache

+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSDirectoryEnumerator * fileEnumerator =[fileManager enumeratorAtPath:path];
        for (NSString *fileName in fileEnumerator) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[CleanCache fileSizeAtPath:absolutePath];
        }
        
        return folderSize;
    }
    return 0;
}

+(void)cleanCache:(NSString *)path{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDirectoryEnumerator * fileEnumerator =[fileManager enumeratorAtPath:path];
            for (NSString * fileName in fileEnumerator) {
                NSString * absolutePath = [path stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:absolutePath error:nil];
            }
        });
        
    }
}


@end
