//
//  ShoppingCarCellTableViewCell.m
//  XuXian
//
//  Created by 吴旭健 on 16/8/21.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "ShoppingCarCell.h"
#import "UConstants.h"
#import "UIViewExt.h"
@implementation ShoppingCarCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        [self createSubViews];
    }
    return self;
}

-(void)createSubViews{
    
    self.checkImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, (110-20)/2.0, 20, 20)];
    
    self.checkImg.image =IMAGENAMED(@"check_p");
    [self addSubview:self.checkImg];
    
    self.shopImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.checkImg.right+10,15, 60, 60)];
    
    self.shopImageView.image = IMAGENAMED(@"img");
    
    [self addSubview:self.shopImageView];
    
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-90, (110-20)/2.0-20, 80, 20)];
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.text = @"￥123.00";
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.font = SYSTEMFONT(16);
    [self addSubview:self.priceLab];
    
    
    self.oldPriceLab = [[LineLabel alloc]initWithFrame:CGRectMake(kScreenWidth-70,self.priceLab.bottom+5, 58, 14)];
    self.oldPriceLab.textColor = [UIColor grayColor];
    self.oldPriceLab.text = @"￥200.00";
    self.oldPriceLab.backgroundColor = [UIColor clearColor];
    self.oldPriceLab.textAlignment = NSTextAlignmentRight;
    self.oldPriceLab.font = SYSTEMFONT(13);
    [self addSubview:self.oldPriceLab];
    
    
    self.shopNameLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopImageView.right+10,self.shopImageView.top-5,kScreenWidth-self.shopImageView.right-20-self.priceLab.width, 20)];
    self.shopNameLab.text = @"合生元金装3段1-3岁";
    self.shopNameLab.numberOfLines = 0;
    self.shopNameLab.font = SYSTEMFONT(16);
    [self addSubview:self.shopNameLab];
    
    self.shopTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopNameLab.left,self.shopNameLab.bottom,self.shopNameLab.width, 20)];
    self.shopTypeLab.text = @"通用型号";
    self.shopTypeLab.textColor = [UIColor darkGrayColor];
    self.shopTypeLab.font = SYSTEMFONT(12);
    [self addSubview:self.shopTypeLab];
    
    UILabel *numberTitleLab = [[UILabel alloc]initWithFrame:CGRectMake(self.shopTypeLab.left,self.shopImageView.bottom-5,35, 16)];
    numberTitleLab.text = @"数量:";
    numberTitleLab.textColor = [UIColor darkGrayColor];
    numberTitleLab.font = SYSTEMFONT(12);
    [self addSubview:numberTitleLab];
    
    
    self.addNumberView = [[AddNumberView alloc]initWithFrame:CGRectMake(numberTitleLab.right+5, numberTitleLab.top-2, 93, 22)];
    self.addNumberView.delegate = self;
    self.addNumberView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.addNumberView];
    
}

/**
 * 点击减按钮数量的减少
 *
 * @param sender 减按钮
 */
- (void)deleteBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    
    NSLog(@"减按钮");
    //判断是否选中，选中才能操作
    if (self.selectState == YES)
    {
        
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没选中你减什么,哼。。。" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}
/**
 * 点击加按钮数量的增加
 *
 * @param sender 加按钮
 */
- (void)addBtnAction:(UIButton *)sender addNumberView:(AddNumberView *)view{
    
    NSLog(@"加按钮");
    //判断是否选中，选中才能操作
    if (self.selectState == YES)
    {
        
        [self.delegate btnClick:self andFlag:(int)sender.tag];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没选中你加什么,哼。。。" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}

-(void)setShoppingModel:(ShoppingModel *)shoppingModel{
    
    _shoppingModel = shoppingModel;
    self.shopNameLab.text = shoppingModel.goodsTitle;
    
    if (shoppingModel.selectState)
    {
        self.checkImg.image = [UIImage imageNamed:@"check_p"];
        self.selectState = YES;
        
    }else{
        self.selectState = NO;
        self.checkImg.image = [UIImage imageNamed:@"check_n"];
    }
    self.shopTypeLab.text  = shoppingModel.goodsType;
    
    self.priceLab.text = shoppingModel.goodsPrice;
    self.shopImageView.image = IMAGENAMED(shoppingModel.imageName);
    // self.numberLab.text = [NSString stringWithFormat:@"%d",shoppingModel.goodsNum];
    self.addNumberView.numberString = [NSString stringWithFormat:@"%d",shoppingModel.goodsNum];
    
}



- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

