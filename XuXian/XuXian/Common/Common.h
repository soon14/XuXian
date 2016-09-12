//
//  Common.h
//  XuXian
//
//  Created by Fxxx on 16/8/16.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#ifndef Common_h
#define Common_h
#import "UIViewExt.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScrennHeight [UIScreen mainScreen].bounds.size.height

//加载图片
#define PNGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)         [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define IMAGENAMED(NAME)       [UIImage imageNamed:NAME]

//字体大小（常规/粗体）
#define BOLDSYSTEMFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME,FONTSIZE)      [UIFont fontWithName:(NAME) size:(FONTSIZE)]

#define RGBACOLOR(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//判断是不是4s如果是则高度和5s一样的比例
#define GetHeight(height) (kScrennHeight > 568 ? (height)/DesignHeight*kScrennHeight : (height)/DesignHeight*568)

#define DesignHeight 1334.0
#define DesignWidth 750.0
#define GetWidth(width)  (width)/DesignWidth*kScreenWidth

#endif /* Common_h */
