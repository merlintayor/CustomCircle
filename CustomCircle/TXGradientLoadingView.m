//
//  TXGradientLoadingView.m
//  CustomCircle
//
//  Created by txx on 16/12/13.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "TXGradientLoadingView.h"

@interface TXGradientLoadingView()

@property(nonatomic,strong)CAGradientLayer *upLayer;
@property(nonatomic,strong)CAGradientLayer *dowmLayer;
@property(nonatomic,strong)CAShapeLayer    *centerLayer;

@end

@implementation TXGradientLoadingView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = 10 ;
        _centerColor = [UIColor whiteColor];
        _animateDuration = 1;
        
        [self.layer addSublayer:self.upLayer];
        [self.layer addSublayer:self.dowmLayer];
        [self.layer addSublayer:self.centerLayer];
    }
    return self ;
}
/**
 重写set方法，将colors分为两个数组
 */
-(void)setColors:(NSArray<UIColor *> *)colors
{
    NSAssert(colors.count > 1, @"设置的颜色必须要大于1个");
    if (!colors || colors.count <= 1) return;
    
    NSMutableArray *upColors = [NSMutableArray arrayWithCapacity:colors.count];
    NSMutableArray *downColors = [NSMutableArray arrayWithCapacity:colors.count];
    switch (colors.count) {
        case 2:{
            [upColors addObject:(id)colors[0].CGColor];
            [upColors addObject:(id)colors[1].CGColor];

            [downColors addObject:(id)colors[1].CGColor];
            [downColors addObject:(id)colors[0].CGColor];

            break;
        }
        case 3:{
            [upColors addObject: (id)(colors[0].CGColor)];
            [upColors addObject: (id)(colors[1].CGColor)];
            
            [downColors addObject: (id)(colors[1].CGColor)];
            [downColors addObject: (id)(colors[2].CGColor)];
            self.upLayer.locations = @[@0.75, @1.0];
            self.dowmLayer.locations = @[@0.25, @1.0];
            break;
        }
        case 4:{
            int index = 0;
            for (UIColor *color in colors) {
                if (index < colors.count/2) {
                    [upColors addObject:(id)(color.CGColor)];
                }
                else {
                    [downColors addObject:(id)(color.CGColor)];
                }
                index++;
            }
            break;
        }
        default:{
            int index = 0;
            for (UIColor *color in colors) {
                if (index < colors.count/2) {
                    [upColors addObject:(id)(color.CGColor)];
                }
                else {
                    [downColors addObject:(id)(color.CGColor)];
                }
                index++;
            }
            break;
        }
    }
    
    self.upLayer.colors = upColors;
    self.dowmLayer.colors = downColors;

}
/**
 布局subLayer
 */
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.cornerRadius = self.bounds.size.width/2;
    self.layer.masksToBounds = YES ;
    
    _upLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height/2);
    _dowmLayer.frame = CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, self.bounds.size.height/2);
    
    CGPathRef path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_lineWidth, _lineWidth, self.bounds.size.width-_lineWidth*2, self.bounds.size.height-_lineWidth*2)].CGPath;
    _centerLayer.path = path ;
    
    [self animation];
}
/**
 做动画
 */
-(void)animation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0.0;
    animation.toValue = @(2 * M_PI);
    animation.duration = _animateDuration;
    animation.repeatCount = MAXFLOAT ;
    [self.layer addAnimation:animation forKey:@"rotation"];
}
-(CAGradientLayer *)upLayer
{
    if (!_upLayer) {
        _upLayer = [CAGradientLayer layer];
        _upLayer.startPoint = CGPointMake(0, 0);
        _upLayer.endPoint = CGPointMake(1, 0);
        
    }
    return _upLayer ;
}
-(CAGradientLayer *)dowmLayer
{
    if (!_dowmLayer) {
        _dowmLayer = [CAGradientLayer layer];
        _dowmLayer.startPoint = CGPointMake(1, 0);
        _dowmLayer.endPoint = CGPointMake(0, 0);
    }
    return _dowmLayer ;
}
-(CAShapeLayer *)centerLayer
{
    if (!_centerLayer) {
        _centerLayer = [CAShapeLayer layer];
        _centerLayer.fillColor = self.centerColor.CGColor;
    }
    return _centerLayer ;
}

@end
