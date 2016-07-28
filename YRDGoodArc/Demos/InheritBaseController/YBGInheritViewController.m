//
//  YBGInheritViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/28.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGInheritViewController.h"

@interface YBGInheritViewController ()

@end

@implementation YBGInheritViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    [self showLoadingHUDFullScreen];
    __weak typeof(&*self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(&*weakSelf) strongSelf = weakSelf;
        [strongSelf showLoadingHUDInView];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(&*weakSelf) strongSelf = weakSelf;

        [strongSelf showHUDWithText:@"嗨"];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)pageId {
    return @"YBGInheritViewPageId";
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
