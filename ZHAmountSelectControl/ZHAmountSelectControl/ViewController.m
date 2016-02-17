//
//  ViewController.m
//  ZHAmountSelectControl
//
//  Created by 张行 on 16/2/17.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "ViewController.h"
#import "ZHAmountSelectControl.h"
#import <Masonry/Masonry.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZHAmountSelectControl *amountControl=[[ZHAmountSelectControl alloc]initWithAmounts:@[@"100",@"200",@"200",@"200",@"200",@"200" ]];
    [self.view addSubview:amountControl];
    
    [amountControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    [amountControl reloadView];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
