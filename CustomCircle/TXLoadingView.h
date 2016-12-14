//
//  TXLoadingView.h
//  CustomCircle
//
//  Created by txx on 16/12/12.
//  Copyright © 2016年 txx. All rights reserved.
//

/*
 
 加载视图
 
 */
#import <UIKit/UIKit.h>

@interface TXLoadingView : UIView


/**
 线宽，默认为5
 */
@property (assign, nonatomic) CGFloat lineWidth;
/**
 线的颜色 默认为red
 */
@property (strong, nonatomic) UIColor *trackColor;
/**
 进度两端的样式，默认为kCALineCapRound
 */
@property (assign, nonatomic) NSString *lineCap;
/**
 动画时间，默认为2s
 */
@property (assign, nonatomic) CGFloat animateDuration;


/**
 *  停止动画
 */
- (void)stopAnimations;
/**
 *  重新开始动画
 */
- (void)startAnimations;

@end
