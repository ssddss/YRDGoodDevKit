//
//  YBGBaseDataController.h
//  YRDGoodArc
//
//  Created by yurongde on 16/7/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^YBGDataControllerCompletionCallback)( NSError * _Nullable error);
typedef void (^YBGDataControllerDataCallback)( NSError * _Nullable error,id _Nullable data);
@interface YBGBaseDataController : NSObject

@end
