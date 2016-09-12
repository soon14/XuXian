//
//  ScanViewController.m
//  XuXian
//
//  Created by 吴旭健 on 16/8/16.
//  Copyright © 2016年 Fxxx. All rights reserved.
//

#import "ScanViewController.h"
#import "BeforeScanSingleton.h"

@interface ScanViewController ()

@end

@implementation ScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"扫码";
}

- (IBAction)ScanAction:(UIButton *)sender {
    [[BeforeScanSingleton shareScan] ShowSelectedType:QQStyle WithViewController:self];
}



@end
