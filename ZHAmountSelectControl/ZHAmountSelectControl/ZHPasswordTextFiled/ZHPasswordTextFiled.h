//
//  ZHPasswordTextFiled.h
//  ZHAmountSelectControl
//
//  Created by 张行 on 16/2/17.
//  Copyright © 2016年 张行. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHPasswordTextFiledItem;
typedef void(^ZHPasswordTextFiledValueChangeComplete)(NSString *text);
@interface ZHPasswordTextFiled : UIView<UITextFieldDelegate>

//设置 密码个数 默认为6个
@property (nonatomic, assign) NSUInteger passwordCount;
//设置边框的颜色 默认为黑色
@property (nonatomic, strong) UIColor *boardColor;
//设置替换的图片 默认为黑色圆点 图片为60x60
@property (nonatomic, strong) UIImage *repleaceImage;
//设置图片的大小 默认为20x20
@property (nonatomic, assign) CGSize imageIconSize;
//设置边框的宽度 默认为1
@property (nonatomic, assign) CGFloat boardWidth;

-(void)reloadPasswordTextFiled;
///设置监听密码值改变的通知block
-(void)setZHPasswordTextFiledValueChangeComplete:(ZHPasswordTextFiledValueChangeComplete)complete;
@end

@interface  ZHPasswordTextFiledItem: UIView
-(instancetype)initWithSize:(CGSize)size imageIcon:(UIImage *)imageIcon;
-(void)reloadIconImage:(UIImage *)image;
@end
