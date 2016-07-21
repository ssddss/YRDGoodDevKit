//
//  YBGHomeDataController.m
//  YRDGoodArc
//
//  Created by yurongde on 16/7/21.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGHomeDataController.h"
#import "YiBaoGaoApiManager.h"
#import "YBGHomeListReformer.h"
@interface YBGHomeDataController()
@property (nonatomic, strong ,nonnull) NSArray<SDSubject *> *subjects;
@property (nonatomic) YiBaoGaoApiManager *apiManager;

@end
@implementation YBGHomeDataController
- (void)requestSubjectDatcWithCallBack:(YBGDataControllerCompletionCallback)callBack {
    @weakify(self)
    [self.apiManager startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
        @strongify(self)
        NSLog(@"blockChange1");
        NSArray *arr = [manager fetchDataWithReformer:[[YBGHomeListReformer alloc]init]];
        
        self.subjects = arr;
        callBack(nil);
    } failure:^(YRDAPIBaseManager *manager) {
        
    }];

}
- (YiBaoGaoApiManager *)apiManager {
    if (!_apiManager) {
        _apiManager = [[YiBaoGaoApiManager alloc]init];
    }
    return _apiManager;
}
@end
