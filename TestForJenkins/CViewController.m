//
//  CViewController.m
//  TestForJenkins
//
//  Created by dvt04 on 17/8/23.
//  Copyright © 2017年 suma. All rights reserved.
//

#import "CViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"CViewController";
}
- (IBAction)onHitBtnDismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    NSLog(@"CViewController dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
