//
//  TXLoadingView.m
//  CustomCircle
//
//  Created by txx on 16/12/12.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "TXLoadingView.h"

@interface TXLoadingView()

@property(nonatomic,strong)CAShapeLayer *shapeLayer;

@end

@implementation TXLoadingView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultSet];
    }
    return self ;
}
/**
 默认设置
 */
-(void)defaultSet
{
    _lineWidth       = 3 ;
    _trackColor      = [UIColor redColor];
    _lineCap         = kCALineCapRound;
    _animateDuration = 2;
}

/**
 当被添加到父试图上，且frame不为0时call
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    //添加父试图，默认开启动画
    [self startAnimations];
}
-(void)startAnimations
{
    if (![self.shapeLayer superlayer]) {
        CGFloat width = self.bounds.size.width ;
        
        //设置圆的外界矩形
        CGRect ovalRect = CGRectMake(_lineWidth/2, _lineWidth/2, width - _lineWidth, width - _lineWidth);
        
        //获得圆的轨迹
        CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:ovalRect].CGPath;
        //设置layer的path
        self.shapeLayer.path = path ;
        //添加圆到layer上
        [self.layer addSublayer:self.shapeLayer];
    }
    
    //根据keyofpath动画调整轨道的结束点--相当于绘图
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @0.0;
    strokeEndAnimation.toValue = @1.0 ;
    strokeEndAnimation.duration = _animateDuration;
    //设置动画的函数类型
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    
    //根据keyofpath调整轨道的开始点
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @0.0;
    strokeStartAnimation.toValue = @1.0;
    strokeStartAnimation.duration = _animateDuration*0.5;
    //此动画开始的时间
    strokeStartAnimation.beginTime = _animateDuration;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    //动画组，将上面两个动画添加到动画组
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    //动画的执行顺序有beginTime决定
    groupAnimation.animations = @[strokeEndAnimation,strokeStartAnimation];
    groupAnimation.duration = _animateDuration *1.5;
    groupAnimation.repeatCount = MAXFLOAT ;
    //设置模式
    groupAnimation.fillMode  = kCAFillModeForwards;
    [self.shapeLayer addAnimation:groupAnimation forKey:@"groupAnimation"];
    
    //使用旋转动画旋转self.layer，使每次重合的位置状态改变
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = @0.0;
    rotationAnimation.toValue = @( M_PI *2);
    rotationAnimation.duration = _animateDuration ;
    rotationAnimation.repeatCount = MAXFLOAT ;
    [self.layer addAnimation:rotationAnimation forKey:@"rotation"];
}
- (void)stopAnimations
{
    [self.shapeLayer removeAllAnimations];
    [self.layer removeAllAnimations];
}
-(CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc]init];
        _shapeLayer.lineCap = _lineCap;
        _shapeLayer.lineWidth = _lineWidth ;
        _shapeLayer.strokeColor = _trackColor.CGColor;
        //填充颜色设置为clearColor
        _shapeLayer.fillColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeStart = 0.0;
        _shapeLayer.strokeEnd = 1.0 ;
    }
    return _shapeLayer ;
}
@end
