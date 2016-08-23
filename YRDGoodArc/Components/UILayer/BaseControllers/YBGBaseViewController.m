//
//  YBGBaseViewController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGBaseViewController.h"
#import "MBProgressHUD.h"
@interface YBGBaseViewController ()
@property (nonatomic) MBProgressHUD *currentHUD;
@end

@implementation YBGBaseViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}
- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}
#pragma mark - delegates

#pragma mark - Notifications

#pragma mark - event response

#pragma mark - public methods
- (void)showLoadingHUDInView {
    [self showLoadingHUDInWindow:NO];
}
- (void)showLoadingHUDFullScreen {
    [self showLoadingHUDInWindow:YES];

}

- (void)hideHUD {
    if (self.currentHUD) {
        [self.currentHUD hideAnimated:NO];
        self.currentHUD = nil;
    }
}
- (void)showHUDWithText:(NSString *)text {
    [self hideHUD];
    self.currentHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    self.currentHUD.mode = MBProgressHUDModeText;
    self.currentHUD.label.text = text ? :@"";
    // Move to bottm center.
//    self.currentHUD.offset = CGPointMake(0.f, MBProgressMaxOffset);
    self.currentHUD.label.textColor = [UIColor whiteColor];
    self.currentHUD.bezelView.color = [UIColor blackColor];
    [self.currentHUD hideAnimated:YES afterDelay:2.f];

}
//默认的barStytle
- (UIStatusBarStyle)preferredStatusBarStyle {
//    默认是黑色文字，如果app风格不一致就改另一种风格，
    return UIStatusBarStyleDefault;
}
#pragma mark - private methods
/**
 *  显示加载圈
 *
 *  @param isInWindow YES表示显示在整个屏幕上，NO显示在View的范围
 */
- (void)showLoadingHUDInWindow:(BOOL)isInWindow {
    [self hideHUD];

    if (isInWindow) {
     self.currentHUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];

    }
    else {
     self.currentHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    }
    
    // Set the label text.
    self.currentHUD.label.text = @"Loading...";

    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    self.currentHUD.contentColor = [UIColor greenColor];
    self.currentHUD.label.textColor = [UIColor whiteColor];
    self.currentHUD.backgroundView.color = [UIColor clearColor];
    self.currentHUD.bezelView.color = [UIColor clearColor];
    
}

#pragma mark - getters and setters


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
