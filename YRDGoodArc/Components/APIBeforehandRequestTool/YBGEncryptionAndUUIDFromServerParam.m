//
//  YBGEngyptionAndUUIDFromServerParam.m
//  YRDGoodArc
//
//  Created by yurongde on 16/8/25.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import "YBGEncryptionAndUUIDFromServerParam.h"
#import "NSArray+YYAdd.h"
@implementation YBGEncryptionAndUUIDFromServerParam
- (NSString *)AESEncryptionKey {
    if (!_AESEncryptionKey) {
        _AESEncryptionKey = [self generateAESEncryptionKey];
    }
    return _AESEncryptionKey;
}
/**
 *  生成AES密钥
 *
 *  @return <#return value description#>
 */
- (NSString *)generateAESEncryptionKey {
    NSMutableString *encryptionKey = [NSMutableString string];
    NSArray *keys = [self encryptionKeys];
//    要16个字符组成密钥,16个字节是128位
    for (NSInteger i = 0; i < 16; i++) {
        [encryptionKey appendString:[keys randomObject]];
    }
    return [encryptionKey copy];
}
/**
 *  密钥的获取地方
 *
 *  @return <#return value description#>
 */
- (NSArray *)encryptionKeys {
    NSString *keys = @"0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
    return [keys componentsSeparatedByString:@","];
}
@end
