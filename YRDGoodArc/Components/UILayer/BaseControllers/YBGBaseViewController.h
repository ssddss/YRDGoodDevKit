//
//  YBGBaseViewController.h
//  YRDGoodArc
//
//  Created by yurongde on 16/7/26.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YBGBaseViewController : UIViewController

@property (nonatomic, readonly) NSString *pageId;/**< 页面的id*/
/**
 *  显示本Controller显示位置的加载动画
 */
- (void)showLoadingHUDInView;
/**
 *  显示全屏的加载动画，tabbar 跟 navi都不能点击
 */
- (void)showLoadingHUDFullScreen;
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
