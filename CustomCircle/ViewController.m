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

@interface ViewController ()


@property(nonatomic,strong)TXLoadingView *loadingView;
@property(nonatomic,strong)TXGradientLoadingView *gradientLoadingView;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.loadingView = [[TXLoadingView alloc]initWithFrame:CGRectMake(100, 300, 200, 200)];
//    self.loadingView.lineWidth = 20;
//    [self.view addSubview:self.loadingView];
    
    
    
    
    self.gradientLoadingView = [[TXGradientLoadingView alloc] initWithFrame:CGRectMake(100, 500, 100, 100)];
    NSArray *colors = @[
                        [UIColor redColor],
                        [UIColor yellowColor],
                        [UIColor greenColor],
                        [UIColor purpleColor],
                        ];
    self.gradientLoadingView.colors = colors;
    [self.view addSubview:self.gradientLoadingView];
    

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
