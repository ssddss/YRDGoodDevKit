//
//  YBGRestfulDeleteApiManager.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/8.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGRestfulDeleteApiManager.h"

@implementation YBGRestfulDeleteApiManager
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.paramSource = self;
    self.validator = self;
    
    return self;
}
#pragma makr -YRDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(YRDAPIBaseManager *)manager {
    return @{@"token":@"123456",@"userId":@"123"};
}
#pragma mark - YRDApiValidator
- (BOOL)manager:(YRDAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data {
    
    return YES;
}
- (BOOL)manager:(YRDAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data {
    NSLog(@"response : %@",data);
    return YES;
}
#pragma mark - APIManager
- (NSString *)methodName {
    return @"mobileapi/open/test/delete?userId=123";
}
- (NSString *)serviceType {
    return @"YBGRestfulTestService";
}
- (YRDAPIManagerRequestType)requestType {
    return YRDAPIManagerRequestTypeRestDelete;
}
- (BOOL)shouldRefreshLoadingRequest {
    return NO;
}

@end
