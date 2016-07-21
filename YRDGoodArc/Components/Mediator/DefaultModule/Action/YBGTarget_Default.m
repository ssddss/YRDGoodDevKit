//
//  YBGTarget_Default.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/20.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGTarget_Default.h"
#import "YBGMediatorErrorViewController.h"

@implementation YBGTarget_Default
- (UIViewController *)Action_nativeErrorViewController:(NSDictionary *)params {
    
    YBGMediatorErrorViewController *errorVC = [[YBGMediatorErrorViewController alloc]init];
    return errorVC;
}
@end
