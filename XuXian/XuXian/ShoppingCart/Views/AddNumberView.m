//
//  AddNumberView.m
//  XuXian
//
//  Created by 吴旭健 on 16/8/21.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "AddNumberView.h"
#import "UIViewExt.h"
#import "Common.h"

@implementation AddNumberView


-(instancetype)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.jianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.jianBtn.frame = CGRectMake(0,0, 26, 22);
    [self.jianBtn addTarget:self action:@selector(deleteBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.jianBtn.tag = 11;
    [self.jianBtn setImage:IMAGENAMED(@"jian_icon") forState:UIControlStateNormal];
    
    [self addSubview:self.jianBtn];
    
    UIImageView *numberBg = [[UIImageView alloc]initWithFrame:CGRectMake(self.jianBtn.right-4, self.jianBtn.top, 50,22)];
    numberBg.image = IMAGENAMED(@"numbe_bg_icon");
    
    [self addSubview:numberBg];
    
    
    self.numberLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, numberBg.width, numberBg.height)];
    self.numberLab.text = @"1";
    self.numberLab.textAlignment = NSTextAlignmentCenter;
    self.numberLab.textColor = [UIColor darkGrayColor];
    self.numberLab.font = SYSTEMFONT(12);
    [numberBg addSubview:self.numberLab];
    
    
    
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(numberBg.right-5,self.jianBtn.top, 26, 22);
    self.addBtn.tag = 12;
    [self.addBtn setImage:IMAGENAMED(@"add_icon") forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addBtn];
    
    
}



-(void)setNumberString:(NSString *)numberString{
    
    
    _numberString = numberString;
    
    self.numberLab.text = numberString;
}
- (void)awakeFromNib {
    
    
    
    
}

- (void)deleteBtnAction:(UIButton *)sender {
    
    NSLog(@"减方法");
    if(self.delegate && [self.delegate respondsToSelector:@selector(deleteBtnAction:addNumberView:)]){
        
        [self.delegate deleteBtnAction:sender addNumberView:self];
    }
    
    
}

- (void)addBtnAction:(UIButton *)sender {
    
    NSLog(@"加方法");
    if(self.delegate && [self.delegate respondsToSelector:@selector(addBtnAction:addNumberView:)]){
        
        [self.delegate addBtnAction:sender addNumberView:self];
    }
    
}
@end
