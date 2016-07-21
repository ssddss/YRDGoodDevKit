//
//  YBGHomeListReformer.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGHomeListReformer.h"
#import "SDSubject.h"
#import "YiBaoGaoApiManager.h"
@implementation YBGHomeListReformer
- (id)manager:(YRDAPIBaseManager *)manager reformData:(NSDictionary *)data {
    if ([manager isKindOfClass:[YiBaoGaoApiManager class]]) {
        NSDictionary *dict = data[@"result"];
        return [NSArray yy_modelArrayWithClass:[SDSubject class] json:dict];
        
    }
    return nil;
}
@end
