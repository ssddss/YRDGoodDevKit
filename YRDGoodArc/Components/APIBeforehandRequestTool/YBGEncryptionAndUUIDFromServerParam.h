//
//  YBGEngyptionAndUUIDFromServerParam.h
//  YRDGoodArc
//
//  Created by yurongde on 16/8/25.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBGEncryptionAndUUIDFromServerParam : NSObject
@property (nonatomic, copy) NSString *RSAEncryptionPublicKey;/**< RSA非对称加密的公钥*/
@property (nonatomic, copy) NSString *AESEncryptionKey;/**< AES加密的密钥*/
@property (nonatomic, copy) NSString *deviceUUIDFromServer;/**< 从后台获取得到的deviceUUID,没有这个id其他的接口无法正常工作*/
@end
