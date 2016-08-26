//
//  YBGRequestParamsTool.h
//  YRDGoodArc
//
//  Created by yurongde on 16/8/25.
//  Copyright © 2016年 yurongde. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YBGRequestParamsTool : NSObject
+ (instancetype)sharedRequestParamsTool;
@property (nonatomic, readonly) NSString *RSAEncryptionPublicKey;/**< RSA非对称加密的公钥*/
@property (nonatomic, readonly) NSString *AESEncryptionKey;/**< AES加密的密钥*/
@property (nonatomic, readonly) NSString *deviceUUIDFromServer;/**< 从后台获取得到的deviceUUID,没有这个id其他的接口无法正常工作*/

/**
 *  更新后台的RSA公钥，更新设备在后台的唯一UUID
 */
- (void)refreshRequestParams;
@end
