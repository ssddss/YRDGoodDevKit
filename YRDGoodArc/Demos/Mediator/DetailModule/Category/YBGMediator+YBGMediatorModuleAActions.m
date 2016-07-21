//
//  YBGMediator+YBGMediatorModuleAActions.m
//  YBGMediator
//
//  Created by casa on 16/3/13.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "YBGMediator+YBGMediatorModuleAActions.h"

NSString * const kYBGMediatorTargetA = @"A";

NSString * const kYBGMediatorActionNativFetchDetailViewController = @"nativeFetchDetailViewController";
NSString * const kYBGMediatorActionNativePresentImage = @"nativePresentImage";
NSString * const kYBGMediatorActionNativeNoImage = @"nativeNoImage";
NSString * const kYBGMediatorActionShowAlert = @"showAlert";

@implementation YBGMediator (YBGMediatorModuleAActions)

- (UIViewController *)YBGMediator_viewControllerForDetail
{
    UIViewController *viewController = [self performTarget:kYBGMediatorTargetA
                                                    action:kYBGMediatorActionNativFetchDetailViewController
                                                    params:@{@"key":@"haha"}];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

- (void)YBGMediator_presentImage:(UIImage *)image
{
    if (image) {
        [self performTarget:kYBGMediatorTargetA
                     action:kYBGMediatorActionNativePresentImage
                     params:@{@"image":image}];
    } else {
        // 这里处理image为nil的场景，如何处理取决于产品
        [self performTarget:kYBGMediatorTargetA
                     action:kYBGMediatorActionNativeNoImage
                     params:@{@"image":[UIImage imageNamed:@"noImage"]}];
    }
}

- (void)YBGMediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction
{
    NSMutableDictionary *paramsToSend = [[NSMutableDictionary alloc] init];
    if (message) {
        paramsToSend[@"message"] = message;
    }
    if (cancelAction) {
        paramsToSend[@"cancelAction"] = cancelAction;
    }
    if (confirmAction) {
        paramsToSend[@"confirmAction"] = confirmAction;
    }
    [self performTarget:kYBGMediatorTargetA
                 action:kYBGMediatorActionShowAlert
                 params:paramsToSend];
}

@end
