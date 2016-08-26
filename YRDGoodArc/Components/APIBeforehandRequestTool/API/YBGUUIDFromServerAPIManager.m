//
//  YBGUUIDFromServerAPIManager.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/25.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGUUIDFromServerAPIManager.h"
#import "YBGRequestParamsTool.h"
#import "Base64.h"
#import "RSA.h"

@implementation YBGUUIDFromServerAPIManager
- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.validator = self;
    self.paramSource = self;
    return self;
}
#pragma mark - YRDAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(YRDAPIBaseManager *)manager {
//    用base64编码
    NSString *aesKeyBase64Encoding = [[YBGRequestParamsTool sharedRequestParamsTool].AESEncryptionKey ybg_base64EncodedString];
    
    return @{@"sk":aesKeyBase64Encoding};
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
    return YRDAPIManagerRequestTypeRestPost;
}
@end
