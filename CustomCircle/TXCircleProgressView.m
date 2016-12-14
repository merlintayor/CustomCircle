//
//  TXCircleProgressView.m
//  CustomCircle
//
//  Created by txx on 16/12/14.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "TXCircleProgressView.h"

@interface TXCircleProgressView()

@property (strong, nonatomic) UILabel     *progressLabel;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation TXCircleProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        _trackBackgroundColor = [UIColor grayColor];
        _trackColor = [UIColor blueColor];
        _lineWidth = 10 ;
        _lineCap = kCGLineCapRound ;
        _beginAngle = - M_PI_2 ;
        
        [self addSubview:self.progressLabel];
    }
    return self ;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat self_width = self.bounds.size.width;
    
    //progressLabel 位置应该是内部小圆的内接正方形，不过不用精确设置也可以达到类似目的
    self.progressLabel.frame = CGRectMake(_lineWidth, _lineWidth, self_width - _lineWidth *2, self_width - _lineWidth *2);
    
    if (self.headerImage) {
        CGFloat angle = _progress*2*M_PI + _beginAngle;
        CGFloat centerX = self_width/2;
        CGFloat centerY = self_width/2;
        CGFloat radius = (self_width-_lineWidth)/2;
        CGFloat imageCenterX = centerX + radius*cos(angle);
        CGFloat imageCenterY = centerY + radius*sin(angle);
        // 这里 + 8 作为imageView比轨道宽8的效果
        self.imageView.frame = CGRectMake(0, 0, _lineWidth+8, _lineWidth+8);
        self.imageView.center = CGPointMake(imageCenterX, imageCenterY);
    }
}
-(void)drawRect:(CGRect)rect
{
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGFloat self_width = self.bounds.size.width;
    CGFloat centerX = self_width/2;
    CGFloat centerY = self_width/2;
    CGFloat radius = (self_width-_lineWidth)/2;

    //绘制背景轨道
    CGContextAddArc(contextRef, centerX, centerY, radius, 0, 2*M_PI, 0);
    CGContextSetLineWidth(contextRef, _lineWidth);
    [self.trackBackgroundColor setStroke];
    CGContextStrokePath(contextRef);
    
    //绘制进度轨道
    CGFloat deltaAngle = _progress * M_PI * 2;
    //移动画笔到某点
//    CGContextMoveToPoint(contextRef, self_width/2, 0);
    CGContextAddArc(contextRef, centerX, centerY, radius, _beginAngle, _beginAngle + deltaAngle, 0);
    [self.trackColor setStroke];
    CGContextSetLineWidth(contextRef, _lineWidth);
    CGContextSetLineCap(contextRef, _lineCap);
    CGContextStrokePath(contextRef);
    
}
-(void)setProgress:(CGFloat)progress
{
    if (progress > 1 || progress <0) return ;
    if (progress == _progress) return ;
    _progress = progress ;
    self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%",_progress *100];
    [self setNeedsDisplay];
    if (self.headerImage) { //  需要显示图片就触发重新布局
        [self setNeedsLayout];
    }

}
- (void)setHeaderImage:(UIImage *)headerImage {
    _headerImage = headerImage;
    if (self.headerImage) {
        [self addSubview:self.imageView];
        self.imageView.image = self.headerImage;
    }
}
- (UILabel *)progressLabel {
    if (!_progressLabel) {
        UILabel *progressLabel = [[UILabel alloc] init];
        progressLabel.textColor = self.trackColor;
        progressLabel.backgroundColor = [UIColor clearColor];
        progressLabel.textAlignment = NSTextAlignmentCenter;
        progressLabel.text = @"0.0%";
        _progressLabel = progressLabel;
    }
    return _progressLabel;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.masksToBounds = YES;
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = 9;
        imageView.backgroundColor = [UIColor blueColor];
        _imageView = imageView;
    }
    return _imageView;
}
@end
