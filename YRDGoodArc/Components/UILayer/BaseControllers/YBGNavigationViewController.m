//
//  YBGNavigationViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/23.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGNavigationViewController.h"

@interface YBGNavigationViewController ()

@end

@implementation YBGNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIViewController *)childViewControllerForStatusBarStyle {
//    如果是UINavigationController就要用顶部VC的barstyle
    return self.topViewController;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
