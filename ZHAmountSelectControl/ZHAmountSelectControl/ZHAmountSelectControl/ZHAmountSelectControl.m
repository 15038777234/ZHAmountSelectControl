//
//  ZHAmountSelectControl.m
//  ZHAmountSelectControl
//
//  Created by 张行 on 16/2/17.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "ZHAmountSelectControl.h"
#import <Masonry/Masonry.h>
@implementation ZHAmountSelectControl{
    ///金额的数组
    NSArray<NSString *> * _amounts;
    ///底部红线
    UIView *_backgroundLineView;
    //分割点数组
    NSMutableArray<UIButton *> *_splitButtons;
    //金币的图片
    UIImageView *_amountIconImageView;
    //当前金币所在的位置
    NSInteger _currentAmountIconIndex;
    //记录中间的距离
    CGFloat _splitButtonSpanceWidth;
    //回调
    ZHAmountSelectControlValueChangedComplete _complete;
    
}

-(instancetype)initWithAmounts:(NSArray<NSString *> *)amounts{
    if (!amounts && amounts.count==0) {
        //如果传入的金额数组不存在 或者金额数组为空 不能初始化
        return nil;
    }
    self=[super init];
    if (self) {
        _amounts=amounts;
        _backgroundLineViewColor=[UIColor redColor];
        _backgroundLineViewHeight=5;
        _splitButtonSize=CGSizeMake(10, 10);
        _splitButtonColor=_backgroundLineViewColor;
        _leftRightSpanceWidth=20;
        _amountIconSize=CGSizeMake(40, 40);
        _splitButtons=[NSMutableArray array];
        [self _initAddSubViews];
        //[self reloadAutolayout];
    }
    return self;
}
-(void)_initAddSubViews{
    _backgroundLineView=[[UIView alloc]init];
    [self addSubview:_backgroundLineView];
    
    for (NSUInteger i=0; i<_amounts.count; i++) {
        UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:button];
        [_splitButtons addObject:button];
    }
    
    _amountIconImageView=[[UIImageView alloc]init];
    [self addSubview:_amountIconImageView];
}
///设置属性和布局
-(void)reloadAutolayout{
    
    _backgroundLineView.backgroundColor=_backgroundLineViewColor;
    __weak typeof(self) weakSelf =self;
    [_backgroundLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf =weakSelf;
        make.left.right.equalTo(strongSelf);
        make.centerY.equalTo(strongSelf);
        make.height.mas_offset(strongSelf->_backgroundLineViewHeight);
    }];
    CGFloat spanceWidth=(self.frame.size.width-2*_leftRightSpanceWidth-_splitButtons.count*_splitButtonSize.width)/(_splitButtons.count-1);
    _splitButtonSpanceWidth=spanceWidth;
    UIButton *lasterButton;
    for (NSUInteger i=0; i<_splitButtons.count; i++) {
        UIButton *button=_splitButtons[i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=i;
        button.layer.masksToBounds=YES;
        button.layer.cornerRadius=_splitButtonSize.width/2;
        button.backgroundColor=_splitButtonColor;
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(weakSelf) strongSelf =weakSelf;
            make.centerY.equalTo(strongSelf);
            make.size.mas_offset(strongSelf->_splitButtonSize);
            if (!lasterButton) {
                make.left.equalTo(strongSelf).offset(strongSelf->_leftRightSpanceWidth);
            }else{
                make.left.equalTo(lasterButton.mas_right).offset(spanceWidth);
            }
        }];
        lasterButton=button;
    }
    
    if (_amountIconImage) {
        _amountIconImageView.image=_amountIconImage;
    }else{
        _amountIconImageView.backgroundColor=[UIColor blackColor];
    }
    [_amountIconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf =weakSelf;
        make.centerX.equalTo(strongSelf->_splitButtons[0].mas_centerX);
        make.centerY.equalTo(strongSelf->_splitButtons[0].mas_centerY);
        make.size.mas_offset(strongSelf->_amountIconSize);
    }];
    
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panClick:)];
    _amountIconImageView.userInteractionEnabled=YES;
    [_amountIconImageView addGestureRecognizer:pan];
    
    
}
-(void)reloadView{
    [self layoutIfNeeded];//为了获取控件的宽度 方便下面的布局
    [self reloadAutolayout];
}
-(void)setAmountSelectControlValueChangedComplete:(ZHAmountSelectControlValueChangedComplete)complete{
    _complete=complete;
}
-(void)buttonClick:(UIButton *)button{
    if (_currentAmountIconIndex==button.tag) {
        return;
    }
    _currentAmountIconIndex=button.tag;
    __weak typeof(self) weakSelf =self;
    [_amountIconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        __strong typeof(weakSelf) strongSelf =weakSelf;
        make.centerX.equalTo(strongSelf->_splitButtons[strongSelf->_currentAmountIconIndex].mas_centerX);
        make.centerY.equalTo(strongSelf->_splitButtons[strongSelf->_currentAmountIconIndex].mas_centerY);
        make.size.mas_offset(strongSelf->_amountIconSize);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        if (_complete) {
            _complete(_amounts[_currentAmountIconIndex],_currentAmountIconIndex);
        }
    }];
    
}
-(void)panClick:(UIPanGestureRecognizer *)pan{
    CGPoint translation = [pan translationInView:self];
    CGPoint point=CGPointMake(pan.view.center.x + translation.x,
                              pan.view.center.y);
    if (pan.state==UIGestureRecognizerStateEnded) {
        point=[self viewCenterPoint:point];
    }
    
    pan.view.center = point;;
    [pan setTranslation:CGPointZero inView:self];
    if (_complete) {
        _complete(_amounts[_currentAmountIconIndex],_currentAmountIconIndex);
    }
    
}
-(CGPoint)viewCenterPoint:(CGPoint)point{
    CGFloat min=0;
    CGFloat max=0;
    for (NSUInteger i=0; i<_splitButtons.count; i++) {
        if (i==0) {
            max=_leftRightSpanceWidth+_splitButtonSize.width+_splitButtonSpanceWidth/2;
        }else if(i==_splitButtons.count-1){
            min=max;
            max=max+_splitButtonSpanceWidth/2+_splitButtonSize.width+_leftRightSpanceWidth;
        }else{
            min=max;
            max=max+_splitButtonSpanceWidth+_splitButtonSize.width;
        }
        if (point.x>=min && point.x<=max) {
            return _splitButtons[i].center;
            _currentAmountIconIndex=i;
        }
        continue;
    }
    return CGPointMake(0, 0);
}
@end
