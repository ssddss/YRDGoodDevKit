//
//  YBGRestfulGetApiManager.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/8.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGRestfulGetApiManager.h"

@implementation YBGRestfulGetApiManager
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.validator = self;
    
    return self;
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
    return @"mobileapi/open/test/get";
}
- (NSString *)serviceType {
    return @"YBGRestfulTestService";
}
- (YRDAPIManagerRequestType)requestType {
    return YRDAPIManagerRequestTypeRestGet;
}
- (BOOL)shouldRefreshLoadingRequest {
    return NO;
}
@end
