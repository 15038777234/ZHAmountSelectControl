//
//  ViewController.m
//  ZHAmountSelectControl
//
//  Created by 张行 on 16/2/17.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "ViewController.h"
#import "ZHAmountSelectControl.h"
#import "ZHPasswordTextFiled.h"
#import <Masonry/Masonry.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    ZHPasswordTextFiled *textFiled=[ZHPasswordTextFiled new];
    [self.view addSubview:textFiled];
    UIEdgeInsets ed=UIEdgeInsetsMake(20, 20, 20, 20);
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ed.top);
        make.left.equalTo(self.view).offset(ed.left);
        make.right.equalTo(self.view).offset(-ed.right);
        make.height.mas_equalTo(40);
    }];
    
    [textFiled setZHPasswordTextFiledValueChangeComplete:^(NSString *text) {
        NSLog(@"sssssss%@",text);
    }];
    
    [textFiled reloadPasswordTextFiled];
    
    [textFiled becomeFirstResponder];
    
    
    ZHAmountSelectControl *amountControl=[[ZHAmountSelectControl alloc]initWithAmounts:@[@"100",@"200",@"200",@"200",@"200",@"200" ]];
    [self.view addSubview:amountControl];
    
    [amountControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.width.equalTo(textFiled.mas_width);
        make.top.equalTo(textFiled.mas_bottom).offset(20);
        make.height.mas_equalTo(40);
    }];
    
    [amountControl reloadView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
