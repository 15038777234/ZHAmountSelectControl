//
//  ZHPasswordTextFiled.m
//  ZHAmountSelectControl
//
//  Created by 张行 on 16/2/17.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "ZHPasswordTextFiled.h"
#import <Masonry/Masonry.h>
@implementation ZHPasswordTextFiled{
    UITextField *_backgroundView;
    
    NSMutableArray *_lineViewArray;
    NSMutableArray<ZHPasswordTextFiledItem *> *_iconImageViewArray;
    ZHPasswordTextFiledValueChangeComplete _complete;
}
-(instancetype)init{
    self=[super init];
    if (self) {
        _passwordCount=6;
        _boardColor=[UIColor blackColor];
        _boardWidth=1;
        _imageIconSize=CGSizeMake(20, 20);
        _repleaceImage=[UIImage imageNamed:@"default_replace_password_icon"];
    }
    return self;
}
-(void)reloadPasswordTextFiled{
    self.layer.borderWidth=_boardWidth;
    self.layer.borderColor=_boardColor.CGColor;
    [self layoutIfNeeded];
    __weak typeof(self) weakSelf =self;
    if (!_backgroundView) {
        _backgroundView=[UITextField new];
        _backgroundView.delegate=self;
        _backgroundView.keyboardType=UIKeyboardTypePhonePad;
        [self addSubview:_backgroundView];
    }
    
    if (!_lineViewArray) {
        _lineViewArray =[NSMutableArray array];
    }
    if (!_iconImageViewArray) {
        _iconImageViewArray=[NSMutableArray array];
    }
    for (UIView *view in _lineViewArray) {
        [view removeFromSuperview];
    }
    [_lineViewArray removeAllObjects];
    
    for (ZHPasswordTextFiledItem *view in _iconImageViewArray) {
        [view removeFromSuperview];
    }
    [_iconImageViewArray removeAllObjects];
    
    //计算图片间距
    CGFloat multipleWidth=1.0/_passwordCount;
    ZHPasswordTextFiledItem *firstItem;
    for (NSUInteger i=0; i<_passwordCount; i++) {
        ZHPasswordTextFiledItem *item=[[ZHPasswordTextFiledItem alloc]initWithSize:_imageIconSize imageIcon:nil];
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(weakSelf) strongSelf=weakSelf;
            make.top.bottom.equalTo(strongSelf);
            make.width.equalTo(strongSelf).multipliedBy(multipleWidth);
            if (!firstItem) {
                make.left.equalTo(strongSelf);
            }else{
                make.left.equalTo(firstItem.mas_right);
            }
        }];
        firstItem=item;
        [_iconImageViewArray addObject:item];
        
        UIView *lineView=[UIView new];
        [self addSubview:lineView];
        lineView.backgroundColor=_boardColor;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(weakSelf) strongSelf=weakSelf;
            make.top.bottom.equalTo(strongSelf);
            make.width.mas_equalTo(strongSelf->_boardWidth);
            make.right.equalTo(item.mas_right);
        }];
        [_lineViewArray addObject:lineView];
    }
}
-(void)setZHPasswordTextFiledValueChangeComplete:(ZHPasswordTextFiledValueChangeComplete)complete{
    _complete=complete;
}
-(BOOL)becomeFirstResponder{
    return [_backgroundView becomeFirstResponder];
}
- (BOOL)resignFirstResponder{
    return [_backgroundView resignFirstResponder];
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    BOOL isRepleace=YES;
    NSString *s=textField.text;
    NSUInteger oldLenght=s.length;
    if (isRepleace) {
        s=[s stringByReplacingCharactersInRange:range withString:string];
    }
    if (s.length>oldLenght) {
        //增加
        if (textField.text.length>=_passwordCount) {
            isRepleace=NO;
        }else{
         [_iconImageViewArray[s.length-1] reloadIconImage:_repleaceImage];
        }
        
    }else{
        //减少
        [_iconImageViewArray[oldLenght-1] reloadIconImage:nil];
    }
    if (_complete) {
        _complete(isRepleace?s:[s substringWithRange:NSMakeRange(0, _passwordCount)]);
    }
    return isRepleace;
}
@end

@implementation ZHPasswordTextFiledItem{
    UIImageView *_iconImageView;
}

-(instancetype)initWithSize:(CGSize)size imageIcon:(UIImage *)imageIcon{
    self=[super init];
    if (self) {
        _iconImageView=[UIImageView new];
        [self addSubview:_iconImageView];
        _iconImageView.image=imageIcon;
        __weak typeof(self) weakSelf =self;
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong typeof(weakSelf) strongSelf=weakSelf;
            make.center.equalTo(strongSelf);
            make.size.mas_equalTo(size);
        }];
    }
    return self;
}
-(void)reloadIconImage:(UIImage *)image{
    _iconImageView.image=image;
}
@end
