//
//  YBGRSAEncryptionKeyAPIManager.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/25.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGRSAEncryptionKeyAPIManager.h"

@implementation YBGRSAEncryptionKeyAPIManager

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
- (NSString *)methodName {
    return @"mobileapi/open/security/asym/key";
}
- (NSString *)serviceType {
    return @"YBGEncryptionService";
}
- (YRDAPIManagerRequestType)requestType {
    return YRDAPIManagerRequestTypeRestGet;
}
@end
