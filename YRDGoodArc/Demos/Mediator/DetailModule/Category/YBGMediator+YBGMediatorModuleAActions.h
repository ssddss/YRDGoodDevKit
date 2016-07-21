//
//  YBGMediator+YBGMediatorModuleAActions.h
//  YBGMediator
//
//  Created by casa on 16/3/13.
//  Copyright © 2016年 casa. All rights reserved.
//

#import "YBGMediator.h"
#import <UIKit/UIKit.h>

@interface YBGMediator (YBGMediatorModuleAActions)

- (UIViewController *)YBGMediator_viewControllerForDetail;
- (void)YBGMediator_showAlertWithMessage:(NSString *)message cancelAction:(void(^)(NSDictionary *info))cancelAction confirmAction:(void(^)(NSDictionary *info))confirmAction;
- (void)YBGMediator_presentImage:(UIImage *)image;

@end
