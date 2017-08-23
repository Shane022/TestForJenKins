//
//  BViewController.m
//  TestForJenkins
//
//  Created by dvt04 on 17/8/23.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "BViewController.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"BViewController";
}

- (void)dealloc
{
    NSLog(@"BViewController dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
