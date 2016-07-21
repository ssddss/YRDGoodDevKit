//
//  YBGMediator+YBGMediatorModuleDefaultActions.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/20.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGMediator+YBGMediatorModuleDefaultActions.h"
NSString * const kYBGMediatorTargetDefault = @"Default";

NSString * const kYBGMediatorActionNativeErrorViewController = @"nativeErrorViewController";

@implementation YBGMediator (YBGMediatorModuleDefaultActions)

- (UIViewController *)YBGMediator_viewControllerErrorDefault {
    UIViewController *viewController = [self performTarget:kYBGMediatorTargetDefault action:kYBGMediatorActionNativeErrorViewController params:nil];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
    
}
@end
