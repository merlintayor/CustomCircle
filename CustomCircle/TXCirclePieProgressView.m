//
//  TXCirclePieProgressView.m
//  CustomCircle
//
//  Created by txx on 16/12/14.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "TXCirclePieProgressView.h"

@implementation TXCirclePieProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _progress = 0.30;
        _beginAngle = -M_PI_2;
        _lineWidth = 2 ;
        _progressColor = [UIColor grayColor];
        _lineColor = [UIColor blueColor];
    }
    return self;
}
-(void)drawRect:(CGRect)rect
{
    //获取当前绘图上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGFloat self_width_height = self.bounds.size.width ;
    CGFloat center_x_y = self_width_height/2;
    CGFloat radius = self_width_height/2-_lineWidth/2;
    
    if (_lineWidth > 0) {
        //绘制边缘轨道
        CGContextAddArc(contextRef, center_x_y, center_x_y, radius, 0, 2*M_PI, 0);
        CGContextSetLineWidth(contextRef, _lineWidth);
        //设置颜色
        [self.lineColor setStroke];
        //绘制轨道
        CGContextStrokePath(contextRef);
    }
    
    CGFloat pieAngle = _progress * 2*M_PI;
    
    //移动画笔到圆心
    CGContextMoveToPoint(contextRef, center_x_y, center_x_y);
    CGContextAddArc(contextRef, center_x_y, center_x_y, radius, _beginAngle, _beginAngle + pieAngle, 0);
    [self.progressColor setStroke];
    //绘制封闭扇形
    CGContextFillPath(contextRef);
}
-(void)setProgress:(CGFloat)progress
{
    if (progress > 1 || progress < 0) {
        return ;
    }
    if (progress == _progress) {
        return ;
    }
    _progress = progress;
    // 标记为需要重新绘制, 将会在下一个绘制循环中, 调用drawRect:方法重新绘制
    [self setNeedsDisplay];
}
-(void)setBeginAngle:(CGFloat)beginAngle
{
    if (beginAngle != _beginAngle) {
        _beginAngle = beginAngle ;
        [self setNeedsDisplay];
    }
}
-(void)setLineWidth:(CGFloat)lineWidth
{
    if (lineWidth != _lineWidth) {
        _lineWidth = lineWidth;
        [self setNeedsDisplay];
    }
}
-(void)setProgressColor:(UIColor *)progressColor
{
    if (progressColor != _progressColor) {
        _progressColor = progressColor ;
        [self setNeedsDisplay];
    }
}
-(void)setLineColor:(UIColor *)lineColor
{
    if (lineColor != _lineColor) {
        _lineColor = lineColor ;
        [self setNeedsDisplay];
    }
}
@end
