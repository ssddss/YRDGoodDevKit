//
//  YBGHomeDataController.h
//  YRDGoodArc
//
//  Created by yurongde on 16/7/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGBaseDataController.h"
@class SDSubject;
@interface YBGHomeDataController : YBGBaseDataController

- (void)requestSubjectDatcWithCallBack:(nonnull YBGDataControllerCompletionCallback)callBack;
@property (nonatomic, strong ,nonnull, readonly) NSArray<SDSubject *> *subjects;
@end
