//
//  ViewController.m
//  CustomCircle
//
//  Created by txx on 16/12/12.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "ViewController.h"
#import "TXLoadingView.h"
#import "TXGradientLoadingView.h"
#import "TXCirclePieProgressView.h"
#import "TXCircleProgressView.h"

@interface ViewController ()


@property(nonatomic,strong)TXLoadingView *loadingView;
@property(nonatomic,strong)TXGradientLoadingView *gradientLoadingView;
@property(nonatomic,strong)TXCirclePieProgressView *pieProgressView;
@property(nonatomic,strong)TXCircleProgressView *progressView;




@end

@implementation ViewController
- (IBAction)changeValue:(UISlider *)sender {
    
    self.pieProgressView.progress = sender.value;
    self.progressView.progress = sender.value ;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingView = [[TXLoadingView alloc]initWithFrame:CGRectMake(100, 50, 100, 100)];
    self.loadingView.lineWidth = 20;
    [self.view addSubview:self.loadingView];
 
    
    self.gradientLoadingView = [[TXGradientLoadingView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    NSArray *colors = @[
                        [UIColor redColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor purpleColor],
                        ];
    self.gradientLoadingView.colors = colors;
    [self.view addSubview:self.gradientLoadingView];
    
    
    self.pieProgressView = [[TXCirclePieProgressView alloc] initWithFrame: CGRectMake(50, 350, 100, 100)];
    [self.view addSubview:self.pieProgressView];
    
    
    self.progressView = [[TXCircleProgressView alloc]initWithFrame:CGRectMake(200, 350, 100, 100)];
    self.progressView.headerImage = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:self.progressView];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
