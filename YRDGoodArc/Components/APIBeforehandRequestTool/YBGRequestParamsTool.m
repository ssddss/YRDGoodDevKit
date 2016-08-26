//
//  YBGRequestParamsTool.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/25.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGRequestParamsTool.h"
#import "YBGRSAEncryptionKeyAPIManager.h"
#import "YBGUUIDFromServerAPIManager.h"
#import <YYKit/YYKit.h>
#import "NSString+Encryption.h"
#import "Base64.h"

#import "YBGEncryptionAndUUIDFromServerParam.h"
@interface YBGRequestParamsTool()
@property (nonatomic) YBGEncryptionAndUUIDFromServerParam *params;
@property (nonatomic) YBGRSAEncryptionKeyAPIManager *rsaEncryptionPublicAPI;
@property (nonatomic) YBGUUIDFromServerAPIManager *deviceUUIDAPI;
@end
@implementation YBGRequestParamsTool
+ (instancetype)sharedRequestParamsTool
{
    static YBGRequestParamsTool *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.params = [[YBGEncryptionAndUUIDFromServerParam alloc]init];
    });
    
    return instance;
}
#pragma mark - public methods
/*
 {
 code = 0;
 data = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCAYYAF5a/+WuXTf3COIrH/Rtxy5qN3fr5hIlIAo3KpfudqooJuG4KpCjscpvmUvIelpbL88qPvqZn4yswnGPQqCyUKCzvaQ4LwxvyyMiGBhITYH2oELV4rZm9IJplbU7gqpkz/5o/Ysqe/qYaMUblxjt4f3X+FBFVBOCHRJ+m6YQIDAQAB";
 msg = ok;
 }

 */
- (void)refreshRequestParams {
    @weakify(self);
    [self.rsaEncryptionPublicAPI startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
        @strongify(self);
        NSLog(@"获取成功");
        NSDictionary *dict = [manager fetchDataWithReformer:nil];
        if (dict[@"code"] && [dict[@"code"] integerValue] == 0) {
            NSString *rsaPublicKey = dict[@"data"];
            NSLog(@"rsaPublicKey = %@",rsaPublicKey);
            self.params.RSAEncryptionPublicKey = rsaPublicKey;
            
            [self.deviceUUIDAPI startWithCompletionBlockWithSuccess:^(YRDAPIBaseManager *manager) {
                NSDictionary *deviceUUIDdict = [manager fetchDataWithReformer:nil];

                if (deviceUUIDdict[@"code"] && [deviceUUIDdict[@"code"] integerValue] == 0) {
                    NSString *rsaDeviceUUID = deviceUUIDdict[@"data"];
                    NSLog(@"rsaEncrypt deviceUUID = %@",rsaDeviceUUID);
                   NSString *deviceUUID = [rsaDeviceUUID aesECBBase64StringDecryptWithKey:self.params.AESEncryptionKey];
                    self.params.deviceUUIDFromServer = deviceUUID;
                    NSLog(@"device aes decrypt:%@,rsaKey:%@,AesKey:%@",self.params.deviceUUIDFromServer,self.params.RSAEncryptionPublicKey,self.params.AESEncryptionKey);
                }
            } failure:^(YRDAPIBaseManager *manager) {
                
            }];
        }
        
        
    } failure:^(YRDAPIBaseManager *manager) {
        NSLog(@"获取失败");
    }];
}
#pragma mark - getters and setters
- (NSString *)RSAEncryptionPublicKey {
    return self.params.RSAEncryptionPublicKey;
}
- (NSString *)AESEncryptionKey {
    return self.params.AESEncryptionKey;
}
- (NSString *)deviceUUIDFromServer {
    return self.params.deviceUUIDFromServer;
}

- (YBGRSAEncryptionKeyAPIManager *)rsaEncryptionPublicAPI {
    if (!_rsaEncryptionPublicAPI) {
        _rsaEncryptionPublicAPI = [[YBGRSAEncryptionKeyAPIManager alloc]init];
    }
    return _rsaEncryptionPublicAPI;
}
- (YBGUUIDFromServerAPIManager *)deviceUUIDAPI {
    if (!_deviceUUIDAPI) {
        _deviceUUIDAPI = [[YBGUUIDFromServerAPIManager alloc]init];
    }
    return _deviceUUIDAPI;
}
@end
