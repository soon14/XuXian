//  XuXian
//
//  Created by mac on 16/8/17.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "CellView.h"
#import "Common.h"
@implementation CellView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.height = 100;
    self.width = (kScreenWidth - 12) / 3;
    if (self) {
        self.button = [[UIButton alloc] initWithFrame:CGRectMake((self.width - 50) / 2, 25, 50, 50)];
        [self addSubview:_button];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_button.frame), self.width, 20)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
        [self addSubview:_label];
    }
    return self;
}

@end
