//
//  ViewController.m
//  CustomCircle
//
//  Created by txx on 16/12/12.
//  Copyright © 2016年 txx. All rights reserved.
//

#import "ViewController.h"
#import "ZJLoadingView.h"
#import "TXLoadingView.h"

@interface ViewController ()


@property(nonatomic,strong)TXLoadingView *loadingView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loadingView = [[TXLoadingView alloc]initWithFrame:CGRectMake(100, 300, 200, 200)];
    [self.view addSubview:self.loadingView];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
