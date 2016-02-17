//
//  ZHAmountSelectControl.h
//  ZHAmountSelectControl
//
//  Created by 张行 on 16/2/17.
//  Copyright © 2016年 张行. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ZHAmountSelectControlValueChangedComplete)(NSString *amount,NSUInteger index);
@interface ZHAmountSelectControl : UIView
/*!
 *  初始化控件
 *
 *  @param amounts 金额的数组
 *
 *  @return
 */
-(instancetype)initWithAmounts:(NSArray<NSString *> *)amounts;
///设置背景线条的颜色 默认为红色
@property (nonatomic, strong) UIColor *backgroundLineViewColor;
///设置背景线条的高度 默认为5
@property (nonatomic, assign) CGFloat backgroundLineViewHeight;
///设置原点的大小 默认为10X10
@property (nonatomic, assign) CGSize splitButtonSize;
///设置原点的颜色 默认和背景一个颜色
@property (nonatomic, strong) UIColor *splitButtonColor;
///设置金币的图片 如果不设置则是黑色
@property (nonatomic, strong) UIImage *amountIconImage;
///设置两端空出的距离 默认为20
@property (nonatomic, assign) CGFloat leftRightSpanceWidth;
///设置金币的大小 默认为试图的40x40
@property (nonatomic, assign) CGSize amountIconSize;
///设置上面属性之后请执行此方法 否则设置无法生效 如果使用autulayout局部 请在布局之后调用此方法
-(void)reloadView;
///设置值改变的回调
-(void)setAmountSelectControlValueChangedComplete:(ZHAmountSelectControlValueChangedComplete)complete;
@end
