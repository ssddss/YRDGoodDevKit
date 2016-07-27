//
//  YBGBaseViewController.h
//  YRDGoodArc
//
//  Created by yurongde on 16/7/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YBGBaseViewController : UIViewController
/**
 *  显示加载动画
 */
- (void)showLoadingHUD;
/**
 *  隐藏HUD
 */
- (void)hideHUD;
/**
 *  显示提示内容
 *
 *  @param text 
 */
- (void)showHUDWithText:(NSString *)text;
@end
