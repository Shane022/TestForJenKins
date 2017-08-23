//
//  DViewController.m
//  TestForJenkins
//
//  Created by dvt04 on 17/8/23.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "DViewController.h"

@interface DViewController ()

@end

@implementation DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"DViewController";
}

- (IBAction)onHitBtnDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"DViewController dealloc");
}

@end
