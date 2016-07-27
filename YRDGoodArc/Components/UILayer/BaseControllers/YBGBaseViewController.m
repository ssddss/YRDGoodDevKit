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
- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}
#pragma mark - delegates

#pragma mark - Notifications

#pragma mark - event response

#pragma mark - public methods
- (void)showLoadingHUD {
    
}
- (void)hideHUD {
    
}
- (void)showHUDWithText:(NSString *)text {
    if (self.currentHUD) {
//        self.currentH
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = NSLocalizedString(@"Message here!", @"HUD message title");
    // Move to bottm center.
    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    hud.label.textColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    [hud hideAnimated:YES afterDelay:3.f];

}
#pragma mark - private methods

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
